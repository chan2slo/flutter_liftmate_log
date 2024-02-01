import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lift_mate/component/date_banner.dart';
import 'package:lift_mate/component/fitness_log_card.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:lift_mate/database/drift_database.dart';
import 'package:lift_mate/model/fitnesslog_with_exercise.dart';
import 'package:lift_mate/screen/logging_screen.dart';
import 'package:provider/provider.dart';

class LiftLogScreen extends StatefulWidget {
  const LiftLogScreen({Key? key}) : super(key: key);

  @override
  _LiftLogScreenState createState() => _LiftLogScreenState();
}

class _LiftLogScreenState extends State<LiftLogScreen> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {

        _controller.jumpTo(_controller.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // ScrollController 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<FitnessLogProvider>(context, listen: false).logDate);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Title(
            color: Colors.black,
            child: const Text(
              '운동기록',
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.grey[100],
          centerTitle: false,
        ),
        body: Column(
          children: [
            //const DateBanner(),
            Expanded(
              child: StreamBuilder<List<DateExerciseLog>>(
                stream: GetIt.I<LocalDatabase>().watchFitnessLogWithExercise(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      (snapshot.hasData && snapshot.data!.isEmpty)) {
                    return const Center(
                      child: Text(
                        '입력된 데이터가 없습니다.',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  DateTime? _previousDate;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      final currentDate = DateTime.utc(item.date.year, item.date.month, item.date.day);

                      if (_previousDate == null ||
                          _previousDate!.month != currentDate.month ||
                          _previousDate!.year != currentDate.year) {
                        _previousDate = currentDate;
                        return Column(
                          children: [
                            DateBanner(date: currentDate),
                            FitnessLogCard(
                              date: currentDate,
                              bodyPart: item.bodyPart,
                              exerciseName: item.exerciseName,
                            ),
                          ],
                        );
                      } else {
                        return FitnessLogCard(
                          date: currentDate,
                          bodyPart: item.bodyPart,
                          exerciseName: item.exerciseName,
                        );
                      }
                    }, separatorBuilder: (BuildContext context, int index) { return  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[300],
                  ); },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<FitnessLogProvider>(context, listen: false).logDate =
                DateTime.utc(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            );
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => LoggingScreen()));
          },
          backgroundColor: Colors.grey,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
