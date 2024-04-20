import 'package:drift/drift.dart';

class FitnessLogModel extends Table {
  IntColumn get index => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get exerciseIndex => integer()();
  IntColumn get set => integer().nullable()();
  RealColumn get kgWeight => real().nullable()();
  RealColumn get lbWeight => real().nullable()();
  TextColumn get unit => text().nullable()();
  IntColumn get time => integer().nullable()();
  IntColumn get reps => integer().nullable()();
  IntColumn get order => integer()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
}

