import 'package:drift/drift.dart';

class MemoModel extends Table {
  IntColumn get index => integer().autoIncrement()();
  IntColumn get order => integer()();
  TextColumn get memo => text()();
}
