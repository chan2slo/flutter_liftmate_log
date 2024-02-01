import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lift_mate/component/logging_card.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:lift_mate/database/drift_database.dart';
import 'package:provider/provider.dart';

class ExerciseHistoryScreen extends StatefulWidget {
  const ExerciseHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseHistoryScreen> createState() => _ExerciseHistoryScreenState();
}

class _ExerciseHistoryScreenState extends State<ExerciseHistoryScreen> {
  final ScrollController _controller = ScrollController();

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
                          // return Center(
                          //   child: Text(snapshot.data![index].toString())
                          // );
                          return LoggingCard(
                            isHistory: false,
                            controller: _controller,
                            logDate: Provider.of<FitnessLogProvider>(context, listen: false).logDate,
                            exerciseIndex: snapshot.data![index][1] as int,
                            bodyPart: snapshot.data![index][2].toString(),
                            exerciseName: snapshot.data![index][3].toString(),
                          );
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
