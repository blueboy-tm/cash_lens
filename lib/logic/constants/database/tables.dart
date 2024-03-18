import 'package:drift/drift.dart';

class Account extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 3, max: 32)();
  TextColumn get description => text()();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(Constant(DateTime.now()))();
  BoolColumn get personal => boolean().withDefault(const Constant(false))();
}

class Txn extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 3, max: 32)();
  IntColumn get account =>
      integer().references(Account, #id, onDelete: KeyAction.cascade)();
  RealColumn get amount => real().withDefault(const Constant(0))();
  RealColumn get balance => real().withDefault(const Constant(0))();
  TextColumn get description => text()();
  DateTimeColumn get date => dateTime().withDefault(Constant(DateTime.now()))();
}
