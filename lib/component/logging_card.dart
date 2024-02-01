import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:lift_mate/component/slidable_row.dart';
import 'package:lift_mate/component/lift_set_row.dart';
import 'package:lift_mate/component/time_buttom.dart';
import 'package:lift_mate/dialog/show_alert.dart';
import 'package:lift_mate/dialog/custom_dialog.dart';
import 'package:lift_mate/database/drift_database.dart';
import 'package:lift_mate/model/fitnesslog_with_exercise.dart';
import 'package:lift_mate/screen/logging_screen.dart';
import 'package:provider/provider.dart';
import '../const/provider_classes.dart';

class LoggingCard extends StatefulWidget {
  final bool isHistory;
  final ScrollController controller;
  final DateTime logDate;
  final int exerciseIndex;
  final String bodyPart;
  final String exerciseName;

  const LoggingCard(
      {required this.isHistory,
      required this.controller,
      required this.logDate,
      required this.exerciseIndex,
      required this.bodyPart,
      required this.exerciseName,
      Key? key})
      : super(key: key);

  @override
  State<LoggingCard> createState() => _LoggingCardState();
}

class _LoggingCardState extends State<LoggingCard> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  if (widget.isHistory)
                    SizedBox(
                      height: 15.0,
                    ),
                  if (!widget.isHistory)
                    Container(
                      //color: Colors.yellow,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: const CircleAvatar(
                                backgroundColor: Colors.indigo,
                                radius: 12,
                                child: Icon(
                                  FontAwesomeIcons.penToSquare,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              onPressed: () async {
                                int? order = await GetIt.I<LocalDatabase>()
                                    .getOrder(widget.logDate, widget.exerciseIndex);
                                String? memo = await GetIt.I<LocalDatabase>().getMemo(order!);
                                _showMemoDialog(memo);
                              }),
                          IconButton(
                            icon: const CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 12,
                              child: Icon(
                                //FontAwesomeIcons.penToSquare,
                                FontAwesomeIcons.wrench,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            onPressed: () async {
                              bool result = await showAlert2(
                                  context: context, message: "기록을 수정하시겠습니까?");
                              if (result) {
                                initialValue(context: context);
                                Provider.of<StateProvider>(context,
                                        listen: false)
                                    .inputable = false;
                                Provider.of<ExerciseProvider>(context,
                                        listen: false)
                                    .bodyPart = widget.bodyPart;
                                Provider.of<ExerciseProvider>(context,
                                        listen: false)
                                    .exerciseName = widget.exerciseName;
                                Provider.of<ExerciseProvider>(context,
                                        listen: false)
                                    .exerciseIndex = widget.exerciseIndex;
                                Provider.of<FitnessLogProvider>(context,
                                            listen: false)
                                        .order =
                                    await GetIt.I<LocalDatabase>().getOrder(
                                        widget.logDate, widget.exerciseIndex);
                                if (widget.bodyPart == '유산소') {
                                  Provider.of<FitnessLogProvider>(context,
                                              listen: false)
                                          .time =
                                      (await GetIt.I<LocalDatabase>().getTime(
                                    Provider.of<FitnessLogProvider>(context,
                                            listen: false)
                                        .logDate,
                                    Provider.of<ExerciseProvider>(context,
                                            listen: false)
                                        .exerciseIndex!,
                                      ))!;
                                }
                                CustomDialog(
                                        modify: true,
                                        context: context,
                                        controller: widget.controller)
                                    .customDialog();
                              } else {}
                            },
                          ),
                          IconButton(
                            icon: const CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 12,
                              child: Icon(
                                FontAwesomeIcons.trashCan,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            onPressed: () async {
                              bool result = await showAlert2(
                                  context: context, message: "기록을 삭제하시겠습니까?");
                              if (result) {
                                int? order = await GetIt.I<LocalDatabase>()
                                    .getOrder(
                                        widget.logDate, widget.exerciseIndex);
                                await GetIt.I<LocalDatabase>()
                                    .removeBodyPartLog(order!);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  _exerciseNameInfo(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (widget.bodyPart == '유산소')
                    FutureBuilder(
                        future: GetIt.I<LocalDatabase>()
                            .getTime(widget.logDate, widget.exerciseIndex),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // 로딩 중 상태일 때 보여줄 로딩 인디케이터 반환
                            return CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            print("snapshotData: ${snapshot.data}");
                            return InsertTime(
                              time: snapshot.data!,
                              isViewer: true,
                            );
                          }
                          // 데이터 로딩에 실패한 경우 에러 메시지 출력 등의 처리를 수행할 수 있습니다.
                          return Text('데이터 로딩에 실패했습니다.');
                        }),
                  if (widget.bodyPart != '유산소')
                    Expanded(
                      child: Column(
                        children: [
                          const LiftSetRow(
                              isTitle: true,
                              set: '세트',
                              weight: '무게',
                              reps: '횟수'),
                          Expanded(
                            child: StreamBuilder<List<FitnessLogWithExercise>>(
                              stream: GetIt.I<LocalDatabase>()
                                  .watchSortOfExercisName(
                                      widget.logDate, widget.exerciseIndex),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    (snapshot.hasData &&
                                        snapshot.data!.isEmpty)) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        '입력된 데이터가 없습니다.',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Scrollbar(
                                    //isAlwaysShown: true,
                                    thumbVisibility: true,
                                    controller: _controller,
                                    child: ListView.separated(
                                      controller: _controller,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      //controller: widget.controller,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        //itemCount = snapshot.data!.length;
                                        return LiftSetRow(
                                          set: snapshot
                                              .data![index].fitnessLog.set
                                              .toString(),
                                          weight:
                                              "${snapshot.data![index].fitnessLog.unit == 'Kg' ? snapshot.data![index].fitnessLog.kgWeight.toString() : snapshot.data![index].fitnessLog.lbWeight.toString()}"
                                              "${snapshot.data![index].fitnessLog.unit}",
                                          reps: snapshot
                                              .data![index].fitnessLog.reps
                                              .toString(),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(height: 0);
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _exerciseNameInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  widget.bodyPart,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              width: 12.0,
            ),
          ],
        ),
        SizedBox(
          width: 180,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              widget.exerciseName,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
        if (widget.isHistory)
          IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.indigo,
                radius: 12,
                child: Icon(
                  FontAwesomeIcons.penToSquare,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              onPressed: () async {
                int? order = await GetIt.I<LocalDatabase>()
                    .getOrder(widget.logDate, widget.exerciseIndex);
                String? memo = await GetIt.I<LocalDatabase>().getMemo(order!);
                _showMemoDialog(memo);
              }),
        if (!widget.isHistory)
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.indigo.withOpacity(0.0),
              radius: 12,
              child: Icon(
                FontAwesomeIcons.penToSquare,
                color: Colors.white.withOpacity(0.0),
                size: 15,
              ),
            ),
            onPressed: () {},
          ),
      ],
    );
  }

  void _showMemoDialog(String? memo) {
    memo ??= ' ';
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
                  height: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          SizedBox(
                            width: 30,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              //color: Colors.red,
                              height: 30,
                              child: Text(
                                'Memo',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                              color: Colors.grey[300],
                            ),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Text(
                                memo!,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('확인'),
                          ),
                          const SizedBox(
                            width: 10,
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
