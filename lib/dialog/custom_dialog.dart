import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:lift_mate/component/logging_card.dart';
import 'package:lift_mate/dialog/input_logging_dialog.dart';
import 'package:lift_mate/dialog/show_alert.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:lift_mate/database/drift_database.dart';
//import '../../test/exercise_history_screen_no_usage.dart';
import 'package:provider/provider.dart';

class CustomDialog {
  final bool modify;
  final BuildContext context;
  final ScrollController controller;

  CustomDialog(
      {required this.modify, required this.context, required this.controller});

  void customDialog() {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text('Timer 자리!')),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.95,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 1.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: InputLoggingDialog(
                            modify: modify,
                            controller: controller,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (Provider
                                  .of<StateProvider>(context,
                                  listen: false)
                                  .inputable) {
                                showAlert(
                                    context: context,
                                    message: "운동명 또는 운동부위를\n 입력해주세요");
                              } else {
                                _historyBottomSheet(context);
                              }
                            },
                            child: const Text('History'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: _onSavePressed,
                            child: const Text('입력'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if ((Provider
                                  .of<ExerciseProvider>(context,
                                  listen: false)
                                  .bodyPart !=
                                  '맨몸' &&
                                  Provider
                                      .of<StateProvider>(context,
                                      listen: false)
                                      .isWeightChange ==
                                      true) ||
                                  Provider
                                      .of<StateProvider>(context,
                                      listen: false)
                                      .isRepsChange ==
                                      true) {
                                bool result = await showAlert2(
                                    context: context,
                                    message: '데이터 입력을 완료하지 않고 나가시겠습니까?');
                                if (result) {
                                  Navigator.of(context).pop();
                                }
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('나가기'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _historyBottomSheet(BuildContext context) {
    final ScrollController controller = ScrollController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.amberAccent,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Column(
            children: [
              Container(
                height: 70,
                color: Colors.amberAccent,
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '지난 운동 기록 보기',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: StreamBuilder<List<List<Object>>>(
                    stream: GetIt.I<LocalDatabase>().watchExerciseHistory(
                        Provider
                            .of<ExerciseProvider>(context, listen: false)
                            .exerciseIndex!),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ||
                          (snapshot.hasData && snapshot.data!.isEmpty)) {
                        return const Text(
                          '입력된 데이터가 없습니다.',
                          style: TextStyle(fontSize: 18),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          // return Center(
                          //   child: Text(snapshot.data![index].toString())
                          // );
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 2.0),
                                  child: Text(
                                    '${(snapshot.data![index][0] as DateTime)
                                        .year}년 ${(snapshot
                                        .data![index][0] as DateTime)
                                        .month}월 ${(snapshot
                                        .data![index][0] as DateTime).day}일',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              LoggingCard(
                                isHistory: true,
                                controller: controller,
                                logDate: snapshot.data![index][0] as DateTime,
                                exerciseIndex: Provider
                                    .of<ExerciseProvider>(
                                    context,
                                    listen: false)
                                    .exerciseIndex!,
                                bodyPart: snapshot.data![index][1].toString(),
                                exerciseName:
                                snapshot.data![index][2].toString(),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 30,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSavePressed() {
    double kgWeight;
    double lbWeight;
    int exerciseIndex =
    Provider
        .of<ExerciseProvider>(context, listen: false)
        .exerciseIndex!;
    int order =
    Provider
        .of<FitnessLogProvider>(context, listen: false)
        .order!;


    DateTime logDate =
        Provider
            .of<FitnessLogProvider>(context, listen: false)
            .logDate;


    bool inputable =
        Provider
            .of<StateProvider>(context, listen: false)
            .inputable;



    if (inputable == true) {
      showAlert(context: context, message: "운동명 또는 운동부위를\n 입력해주세요");
    } else {
      if (Provider
          .of<ExerciseProvider>(context, listen: false)
          .bodyPart !=
          '유산소') {
        int reps = Provider
            .of<FitnessLogProvider>(context, listen: false)
            .reps;
        int set = Provider
            .of<FitnessLogProvider>(context, listen: false)
            .set;
        double weight =
            Provider
                .of<FitnessLogProvider>(context, listen: false)
                .weight;
        String unit = Provider
            .of<FitnessLogProvider>(context, listen: false)
            .unit;
        if (Provider
            .of<FitnessLogProvider>(context, listen: false)
            .unit == "Kg") {
          kgWeight = double.parse((weight).toStringAsFixed(2));
          lbWeight = double.parse((weight * 2.204623).toStringAsFixed(2));
        } else {
          kgWeight = double.parse((weight * 0.453592).toStringAsFixed(2));
          lbWeight = double.parse((weight).toStringAsFixed(2));
        }
        if (weight == 0.0 ||
            reps == 0 ||
            (Provider
                .of<ExerciseProvider>(context, listen: false)
                .bodyPart !=
                '맨몸' &&
                Provider
                    .of<StateProvider>(context, listen: false)
                    .isWeightChange ==
                    false) ||
            Provider
                .of<StateProvider>(context, listen: false)
                .isRepsChange ==
                false) {
          showAlert(context: context, message: "무게 또는 횟수를\n 입력해주세요");
        } else {
          _inputFitnessLog(
              logDate,
              exerciseIndex,
              set,
              kgWeight,
              lbWeight,
              unit,
              reps,
              order);
          Provider.of<StateProvider>(context, listen: false).initialIsChange();
          if (controller.hasClients) {
            controller.animateTo(
              controller.position.maxScrollExtent + 49,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        }
      } else {
        if (Provider
            .of<FitnessLogProvider>(context, listen: false)
            .time == 0) {
          showAlert(context: context, message: "시간을 입력해주세요");
        } else {

          int time = Provider
              .of<FitnessLogProvider>(context, listen: false)
              .time;
          if (modify) {
            _updateTime(order, time);
          } else {
            print([logDate, exerciseIndex, time, order].toString());
            _inputTime(
                logDate,
                exerciseIndex,
                time,
                order);
          }
            Navigator.pop(context);
          }
        }
      }
    }

  void _inputFitnessLog(DateTime logDate,
      int exerciseIndex,
      int set,
      double kgWeight,
      double lbWeight,
      String unit,
      int reps,
      int order) async {
    await GetIt.I<LocalDatabase>().createFitnessLog(
      FitnessLogModelCompanion(
          date: Value(logDate),
          exerciseIndex: Value(exerciseIndex),
          //memoIndex: Value(memoIndex),
          set: Value(set),
          kgWeight: Value(kgWeight),
          lbWeight: Value(lbWeight),
          unit: Value(unit),
          reps: Value(reps),
          order: Value(order)),
    );
  }

  void _inputTime(DateTime logDate,
      int exerciseIndex,
      int time,
      int order) async {
    print([logDate, exerciseIndex, time, order].toString());
    await GetIt.I<LocalDatabase>().createFitnessLog(
      FitnessLogModelCompanion(
          date: Value(logDate),
          exerciseIndex: Value(exerciseIndex),
          time: Value(time),
          order: Value(order)),
    );
  }

  void _updateTime(int order, int time) async {
    await GetIt
        .I<LocalDatabase>()
        .updateFitnessLogByOrder(
      order,
      FitnessLogModelCompanion(
        time: Value(time),
      ),
    );
  }
}


void initialValue({required BuildContext context}) {
  Provider.of<FitnessLogProvider>(context, listen: false).initialValue();
  Provider.of<ExerciseProvider>(context, listen: false).initialValue();
  Provider.of<StateProvider>(context, listen: false).initialValue();
}
