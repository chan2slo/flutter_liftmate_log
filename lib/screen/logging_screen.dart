import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lift_mate/component/logging_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:lift_mate/dialog/custom_dialog.dart';
import 'package:lift_mate/screen/show_database_test.dart';
import 'package:provider/provider.dart';

import '../database/drift_database.dart';

class LoggingScreen extends StatefulWidget {
  const LoggingScreen({Key? key}) : super(key: key);

  @override
  State<LoggingScreen> createState() => _LoggingScreenState();
}

class _LoggingScreenState extends State<LoggingScreen> {
  final ScrollController _controller = ScrollController();
  DateTime? tempDate;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '기록하기',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 45,
                child: TextButton(
                  onPressed: () {
                    customDatePicker();
                  },
                  child: Text(
                      '${Provider.of<FitnessLogProvider>(context, listen: false).logDate.year}년 ${Provider.of<FitnessLogProvider>(context, listen: false).logDate.month}월 ${Provider.of<FitnessLogProvider>(context, listen: false).logDate.day}일',
                      style: const TextStyle(fontSize: 25, color: Colors.black54)),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: StreamBuilder<List<List<Object>>>(
                  stream: GetIt.I<LocalDatabase>()
                      .watchDistinctExerciseWithOrder(
                      Provider.of<FitnessLogProvider>(context, listen: false)
                          .logDate),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || (snapshot.hasData && snapshot.data!.isEmpty)) {
                      return const Text(
                        '입력된 데이터가 없습니다.',
                        style: TextStyle(fontSize: 18),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          if(snapshot.data![index][2].toString() == '유산소'){
                            //return Container(color: Colors.red, width: 100, height: 50, child: Text('fuck you'),);
                            return LoggingCard(
                              isHistory: false,
                              controller: _controller,
                              logDate: Provider.of<FitnessLogProvider>(context, listen: false).logDate,
                              exerciseIndex: snapshot.data![index][1] as int,
                              bodyPart: snapshot.data![index][2].toString(),
                              exerciseName: snapshot.data![index][3].toString(),
                            );

                          } else {
                            return LoggingCard(
                              isHistory: false,
                              controller: _controller,
                              logDate: Provider.of<FitnessLogProvider>(context, listen: false).logDate,
                              exerciseIndex: snapshot.data![index][1] as int,
                              bodyPart: snapshot.data![index][2].toString(),
                              exerciseName: snapshot.data![index][3].toString(),
                            );
                          }
                          // return Center(
                          //   child: Text(snapshot.data![index].toString())
                          // );

                        });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () {
                      initialValue(context: context);
                      CustomDialog(modify: false, context: context, controller: _controller).customDialog();
                    },
                    // style: ElevatedButton.styleFrom(primary: Colors.grey),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: const Text(
                      '운동 추가',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ShowDatabase()));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text(
                    '(tes)showDB',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void customDatePicker() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.grey[300],
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                      child: const Text(
                        '취소',
                        style: TextStyle(color: Colors.red),
                      )),
                  const Material(
                    type: MaterialType.transparency,
                    child: Text(
                      '날짜 선택',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          if(tempDate != null){
                            Provider.of<FitnessLogProvider>(context,
                                listen: false)
                                .logDate = DateTime.utc(tempDate!.year, tempDate!.month, tempDate!.day);;
                          }
                          Navigator.of(context).pop();
                        });
                      },
                      child: Text('저장')),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              height: 300,
              child: CupertinoDatePicker(
                  initialDateTime:
                      Provider.of<FitnessLogProvider>(context, listen: false)
                          .logDate,
                  minimumYear: 1900,
                  maximumYear: DateTime.now().year + 10,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      tempDate = newDate;
                    });
                  }),
            ),
          ],
        );
      },
      barrierDismissible: true,
    );
  }

}
