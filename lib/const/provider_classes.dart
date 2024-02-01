import 'package:flutter/material.dart';
import 'package:lift_mate/model/fitnesslog_with_exercise.dart';


class FitnessLogProvider with ChangeNotifier {
  int set = 1;
  double weight = 0.0;
  String unit = 'Kg';
  int reps = 0;
  int time = 0;
  DateTime logDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  int? order;

  // void increaseSet(){
  //   set++;
  //   notifyListeners();
  // }

  void initialValue() {
    set = 1;
    weight = 0.0;
    unit = 'Kg';
    reps = 0;
    order = null;
    time = 0;
    notifyListeners();
  }

  void changeWeightUnit(double newWeight, String newUnit) {
    weight = newWeight;
    unit = newUnit;
    notifyListeners();
  }
}

class ExerciseProvider with ChangeNotifier {
  int? exerciseIndex;
  String bodyPart = '---';
  String? exerciseName;
  int? exExerciseIndex;
  String? exBodyPart;

  void initialValue() {
    exerciseIndex = null;
    bodyPart = '---';
    exerciseName = null;
    exExerciseIndex = null;
    exBodyPart = null;
    notifyListeners();
  }
}

enum DataType { weight, reps }

class StateProvider with ChangeNotifier {
  bool inputable = true;
  bool alreadyInput = false;
  bool isWeightChange = false;
  bool isRepsChange = false;

  void initialValue() {
    inputable = true;
    alreadyInput = false;
    isWeightChange = false;
    isRepsChange = false;
    notifyListeners();
  }

  void isChangeTrue({required DataType dataType}) {
    if (dataType == DataType.weight) {
      isWeightChange = true;
    } else if (dataType == DataType.reps) {
      isRepsChange = true;
    }
    notifyListeners();
  }

  void initialIsChange() {
    isWeightChange = false;
    isRepsChange = false;
    notifyListeners();
  }
}
