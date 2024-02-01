import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:lift_mate/component/insert_lift_set_row.dart';
import 'package:lift_mate/component/lift_set_row.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:lift_mate/database/drift_database.dart';
import 'package:lift_mate/dialog/show_alert.dart';
import 'package:provider/provider.dart';

class SliableRow extends StatelessWidget {
  final bool lastRow;
  final int index;
  final int set;
  final double kgWeight;
  final double lbWeight;
  final String unit;
  final int reps;

  const SliableRow({
    required this.lastRow,
    required this.index,
    required this.set,
    required this.kgWeight,
    required this.lbWeight,
    required this.unit,
    required this.reps,
    Key? key,
  }) : super(key: key);

  // late bool errorExist;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        //dismissible: DismissiblePane(onDismissed: () {}),
        children: lastRow
            ? [
                _modifySlidableAction(context),
                _deleteSlidableAction(context),
              ]
            : [_modifySlidableAction(context)],
      ),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          _copySlidableAction(context),
        ],
      ),
      child: LiftSetRow(
        set: set.toString(),
        weight:
            "${unit == 'Kg' ? kgWeight.toString() : lbWeight.toString()}"
            "$unit",
        reps: reps.toString(),
      ),
    );
  }

  Widget _modifySlidableAction(BuildContext context) {
    return SlidableAction(
      onPressed: (_) async {
        bool result =
            await showAlert2(context: context, message: "기록을 수정하시겠습니까?");
        if (result) {
          _modifyDialog(context);
        }
      },
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      icon: FontAwesomeIcons.penToSquare,
      label: 'modify',
    );
  }

  Widget _deleteSlidableAction(BuildContext context) {
    return SlidableAction(
      onPressed: (_) async {
        bool result =
            await showAlert2(context: context, message: "기록을 삭제하시겠습니까?");
        if (result) {
          await GetIt.I<LocalDatabase>().removeOneLog(index);
        }
      },
      backgroundColor: const Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'delete',
    );
  }

  Widget _copySlidableAction(BuildContext context) {
    return SlidableAction(
      onPressed: (_) async {
        bool result =
            await showAlert2(context: context, message: "해당 기록을 복사하시겠습니까?");
      },
      backgroundColor: const Color(0xFF21B7CA),
      foregroundColor: Colors.white,
      icon: Icons.copy,
      label: 'copy',
    );
  }

  void _modifyDialog(BuildContext context) {
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.width * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      InsertLiftSetRow(
                        set: set,
                        kgWeight: kgWeight,
                        lbWeight: lbWeight,
                        unit: unit,
                        reps: reps,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              double kgWeight;
                              double lbWeight;
                              String unit = Provider.of<FitnessLogProvider>(
                                      context,
                                      listen: false)
                                  .unit;
                              int reps = Provider.of<FitnessLogProvider>(
                                      context,
                                      listen: false)
                                  .reps;
                              double weight = Provider.of<FitnessLogProvider>(
                                      context,
                                      listen: false)
                                  .weight;
                              if (Provider.of<FitnessLogProvider>(context,
                                          listen: false)
                                      .unit ==
                                  "Kg") {
                                kgWeight =
                                    double.parse((weight).toStringAsFixed(2));
                                lbWeight = double.parse(
                                    (weight * 2.204623).toStringAsFixed(2));
                              } else {
                                kgWeight = double.parse(
                                    (weight * 0.453592).toStringAsFixed(2));
                                lbWeight =
                                    double.parse((weight).toStringAsFixed(2));
                              }
                              if (weight == 0.0 ||
                                  reps == 0 ||
                                  Provider.of<StateProvider>(context,
                                              listen: false)
                                          .isWeightChange ==
                                      false ||
                                  Provider.of<StateProvider>(context,
                                              listen: false)
                                          .isRepsChange ==
                                      false) {
                                showAlert(
                                    context: context,
                                    message: "무게 또는 횟수를\n 입력해주세요");
                              } else {
                                await GetIt.I<LocalDatabase>().updateFitnessLog(
                                  index,
                                  FitnessLogModelCompanion(
                                    kgWeight: Value(kgWeight),
                                    lbWeight: Value(lbWeight),
                                    unit: Value(unit),
                                    reps: Value(reps),
                                  ),
                                );
                                Provider.of<StateProvider>(context,
                                        listen: false)
                                    .initialIsChange();
                                Navigator.of(context).pop();
                              }

                            }, //onSavePressed,
                            child: const Text('입력'),
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
}
