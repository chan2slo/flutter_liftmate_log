import 'package:drift/drift.dart';

class ExerciseModel extends Table {
  IntColumn get index => integer().autoIncrement()();
  TextColumn get bodyPart => text()();
  TextColumn get exerciseName => text()();
}
