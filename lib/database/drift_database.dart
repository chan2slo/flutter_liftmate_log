import 'package:drift/drift.dart';
import 'package:lift_mate/model/excercise_model.dart';
import 'package:lift_mate/model/fitness_log_model.dart';
import 'package:lift_mate/model/fitnesslog_with_exercise.dart';
import 'package:lift_mate/model/memo_model.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'dart:io';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [ExerciseModel, FitnessLogModel, MemoModel],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());


  Stream<List<FitnessLogWithExercise>> watchSortOfExercisName(DateTime date, int exerciseIndex) {
    return (select(fitnessLogModel)
      ..where((t) => t.date.equals(date) & t.exerciseIndex.equals(exerciseIndex))
      ..orderBy([
            (t) => OrderingTerm(expression: t.set, mode: OrderingMode.asc)
      ]))
        .join([
      innerJoin(exerciseModel,
          exerciseModel.index.equalsExp(fitnessLogModel.exerciseIndex)),
    ])
        .watch()
        .map((rows) {
      return rows.map((row) {
        return FitnessLogWithExercise(
          fitnessLog: row.readTable(fitnessLogModel),
          exercise: row.readTable(exerciseModel),
        );
      }).toList();
    });
  }


  Future<List<List<Object>>> getExerciseSortDate(
      DateTime date) async {
    final result = await (select(fitnessLogModel)
      ..where((t) =>
      t.date.year.equals(date.year) &
      t.date.month.equals(date.month) &
      t.date.day.equals(date.day))
      ..orderBy([
            (t) => OrderingTerm(expression: t.index, mode: OrderingMode.asc)
      ]))
        .join([
      innerJoin(exerciseModel,
          exerciseModel.index.equalsExp(fitnessLogModel.exerciseIndex)),
    ]).get();

    List<List<Object>> resultUnique = [];
    result
        .map((row) {
      return [
        row.readTable(exerciseModel).bodyPart,
        row.readTable(exerciseModel).exerciseName,
      ];
    })
        .toList()
        .forEach((element) {
      if (!resultUnique
          .map((e) => e.toString())
          .contains(element.toString())) {
        resultUnique.add(element);
      }
    });

    return resultUnique;
  }

  Future<List<List<Object>>> getDistinctExerciseWithOrder(
      DateTime date) async {
    final result = await (select(fitnessLogModel)
          ..where((t) =>
              t.date.year.equals(date.year) &
              t.date.month.equals(date.month) &
              t.date.day.equals(date.day))
          ..orderBy([
            (t) => OrderingTerm(expression: t.index, mode: OrderingMode.asc)
          ]))
        .join([
      innerJoin(exerciseModel,
          exerciseModel.index.equalsExp(fitnessLogModel.exerciseIndex)),
    ]).get();

    List<List<Object>> resultUnique = [];
    result
        .map((row) {
          return [
            row.readTable(exerciseModel).bodyPart,
            row.readTable(exerciseModel).exerciseName,
            row.readTable(fitnessLogModel).order,
          ];
        })
        .toList()
        .forEach((element) {
          if (!resultUnique
              .map((e) => e.toString())
              .contains(element.toString())) {
            resultUnique.add(element);
          }
        });

    return resultUnique;
  }


  Stream<List<List<Object>>> watchDistinctExerciseWithOrder(DateTime date) {
    final result = (select(fitnessLogModel)
      ..where((t) =>
      t.date.year.equals(date.year) &
      t.date.month.equals(date.month) &
      t.date.day.equals(date.day))
      ..orderBy([
            (t) => OrderingTerm(expression: t.order, mode: OrderingMode.desc)
      ]))
        .join([
      innerJoin(exerciseModel,
          exerciseModel.index.equalsExp(fitnessLogModel.exerciseIndex)),
    ])
        .watch()
        .map((rows) {
      final exerciseMap = <int, Map<String, int>>{};
      final uniqueRows = <List<Object>>[];

      for (final row in rows) {
        final exerciseIndex = row.readTable(fitnessLogModel).exerciseIndex;
        final exercise = row.readTable(exerciseModel).exerciseName;
        final bodyPart = row.readTable(exerciseModel).bodyPart;
        final order = row.readTable(fitnessLogModel).order;

        if (!exerciseMap.containsKey(exerciseIndex)) {
          exerciseMap[exerciseIndex] = {bodyPart: order};
          uniqueRows.add([
            order,
            exerciseIndex,
            bodyPart,
            exercise,
          ]);
        } else {
          final exerciseInfo = exerciseMap[exerciseIndex];
          if (exerciseInfo!.containsKey(bodyPart) &&
              exerciseInfo[bodyPart]! <= order) {
            continue;
          } else {
            exerciseInfo[bodyPart] = order;
            final index = uniqueRows.indexWhere(
                    (r) =>
                r[1] == bodyPart &&
                    r[2] == exercise &&
                    r[3] == exerciseIndex);
            if (index != -1) {
              uniqueRows[index][0] = order;
            } else {
              uniqueRows.add([order,
                exerciseIndex,
                bodyPart,
                exercise,]);
            }
          }
        }
      }

      return uniqueRows;
    });

    return result;
  }

  Stream<List<List<Object>>> watchExerciseHistory(int exerciseIndex) {
    final result = (select(fitnessLogModel)
      ..where((t) => t.exerciseIndex.equals(exerciseIndex))
      ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
      ]))
        .join([
      innerJoin(exerciseModel,
          exerciseModel.index.equalsExp(fitnessLogModel.exerciseIndex)),
    ])
        .watch()
        .map((rows) {
      final exerciseMap = <int, Map<int, String>>{};
      final uniqueRows = <List<Object>>[];

      for (final row in rows) {
        final date = row.readTable(fitnessLogModel).date;
        final exercise = row.readTable(exerciseModel).exerciseName;
        final bodyPart = row.readTable(exerciseModel).bodyPart;

        if (!exerciseMap.containsKey(exerciseIndex)) {
          exerciseMap[exerciseIndex] = {date.millisecondsSinceEpoch: bodyPart};
          uniqueRows.add([
            date,
            bodyPart,
            exercise,
          ]);
        } else {
          final exerciseInfo = exerciseMap[exerciseIndex];
          if (exerciseInfo!.containsKey(date.millisecondsSinceEpoch) &&
              exerciseInfo[date.millisecondsSinceEpoch]! == bodyPart) {
            continue;
          } else {
            exerciseInfo[date.millisecondsSinceEpoch] = bodyPart;
            final index = uniqueRows.indexWhere(
                    (r) =>
                r[0] == bodyPart &&
                    r[1] == exercise);
            if (index != -1) {
              uniqueRows[index][2] = date;
            } else {
              uniqueRows.add([
                date,
                bodyPart,
                exercise,
              ]);
            }
          }
        }
      }

      return uniqueRows;
    });

    return result;
  }

  //날짜별로 구분없이 order 받아오기
  Future<int?> getMaxOrder() async {
    final result = await (select(fitnessLogModel)
      ..orderBy([
            (t) => OrderingTerm(expression: t.order, mode: OrderingMode.desc)
      ])
      ..limit(1))
        .get();

    if (result.isEmpty) {
      return null;
    } else {
      return result.first.order;
    }
  }

  //order값 받아오기
  Future<int?> getOrder(DateTime date, int exerciseIndex) async {
    final result = await (select(fitnessLogModel)
      ..where((t) =>
      t.date.year.equals(date.year) &
      t.date.month.equals(date.month) &
      t.date.day.equals(date.day) &
      t.exerciseIndex.equals(exerciseIndex)))
        .get();

    if(result == null) {
      return null;
    } else {
      return result.first.order;
    }
  }

  Future<int?> getTime(DateTime date, int exerciseIndex) async {
    final result = await (select(fitnessLogModel)
      ..where((t) =>
      t.date.year.equals(date.year) &
      t.date.month.equals(date.month) &
      t.date.day.equals(date.day) &
      t.exerciseIndex.equals(exerciseIndex)))
        .get();

    if(result == null) {
      return null;
    } else {
      return result.first.time;
    }
  }

  //기존 memo값 받아오기
  Future<String?> getMemo(int order) async {
    final result = await (select(memoModel)
      ..where((t) =>
      t.order.equals(order)))
        .getSingleOrNull();

    if(result == null){
      return null;
    } else {
     return result.memo;
    }
  }



  Stream<List<DateExerciseLog>> watchFitnessLogWithExercise() {
    final query = select(fitnessLogModel).join([
      innerJoin(exerciseModel, exerciseModel.index.equalsExp(fitnessLogModel.exerciseIndex))
    ])
      ..groupBy([fitnessLogModel.date])
      ..addColumns([
        exerciseModel.bodyPart.groupConcat(distinct: true),
        exerciseModel.exerciseName.groupConcat(distinct: true),
        fitnessLogModel.date,
      ])
      ..orderBy([
        OrderingTerm(expression: fitnessLogModel.date, mode: OrderingMode.desc),
      ]);


    return query.watch().map((rows) {
      return rows.map((row) {
        return DateExerciseLog(
          date: row.read(fitnessLogModel.date)!,
          bodyPart: row.read(exerciseModel.bodyPart.groupConcat(distinct: true))!,
          exerciseName: row.read(exerciseModel.exerciseName.groupConcat(distinct: true))!,
        );
      }).toList();
    });
  }

  Future<int> updateFitnessLog(int index, FitnessLogModelCompanion data) =>
      (update(fitnessLogModel)..where((tbl) => tbl.index.equals(index))).write(data);

  Future<int> updateFitnessLogByOrder(int order, FitnessLogModelCompanion data) =>
      (update(fitnessLogModel)..where((tbl) => tbl.order.equals(order))).write(data);

  Future<int> updateMemo(int order, MemoModelCompanion data) =>
      (update(memoModel)..where((tbl) => tbl.order.equals(order))).write(data);


  Future<ExerciseModelData?> confirmExerciseName(
          String bodyPart, String exerciseName) =>
      (select(exerciseModel)
            ..where((tbl) =>
                tbl.bodyPart.equals(bodyPart) &
                tbl.exerciseName.equals(exerciseName)))
          .getSingleOrNull();

  Future<int> createFitnessLog(FitnessLogModelCompanion data) =>
      into(fitnessLogModel).insert(data);

  Future<int> createExercise(ExerciseModelCompanion data) =>
      into(exerciseModel).insert(data);

  Future<int> createMemo(MemoModelCompanion data) =>
      into(memoModel).insert(data);

  Future<int> removeOneLog(int index) =>
      (delete(fitnessLogModel)..where((tbl) => tbl.index.equals(index))).go();


  Stream<List<FitnessLogModelData>> watchAllFitnessLogModels() {
    return select(fitnessLogModel).watch();
  }


  Future<void> removeBodyPartLog(int order) async {
    await (delete(fitnessLogModel)..where((tbl) => tbl.order.equals(order))).go();
    await (delete(memoModel)..where((tbl) => tbl.order.equals(order))).go();
  }

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
