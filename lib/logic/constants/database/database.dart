import 'dart:async';
import 'dart:io';

import 'package:cash_lens/logic/dashboard/models/models.dart';
import 'package:drift/drift.dart';
import 'package:cash_lens/logic/constants/database/tables.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Account, Txn])
class Database extends _$Database {
  Database() : super(_openConnection());

  static initialize() {
    instance = Database();
  }

  static late Database instance;

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    // the LazyDatabase util lets us find the right location for the file async.
    return LazyDatabase(() async {
      // put the database file, called db.sqlite here, into the documents folder
      // for your app.
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'cash_lens.sqlite'));

      // Also work around limitations on old Android versions
      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      // Make sqlite3 pick a more suitable location for temporary files - the
      // one from the system may be inaccessible due to sandboxing.
      final cachebase = (await getTemporaryDirectory()).path;
      // We can't access /tmp on Android, which sqlite3 would try by default.
      // Explicitly tell it about the correct temporary directory.
      sqlite3.tempDirectory = cachebase;

      return NativeDatabase.createInBackground(file);
    });
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async => await customStatement(
        'PRAGMA foreign_keys = ON',
      ),
      onCreate: (m) async => await m.createAll(),
    );
  }

  // Add account object
  Future<int> addAccount(
      {required String title,
      required String description,
      DateTime? createdDate,
      bool? personal}) async {
    return await into(account).insert(
      AccountCompanion.insert(
        title: title,
        description: description,
        createdDate: Value.absentIfNull(createdDate),
        personal: Value.absentIfNull(personal),
      ),
    );
  }

  // Update account object
  Future<bool> updateAccount(
    int id, {
    String? title,
    String? description,
    DateTime? createdDate,
    bool? personal,
  }) async {
    return await update(account).replace(AccountCompanion(
      id: Value(id),
      title: Value.absentIfNull(title),
      description: Value.absentIfNull(description),
      createdDate: Value.absentIfNull(createdDate),
      personal: Value.absentIfNull(personal),
    ));
  }

  // Delete account object
  Future<int> deleteAccount(int id) async {
    return await (delete(account)..where((tbl) => tbl.id.equals(id))).go();
  }

  // return accounts list
  Future<List<AccountData>> accountList(String search) async {
    final query = select(account)
      ..where(
        (tbl) =>
            tbl.title.like('%$search%') |
            tbl.description.like(
              '%$search%',
            ),
      )
      ..orderBy([
        (tbl) => OrderingTerm(
              expression: tbl.createdDate,
              mode: OrderingMode.desc,
            ),
      ]);
    return await query.get();
  }

  // Add transaction object
  Future<int> addTransaction({
    required String title,
    required int account,
    required double amount,
    required String description,
    DateTime? date,
  }) async {
    return await into(txn).insert(
      TxnCompanion.insert(
        title: title,
        account: account,
        amount: Value(amount),
        balance: Value(await transactionSum(account: account)),
        description: description,
        date: Value.absentIfNull(date),
      ),
    );
  }

  // Update transaction object
  Future<bool> updateTransaction(
    int id, {
    String? title,
    int? account,
    double? amount,
    double? balance,
    String? description,
    DateTime? date,
  }) async {
    return await update(txn).replace(TxnCompanion(
      id: Value(id),
      title: Value.absentIfNull(title),
      account: Value.absentIfNull(account),
      amount: Value.absentIfNull(amount),
      balance: Value.absentIfNull(balance),
      description: Value.absentIfNull(description),
      date: Value.absentIfNull(date),
    ));
  }

  // Delete transaction object
  Future<int> deleteTransaction(int id) async {
    return await (delete(txn)..where((tbl) => tbl.id.equals(id))).go();
  }

  String transactionRull({int? account}) {
    String query = "FROM txn WHERE (title LIKE ? OR description LIKE ?)";
    if (account != null) {
      query += ' AND account = ?';
    }
    return query;
  }

  Future<int> transactionCount({required String search, int? account}) async {
    return (await customSelect(
      'SELECT COUNT(*) as c ${transactionRull(account: account)};',
      variables: [
        Variable('%$search%'),
        Variable('%$search%'),
        if (account != null) Variable(account),
      ],
    ).getSingle())
        .data['c'];
  }

  // return transactions list
  Future<List<TxnData>> transactionList({
    required String search,
    int? account,
    int page = 1,
    int limit = 50,
  }) async {
    final queryRull =
        '${transactionRull(account: account)} ORDER BY date DESC LIMIT $limit OFFSET ${limit * (page - 1)}';
    final result = await customSelect(
      'SELECT * $queryRull;',
      variables: [
        Variable('%$search%'),
        Variable('%$search%'),
        if (account != null) Variable(account),
      ],
    ).get();
    return List.generate(
      result.length,
      (index) {
        final data = result[index].data;
        return TxnData(
          id: data['id'],
          title: data['title'],
          account: data['account'],
          amount: data['amount'],
          balance: data['balance'],
          description: data['description'],
          date: DateTime.fromMillisecondsSinceEpoch(
            data['date'] * 1000,
          ),
        );
      },
    );
  }

  Future<double> transactionSum({int? account}) async {
    String filter = '';
    if (account != null) {
      filter = ' WHERE account = ?';
    }
    final query = await customSelect(
        'SELECT SUM(amount) as total FROM txn $filter ORDER BY date ASC;',
        variables: [
          Variable(account),
        ]).getSingle();
    return query.data['total'] ?? 0;
  }

  Future<List<AccountData>> personalAccounts() async {
    final query = select(account)..where((tbl) => tbl.personal.equals(true));
    return await query.get();
  }

  Future<IncomeCost> incomeCost(
      {required List<AccountData> accounts,
      DateTime? from,
      DateTime? to}) async {
    final sql =
        "(${List.generate(accounts.length, (index) => accounts[index].id).join(', ')})";
    String dateSql = "";
    final dateVars = <Variable<Object>>[];
    if (from != null) {
      dateSql += ' AND "date" >= ?';
      dateVars.add(Variable(from));
    }
    if (to != null) {
      dateSql += ' AND "date" <= ?';
      dateVars.add(Variable(to));
    }
    final income = (await customSelect(
          'SELECT SUM(amount) as value FROM "txn" WHERE "account" IN $sql AND "amount" > 0$dateSql;',
          variables: dateVars,
        ).getSingle())
            .data['value'] ??
        0;
    final cost = (await customSelect(
          'SELECT SUM(amount) as value FROM "txn" WHERE "account" IN $sql AND "amount" < 0$dateSql;',
          variables: dateVars,
        ).getSingle())
            .data['value'] ??
        0;

    return IncomeCost(
        income: (income.abs() as num).toDouble(),
        cost: (cost.abs() as num).toDouble());
  }
}
