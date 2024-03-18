// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AccountTable extends Account with TableInfo<$AccountTable, AccountData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
      'created_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _personalMeta =
      const VerificationMeta('personal');
  @override
  late final GeneratedColumn<bool> personal = GeneratedColumn<bool>(
      'personal', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("personal" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, createdDate, personal];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account';
  @override
  VerificationContext validateIntegrity(Insertable<AccountData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('personal')) {
      context.handle(_personalMeta,
          personal.isAcceptableOrUnknown(data['personal']!, _personalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      createdDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_date'])!,
      personal: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}personal'])!,
    );
  }

  @override
  $AccountTable createAlias(String alias) {
    return $AccountTable(attachedDatabase, alias);
  }
}

class AccountData extends DataClass implements Insertable<AccountData> {
  final int id;
  final String title;
  final String description;
  final DateTime createdDate;
  final bool personal;
  const AccountData(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdDate,
      required this.personal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['created_date'] = Variable<DateTime>(createdDate);
    map['personal'] = Variable<bool>(personal);
    return map;
  }

  AccountCompanion toCompanion(bool nullToAbsent) {
    return AccountCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      createdDate: Value(createdDate),
      personal: Value(personal),
    );
  }

  factory AccountData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      personal: serializer.fromJson<bool>(json['personal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'personal': serializer.toJson<bool>(personal),
    };
  }

  AccountData copyWith(
          {int? id,
          String? title,
          String? description,
          DateTime? createdDate,
          bool? personal}) =>
      AccountData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdDate: createdDate ?? this.createdDate,
        personal: personal ?? this.personal,
      );
  @override
  String toString() {
    return (StringBuffer('AccountData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdDate: $createdDate, ')
          ..write('personal: $personal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, createdDate, personal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.createdDate == this.createdDate &&
          other.personal == this.personal);
}

class AccountCompanion extends UpdateCompanion<AccountData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> createdDate;
  final Value<bool> personal;
  const AccountCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.personal = const Value.absent(),
  });
  AccountCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    this.createdDate = const Value.absent(),
    this.personal = const Value.absent(),
  })  : title = Value(title),
        description = Value(description);
  static Insertable<AccountData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? createdDate,
    Expression<bool>? personal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (createdDate != null) 'created_date': createdDate,
      if (personal != null) 'personal': personal,
    });
  }

  AccountCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? description,
      Value<DateTime>? createdDate,
      Value<bool>? personal}) {
    return AccountCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdDate: createdDate ?? this.createdDate,
      personal: personal ?? this.personal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (personal.present) {
      map['personal'] = Variable<bool>(personal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdDate: $createdDate, ')
          ..write('personal: $personal')
          ..write(')'))
        .toString();
  }
}

class $TxnTable extends Txn with TableInfo<$TxnTable, TxnData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TxnTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<int> account = GeneratedColumn<int>(
      'account', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES account (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _balanceMeta =
      const VerificationMeta('balance');
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
      'balance', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, account, amount, balance, description, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'txn';
  @override
  VerificationContext validateIntegrity(Insertable<TxnData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TxnData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TxnData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      balance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}balance'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $TxnTable createAlias(String alias) {
    return $TxnTable(attachedDatabase, alias);
  }
}

class TxnData extends DataClass implements Insertable<TxnData> {
  final int id;
  final String title;
  final int account;
  final double amount;
  final double balance;
  final String description;
  final DateTime date;
  const TxnData(
      {required this.id,
      required this.title,
      required this.account,
      required this.amount,
      required this.balance,
      required this.description,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['account'] = Variable<int>(account);
    map['amount'] = Variable<double>(amount);
    map['balance'] = Variable<double>(balance);
    map['description'] = Variable<String>(description);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  TxnCompanion toCompanion(bool nullToAbsent) {
    return TxnCompanion(
      id: Value(id),
      title: Value(title),
      account: Value(account),
      amount: Value(amount),
      balance: Value(balance),
      description: Value(description),
      date: Value(date),
    );
  }

  factory TxnData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TxnData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      account: serializer.fromJson<int>(json['account']),
      amount: serializer.fromJson<double>(json['amount']),
      balance: serializer.fromJson<double>(json['balance']),
      description: serializer.fromJson<String>(json['description']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'account': serializer.toJson<int>(account),
      'amount': serializer.toJson<double>(amount),
      'balance': serializer.toJson<double>(balance),
      'description': serializer.toJson<String>(description),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  TxnData copyWith(
          {int? id,
          String? title,
          int? account,
          double? amount,
          double? balance,
          String? description,
          DateTime? date}) =>
      TxnData(
        id: id ?? this.id,
        title: title ?? this.title,
        account: account ?? this.account,
        amount: amount ?? this.amount,
        balance: balance ?? this.balance,
        description: description ?? this.description,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('TxnData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('account: $account, ')
          ..write('amount: $amount, ')
          ..write('balance: $balance, ')
          ..write('description: $description, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, account, amount, balance, description, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TxnData &&
          other.id == this.id &&
          other.title == this.title &&
          other.account == this.account &&
          other.amount == this.amount &&
          other.balance == this.balance &&
          other.description == this.description &&
          other.date == this.date);
}

class TxnCompanion extends UpdateCompanion<TxnData> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> account;
  final Value<double> amount;
  final Value<double> balance;
  final Value<String> description;
  final Value<DateTime> date;
  const TxnCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.account = const Value.absent(),
    this.amount = const Value.absent(),
    this.balance = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
  });
  TxnCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int account,
    this.amount = const Value.absent(),
    this.balance = const Value.absent(),
    required String description,
    this.date = const Value.absent(),
  })  : title = Value(title),
        account = Value(account),
        description = Value(description);
  static Insertable<TxnData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? account,
    Expression<double>? amount,
    Expression<double>? balance,
    Expression<String>? description,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (account != null) 'account': account,
      if (amount != null) 'amount': amount,
      if (balance != null) 'balance': balance,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
    });
  }

  TxnCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? account,
      Value<double>? amount,
      Value<double>? balance,
      Value<String>? description,
      Value<DateTime>? date}) {
    return TxnCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      account: account ?? this.account,
      amount: amount ?? this.amount,
      balance: balance ?? this.balance,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (account.present) {
      map['account'] = Variable<int>(account.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TxnCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('account: $account, ')
          ..write('amount: $amount, ')
          ..write('balance: $balance, ')
          ..write('description: $description, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $AccountTable account = $AccountTable(this);
  late final $TxnTable txn = $TxnTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [account, txn];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('account',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('txn', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}
