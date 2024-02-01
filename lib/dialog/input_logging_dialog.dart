import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lift_mate/component/slidable_row.dart';
import 'package:lift_mate/component/exercise_name.dart';
import 'package:lift_mate/component/insert_lift_set_row.dart';
import 'package:lift_mate/component/lift_set_row.dart';
import 'package:lift_mate/component/time_buttom.dart';
import 'package:lift_mate/dialog/show_alert.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:lift_mate/database/drift_database.dart';
import 'package:lift_mate/model/fitnesslog_with_exercise.dart';
import 'package:provider/provider.dart';

class InputLoggingDialog extends StatefulWidget {
  final bool modify;
  final ScrollController controller;

  const InputLoggingDialog(
      {required this.controller, required this.modify, Key? key})
      : super(key: key);

  @override
  State<InputLoggingDialog> createState() => _InputLoggingDialogState();
}

class _InputLoggingDialogState extends State<InputLoggingDialog> {
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.modify) {
      Provider.of<StateProvider>(context, listen: false).alreadyInput = true;
    }
    return Column(
      children: [
        const SizedBox(
          height: 12.0,
        ),
        ExerciseName(
          modify: widget.modify,
          parentState: onPressedExerciseButton,
          inputable:
              Provider.of<StateProvider>(context, listen: false).inputable,
          alreadyInput:
              Provider.of<StateProvider>(context, listen: false).alreadyInput,
          formKey1: formKey1,
        ),
        const SizedBox(
          height: 8.0,
        ),
        (Provider.of<StateProvider>(context, listen: false).inputable &&
                !Provider.of<StateProvider>(context, listen: false)
                    .alreadyInput)
            ? const Expanded(
                child: Center(
                  child: Text(
                    '운동부위와 운동명을 확정해주세요.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            : Provider.of<ExerciseProvider>(context, listen: false).bodyPart ==
                    '유산소'
                ? InsertTime(
                    modify: widget.modify,
                  )
                : ListViewRow(
                    controller: widget.controller,
                  ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  void onPressedExerciseButton() async {
    if (Provider.of<StateProvider>(context, listen: false).inputable == true) {
      formKey1.currentState!.save();
      String? exerciseName =
          Provider.of<ExerciseProvider>(context, listen: false).exerciseName;
      String bodyPart =
          Provider.of<ExerciseProvider>(context, listen: false).bodyPart;

      List<List<Object>> selectedDateExercise = await GetIt.I<LocalDatabase>()
          .getExerciseSortDate(
              Provider.of<FitnessLogProvider>(context, listen: false).logDate);
      // 데이터 입력 정확한지 확인
      if (exerciseName == null || exerciseName.isEmpty) {
        showAlert(context: context, message: "운동 이름을 입력해주세요");
      } else if (bodyPart == "---") {
        showAlert(context: context, message: "운동 부위를 선택해주세요");
      } else if (selectedDateExercise
          .map((e) => e.toString())
          .contains([bodyPart, exerciseName].toString())) {
        showAlert(context: context, message: "해당 날짜에\n동일한 운동이 존재합니다.");
      } else {
        // exercise 테이블에 이미 존재하는 운동부위, 운동명인지 확인하고 존재하지 않는다면 데이터 삽입
        await confirmExercise();
        // 우선순위 받아오기
        if (!widget.modify) {
          int? exOrder = await _getMaxOrder();
          if (exOrder == null) {
            Provider.of<FitnessLogProvider>(context, listen: false).order = 1;
          } else {
            Provider.of<FitnessLogProvider>(context, listen: false).order =
                exOrder + 1;
          }
        } else {
          int? savedOrder = await GetIt.I<LocalDatabase>().getOrder(
              Provider.of<FitnessLogProvider>(context, listen: false).logDate,
              Provider.of<ExerciseProvider>(context, listen: false)
                  .exExerciseIndex!);
          Provider.of<FitnessLogProvider>(context, listen: false).order =
              savedOrder;
        }

        if (Provider.of<StateProvider>(context, listen: false).alreadyInput) {
          await GetIt.I<LocalDatabase>().updateFitnessLogByOrder(
            Provider.of<FitnessLogProvider>(context, listen: false).order!,
            FitnessLogModelCompanion(
              exerciseIndex: Value(
                  Provider.of<ExerciseProvider>(context, listen: false)
                      .exerciseIndex!),
            ),
          );
        }
        setState(() {
          Provider.of<StateProvider>(context, listen: false).inputable = false;
          Provider.of<StateProvider>(context, listen: false).alreadyInput =
              true;
        });
      }
    } else if (Provider.of<StateProvider>(context, listen: false).inputable ==
        false) {
      bool result =
          await showAlert2(context: context, message: "운동명을 수정하시겠습니까?");

      if(result){
        setState(() {
          Provider.of<ExerciseProvider>(context, listen: false).exExerciseIndex =
              Provider.of<ExerciseProvider>(context, listen: false).exerciseIndex;
          Provider.of<ExerciseProvider>(context, listen: false).exBodyPart =
              Provider.of<ExerciseProvider>(context, listen: false).bodyPart;
          Provider.of<StateProvider>(context, listen: false).inputable = true;
        });
      }
    }
  }

  Future<int?> _getMaxOrder() async {
    int? result = await GetIt.I<LocalDatabase>().getMaxOrder();
    return result;
  }

  Future<void> confirmExercise() async {
    String exerciseName =
        Provider.of<ExerciseProvider>(context, listen: false).exerciseName!;
    String bodyPart =
        Provider.of<ExerciseProvider>(context, listen: false).bodyPart;
    var result = await GetIt.I<LocalDatabase>()
        .confirmExerciseName(bodyPart, exerciseName);
    if (result == null) {
      print('1차 null');
      _inputExercise();
      var result2 = await GetIt.I<LocalDatabase>()
          .confirmExerciseName(bodyPart, exerciseName);
      print('2차는? ${result2}');
      Provider.of<ExerciseProvider>(context, listen: false).exerciseIndex =
          result2!.index;
    } else {
      Provider.of<ExerciseProvider>(context, listen: false).exerciseIndex =
          result.index;
    }
  }

  void _inputExercise() async {
    await GetIt.I<LocalDatabase>().createExercise(
      ExerciseModelCompanion(
        bodyPart: Value(
            Provider.of<ExerciseProvider>(context, listen: false).bodyPart),
        exerciseName: Value(
            Provider.of<ExerciseProvider>(context, listen: false)
                .exerciseName!),
      ),
    );
    Future.delayed(const Duration(milliseconds: 10000), () {});
  }
}

class ListViewRow extends StatefulWidget {
  final ScrollController controller;

  const ListViewRow({required this.controller, Key? key}) : super(key: key);

  @override
  State<ListViewRow> createState() => _ListViewRowState();
}

class _ListViewRowState extends State<ListViewRow> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const LiftSetRow(isTitle: true, set: '세트', weight: '무게', reps: '횟수'),
          Expanded(
            child: StreamBuilder<List<FitnessLogWithExercise>>(
              stream: GetIt.I<LocalDatabase>().watchSortOfExercisName(
                Provider.of<FitnessLogProvider>(context, listen: false).logDate,
                Provider.of<ExerciseProvider>(context, listen: false)
                    .exerciseIndex!,
              ),
              builder: (context, snapshot) {
                //Provider.of<StateProvider>(context, listen: false).controller = ScrollController();
                if (!snapshot.hasData ||
                    (snapshot.hasData && snapshot.data!.isEmpty)) {
                  return Column(
                    children: const [
                      InsertLiftSetRow(
                        set: 1,
                        kgWeight: 0.0,
                        lbWeight: 0.0,
                        unit: 'Kg',
                        reps: 0,
                      ),
                    ],
                  );
                } else {
                  return ListView.separated(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    controller: widget.controller,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == snapshot.data!.length) {
                        return InsertLiftSetRow(
                          set: index + 1,
                          kgWeight:
                              snapshot.data![index - 1].fitnessLog.kgWeight!,
                          lbWeight:
                              snapshot.data![index - 1].fitnessLog.lbWeight!,
                          unit: snapshot.data![index - 1].fitnessLog.unit!,
                          reps: snapshot.data![index - 1].fitnessLog.reps!,
                        );
                      } else {
                        return SliableRow(
                          lastRow:
                              index == snapshot.data!.length - 1 ? true : false,
                          index: snapshot.data![index].fitnessLog.index,
                          set: index + 1,
                          kgWeight: snapshot.data![index].fitnessLog.kgWeight!,
                          lbWeight: snapshot.data![index].fitnessLog.lbWeight!,
                          unit: snapshot.data![index].fitnessLog.unit!,
                          reps: snapshot.data![index].fitnessLog.reps!,
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 0);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
