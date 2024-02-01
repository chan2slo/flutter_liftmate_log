import 'package:lift_mate/database/drift_database.dart';

class FitnessLogWithExercise {
  final FitnessLogModelData fitnessLog;
  final ExerciseModelData exercise;

  FitnessLogWithExercise({
    required this.fitnessLog,
    required this.exercise,
  });
}

class DateExerciseLog {
  final DateTime date;
  final String bodyPart;
  final String exerciseName;

  DateExerciseLog({
    required this.date,
    required this.bodyPart,
    required this.exerciseName,
  });
}
