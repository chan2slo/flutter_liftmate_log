import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:lift_mate/database/drift_database.dart';
import 'package:lift_mate/model/fitnesslog_with_exercise.dart';
import 'package:provider/provider.dart';

class ShowDatabase extends StatefulWidget {
  const ShowDatabase({Key? key}) : super(key: key);

  @override
  State<ShowDatabase> createState() => _ShowDatabaseState();
}

class _ShowDatabaseState extends State<ShowDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.black,
          child: Text('데이터 보기'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          // Expanded(
          //   child: Center(
          //     child: StreamBuilder<List<DateExerciseLog>>(
          //       stream: GetIt.I<LocalDatabase>().watchFitnessLogWithExercise(),
          //       builder: (context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.active) {
          //           if (!snapshot.hasData) {
          //             return const Text(
          //               'Not Exist Data',
          //               style: TextStyle(fontSize: 18),
          //             );
          //           } else {
          //             return ListView.builder(
          //                 //scrollDirection: Axis.horizontal, // 가로 방향으로 스크롤 가능하도록 설정
          //                 shrinkWrap: true,
          //                 itemCount: snapshot.data!.length,
          //                 itemBuilder: (context, index) {
          //                   // return Center(
          //                   //   child: Text(snapshot.data![index].toString())
          //                   // );
          //                   return Row(
          //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                       children: [
          //                         Text(
          //                           snapshot.data![index].date.toString(),
          //                         ),
          //                         // Text(
          //                         //   snapshot.data![index].bodyPart,
          //                         // ),
          //                         Text(
          //                           snapshot.data![index].exerciseName,
          //                         ),
          //                       ]);
          //                 });
          //           }
          //         } else {
          //           return const Text(
          //             'DB 연결 불가',
          //             style: TextStyle(fontSize: 18),
          //           );
          //         }
          //       },
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child: Center(
          //     child: StreamBuilder<List<ExerciseModelData>>(
          //       stream: GetIt.I<LocalDatabase>().testWatchExercise(),
          //       builder: (context, snapshot) {
          //         if (!snapshot.hasData) {
          //           return const Text(
          //             'Not Exist Data',
          //             style: TextStyle(fontSize: 18),
          //           );
          //         }
          //         return ListView.builder(
          //             shrinkWrap: true,
          //             itemCount: snapshot.data!.length,
          //             itemBuilder: (context, index) {
          //               return Center(
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                   children: [
          //                     Text(snapshot.data![index].index.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     Text(snapshot.data![index].bodyPart,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     Text(snapshot.data![index].exerciseName,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                   ],
          //                 ),
          //               );
          //             });
          //       },
          //     ),
          //   ),
          // ),
          //Text('------------------------------'),
          const SizedBox(height: 20,),
          Expanded(
            child: Center(
              child: StreamBuilder<List<FitnessLogModelData>>(
                stream: GetIt.I<LocalDatabase>().watchAllFitnessLogModels(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text(
                      'Not Exist Data',
                      style: TextStyle(fontSize: 18),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("index: ${snapshot.data![index].index}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text("date: ${snapshot.data![index].date}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text("excerciseIndex: ${snapshot.data![index].exerciseIndex}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text("set: ${snapshot.data![index].set}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text("kgWeight: ${snapshot.data![index].kgWeight}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text("lbWeight: ${snapshot.data![index].lbWeight}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text("unit: ${snapshot.data![index].unit}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text("reps: ${snapshot.data![index].reps}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text("time: ${snapshot.data![index].time}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text("order: ${snapshot.data![index].order}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text("createdAt: ${snapshot.data![index].createdAt}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Text('================================'),
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
          ),
          // Text('------------------------------'),
          // const SizedBox(
          //   height: 20,
          // ),
          // Expanded(
          //   child: Center(
          //     child: StreamBuilder<List<FitnessLogWithExercise>>(
          //       stream: GetIt.I<LocalDatabase>()
          //           .watchAllFitnessLogsWithExercise(
          //               Provider.of<FitnessLogProvider>(context, listen: false)
          //                   .logDate),
          //       builder: (context, snapshot) {
          //         if (!snapshot.hasData) {
          //           return const Text(
          //             'Not Exist Data',
          //             style: TextStyle(fontSize: 18),
          //           );
          //         }
          //         return ListView.builder(
          //             shrinkWrap: true,
          //             itemCount: snapshot.data!.length,
          //             itemBuilder: (context, index) {
          //               return Center(
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                   children: [
          //                     Text(
          //                       "index: " +
          //                           snapshot.data![index].fitnessLog.index
          //                               .toString(),
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "date: " +
          //                           snapshot.data![index].fitnessLog.date
          //                               .toString(),
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "excerciseIndex: " +
          //                           snapshot
          //                               .data![index].fitnessLog.exerciseIndex
          //                               .toString(),
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "set: " +
          //                           snapshot.data![index].fitnessLog.set
          //                               .toString(),
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "kgWeight: " +
          //                           snapshot.data![index].fitnessLog.kgWeight
          //                               .toString(),
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "lbWeight: " +
          //                           snapshot.data![index].fitnessLog.lbWeight
          //                               .toString(),
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "unit: " +
          //                           snapshot.data![index].fitnessLog.unit,
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "reps: " +
          //                           snapshot.data![index].fitnessLog.reps
          //                               .toString(),
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "createdAt: " +
          //                           snapshot.data![index].fitnessLog.createdAt
          //                               .toString(),
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "bodyPart: " +
          //                           snapshot.data![index].exercise.bodyPart,
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "exerciseName: " +
          //                           snapshot.data![index].exercise.exerciseName,
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text(
          //                       "order: " +
          //                           snapshot.data![index].fitnessLog.order
          //                               .toString(),
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     ),
          //                     Text('================================'),
          //                   ],
          //                 ),
          //               );
          //             });
          //       },
          //     ),
          //   ),
          // ),
          Text('------------------------------'),
          const SizedBox(
            height: 20,
          ),
          // Expanded(
          //   child: Center(
          //     child: FutureBuilder<List<List<Object>>>(
          //       future: GetIt.I<LocalDatabase>().getExerciseSortDate(Provider.of<FitnessLogProvider>(context, listen: false).logDate),
          //       builder: (context, snapshot) {
          //         if (!snapshot.hasData) {
          //           return const Text(
          //             'Not Exist Data',
          //             style: TextStyle(fontSize: 18),
          //           );
          //         }
          //         return ListView.builder(
          //             shrinkWrap: true,
          //             itemCount: snapshot.data!.length,
          //             itemBuilder: (context, index) {
          //               return Center(
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                   children: [
          //                     //Text("index: " + snapshot.data![index].fitnessLog.index.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     //Text("date: " + snapshot.data![index].fitnessLog.date.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     //Text("excerciseIndex: " + snapshot.data![index].fitnessLog.exerciseIndex.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     //Text("set: " + snapshot.data![index].fitnessLog.set.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     //Text("kgWeight: " + snapshot.data![index].fitnessLog.kgWeight.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     //Text("lbWeight: " + snapshot.data![index].fitnessLog.lbWeight.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     //Text("unit: " + snapshot.data![index].fitnessLog.unit,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     //Text("reps: " + snapshot.data![index].fitnessLog.reps.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     //Text("createdAt: " + snapshot.data![index].fitnessLog.createdAt.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     Text("bodyPart: " + snapshot.data![index].,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     Text("exerciseName: " + snapshot.data![index].exercise.exerciseName,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          //                     Text('================================'),
          //                   ],
          //                 ),
          //               );
          //             });
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
