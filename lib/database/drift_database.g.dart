// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $ExerciseModelTable extends ExerciseModel
    with TableInfo<$ExerciseModelTable, ExerciseModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bodyPartMeta =
      const VerificationMeta('bodyPart');
  @override
  late final GeneratedColumn<String> bodyPart = GeneratedColumn<String>(
      'body_part', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exerciseNameMeta =
      const VerificationMeta('exerciseName');
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
      'exercise_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [index, bodyPart, exerciseName];
  @override
  String get aliasedName => _alias ?? 'exercise_model';
  @override
  String get actualTableName => 'exercise_model';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    if (data.containsKey('body_part')) {
      context.handle(_bodyPartMeta,
          bodyPart.isAcceptableOrUnknown(data['body_part']!, _bodyPartMeta));
    } else if (isInserting) {
      context.missing(_bodyPartMeta);
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
          _exerciseNameMeta,
          exerciseName.isAcceptableOrUnknown(
              data['exercise_name']!, _exerciseNameMeta));
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {index};
  @override
  ExerciseModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseModelData(
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}index'])!,
      bodyPart: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body_part'])!,
      exerciseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_name'])!,
    );
  }

  @override
  $ExerciseModelTable createAlias(String alias) {
    return $ExerciseModelTable(attachedDatabase, alias);
  }
}

class ExerciseModelData extends DataClass
    implements Insertable<ExerciseModelData> {
  final int index;
  final String bodyPart;
  final String exerciseName;
  const ExerciseModelData(
      {required this.index,
      required this.bodyPart,
      required this.exerciseName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['index'] = Variable<int>(index);
    map['body_part'] = Variable<String>(bodyPart);
    map['exercise_name'] = Variable<String>(exerciseName);
    return map;
  }

  ExerciseModelCompanion toCompanion(bool nullToAbsent) {
    return ExerciseModelCompanion(
      index: Value(index),
      bodyPart: Value(bodyPart),
      exerciseName: Value(exerciseName),
    );
  }

  factory ExerciseModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseModelData(
      index: serializer.fromJson<int>(json['index']),
      bodyPart: serializer.fromJson<String>(json['bodyPart']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'index': serializer.toJson<int>(index),
      'bodyPart': serializer.toJson<String>(bodyPart),
      'exerciseName': serializer.toJson<String>(exerciseName),
    };
  }

  ExerciseModelData copyWith(
          {int? index, String? bodyPart, String? exerciseName}) =>
      ExerciseModelData(
        index: index ?? this.index,
        bodyPart: bodyPart ?? this.bodyPart,
        exerciseName: exerciseName ?? this.exerciseName,
      );
  @override
  String toString() {
    return (StringBuffer('ExerciseModelData(')
          ..write('index: $index, ')
          ..write('bodyPart: $bodyPart, ')
          ..write('exerciseName: $exerciseName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(index, bodyPart, exerciseName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseModelData &&
          other.index == this.index &&
          other.bodyPart == this.bodyPart &&
          other.exerciseName == this.exerciseName);
}

class ExerciseModelCompanion extends UpdateCompanion<ExerciseModelData> {
  final Value<int> index;
  final Value<String> bodyPart;
  final Value<String> exerciseName;
  const ExerciseModelCompanion({
    this.index = const Value.absent(),
    this.bodyPart = const Value.absent(),
    this.exerciseName = const Value.absent(),
  });
  ExerciseModelCompanion.insert({
    this.index = const Value.absent(),
    required String bodyPart,
    required String exerciseName,
  })  : bodyPart = Value(bodyPart),
        exerciseName = Value(exerciseName);
  static Insertable<ExerciseModelData> custom({
    Expression<int>? index,
    Expression<String>? bodyPart,
    Expression<String>? exerciseName,
  }) {
    return RawValuesInsertable({
      if (index != null) 'index': index,
      if (bodyPart != null) 'body_part': bodyPart,
      if (exerciseName != null) 'exercise_name': exerciseName,
    });
  }

  ExerciseModelCompanion copyWith(
      {Value<int>? index,
      Value<String>? bodyPart,
      Value<String>? exerciseName}) {
    return ExerciseModelCompanion(
      index: index ?? this.index,
      bodyPart: bodyPart ?? this.bodyPart,
      exerciseName: exerciseName ?? this.exerciseName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (bodyPart.present) {
      map['body_part'] = Variable<String>(bodyPart.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseModelCompanion(')
          ..write('index: $index, ')
          ..write('bodyPart: $bodyPart, ')
          ..write('exerciseName: $exerciseName')
          ..write(')'))
        .toString();
  }
}

class $FitnessLogModelTable extends FitnessLogModel
    with TableInfo<$FitnessLogModelTable, FitnessLogModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FitnessLogModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _exerciseIndexMeta =
      const VerificationMeta('exerciseIndex');
  @override
  late final GeneratedColumn<int> exerciseIndex = GeneratedColumn<int>(
      'exercise_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _setMeta = const VerificationMeta('set');
  @override
  late final GeneratedColumn<int> set = GeneratedColumn<int>(
      'set', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _kgWeightMeta =
      const VerificationMeta('kgWeight');
  @override
  late final GeneratedColumn<double> kgWeight = GeneratedColumn<double>(
      'kg_weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _lbWeightMeta =
      const VerificationMeta('lbWeight');
  @override
  late final GeneratedColumn<double> lbWeight = GeneratedColumn<double>(
      'lb_weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<int> time = GeneratedColumn<int>(
      'time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        index,
        date,
        exerciseIndex,
        set,
        kgWeight,
        lbWeight,
        unit,
        time,
        reps,
        order,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? 'fitness_log_model';
  @override
  String get actualTableName => 'fitness_log_model';
  @override
  VerificationContext validateIntegrity(
      Insertable<FitnessLogModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('exercise_index')) {
      context.handle(
          _exerciseIndexMeta,
          exerciseIndex.isAcceptableOrUnknown(
              data['exercise_index']!, _exerciseIndexMeta));
    } else if (isInserting) {
      context.missing(_exerciseIndexMeta);
    }
    if (data.containsKey('set')) {
      context.handle(
          _setMeta, set.isAcceptableOrUnknown(data['set']!, _setMeta));
    }
    if (data.containsKey('kg_weight')) {
      context.handle(_kgWeightMeta,
          kgWeight.isAcceptableOrUnknown(data['kg_weight']!, _kgWeightMeta));
    }
    if (data.containsKey('lb_weight')) {
      context.handle(_lbWeightMeta,
          lbWeight.isAcceptableOrUnknown(data['lb_weight']!, _lbWeightMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {index};
  @override
  FitnessLogModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FitnessLogModelData(
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}index'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      exerciseIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_index'])!,
      set: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set']),
      kgWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}kg_weight']),
      lbWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lb_weight']),
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit']),
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time']),
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps']),
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FitnessLogModelTable createAlias(String alias) {
    return $FitnessLogModelTable(attachedDatabase, alias);
  }
}

class FitnessLogModelData extends DataClass
    implements Insertable<FitnessLogModelData> {
  final int index;
  final DateTime date;
  final int exerciseIndex;
  final int? set;
  final double? kgWeight;
  final double? lbWeight;
  final String? unit;
  final int? time;
  final int? reps;
  final int order;
  final DateTime createdAt;
  const FitnessLogModelData(
      {required this.index,
      required this.date,
      required this.exerciseIndex,
      this.set,
      this.kgWeight,
      this.lbWeight,
      this.unit,
      this.time,
      this.reps,
      required this.order,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['index'] = Variable<int>(index);
    map['date'] = Variable<DateTime>(date);
    map['exercise_index'] = Variable<int>(exerciseIndex);
    if (!nullToAbsent || set != null) {
      map['set'] = Variable<int>(set);
    }
    if (!nullToAbsent || kgWeight != null) {
      map['kg_weight'] = Variable<double>(kgWeight);
    }
    if (!nullToAbsent || lbWeight != null) {
      map['lb_weight'] = Variable<double>(lbWeight);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<int>(time);
    }
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    map['order'] = Variable<int>(order);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FitnessLogModelCompanion toCompanion(bool nullToAbsent) {
    return FitnessLogModelCompanion(
      index: Value(index),
      date: Value(date),
      exerciseIndex: Value(exerciseIndex),
      set: set == null && nullToAbsent ? const Value.absent() : Value(set),
      kgWeight: kgWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(kgWeight),
      lbWeight: lbWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(lbWeight),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      order: Value(order),
      createdAt: Value(createdAt),
    );
  }

  factory FitnessLogModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FitnessLogModelData(
      index: serializer.fromJson<int>(json['index']),
      date: serializer.fromJson<DateTime>(json['date']),
      exerciseIndex: serializer.fromJson<int>(json['exerciseIndex']),
      set: serializer.fromJson<int?>(json['set']),
      kgWeight: serializer.fromJson<double?>(json['kgWeight']),
      lbWeight: serializer.fromJson<double?>(json['lbWeight']),
      unit: serializer.fromJson<String?>(json['unit']),
      time: serializer.fromJson<int?>(json['time']),
      reps: serializer.fromJson<int?>(json['reps']),
      order: serializer.fromJson<int>(json['order']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'index': serializer.toJson<int>(index),
      'date': serializer.toJson<DateTime>(date),
      'exerciseIndex': serializer.toJson<int>(exerciseIndex),
      'set': serializer.toJson<int?>(set),
      'kgWeight': serializer.toJson<double?>(kgWeight),
      'lbWeight': serializer.toJson<double?>(lbWeight),
      'unit': serializer.toJson<String?>(unit),
      'time': serializer.toJson<int?>(time),
      'reps': serializer.toJson<int?>(reps),
      'order': serializer.toJson<int>(order),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FitnessLogModelData copyWith(
          {int? index,
          DateTime? date,
          int? exerciseIndex,
          Value<int?> set = const Value.absent(),
          Value<double?> kgWeight = const Value.absent(),
          Value<double?> lbWeight = const Value.absent(),
          Value<String?> unit = const Value.absent(),
          Value<int?> time = const Value.absent(),
          Value<int?> reps = const Value.absent(),
          int? order,
          DateTime? createdAt}) =>
      FitnessLogModelData(
        index: index ?? this.index,
        date: date ?? this.date,
        exerciseIndex: exerciseIndex ?? this.exerciseIndex,
        set: set.present ? set.value : this.set,
        kgWeight: kgWeight.present ? kgWeight.value : this.kgWeight,
        lbWeight: lbWeight.present ? lbWeight.value : this.lbWeight,
        unit: unit.present ? unit.value : this.unit,
        time: time.present ? time.value : this.time,
        reps: reps.present ? reps.value : this.reps,
        order: order ?? this.order,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('FitnessLogModelData(')
          ..write('index: $index, ')
          ..write('date: $date, ')
          ..write('exerciseIndex: $exerciseIndex, ')
          ..write('set: $set, ')
          ..write('kgWeight: $kgWeight, ')
          ..write('lbWeight: $lbWeight, ')
          ..write('unit: $unit, ')
          ..write('time: $time, ')
          ..write('reps: $reps, ')
          ..write('order: $order, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(index, date, exerciseIndex, set, kgWeight,
      lbWeight, unit, time, reps, order, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FitnessLogModelData &&
          other.index == this.index &&
          other.date == this.date &&
          other.exerciseIndex == this.exerciseIndex &&
          other.set == this.set &&
          other.kgWeight == this.kgWeight &&
          other.lbWeight == this.lbWeight &&
          other.unit == this.unit &&
          other.time == this.time &&
          other.reps == this.reps &&
          other.order == this.order &&
          other.createdAt == this.createdAt);
}

class FitnessLogModelCompanion extends UpdateCompanion<FitnessLogModelData> {
  final Value<int> index;
  final Value<DateTime> date;
  final Value<int> exerciseIndex;
  final Value<int?> set;
  final Value<double?> kgWeight;
  final Value<double?> lbWeight;
  final Value<String?> unit;
  final Value<int?> time;
  final Value<int?> reps;
  final Value<int> order;
  final Value<DateTime> createdAt;
  const FitnessLogModelCompanion({
    this.index = const Value.absent(),
    this.date = const Value.absent(),
    this.exerciseIndex = const Value.absent(),
    this.set = const Value.absent(),
    this.kgWeight = const Value.absent(),
    this.lbWeight = const Value.absent(),
    this.unit = const Value.absent(),
    this.time = const Value.absent(),
    this.reps = const Value.absent(),
    this.order = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FitnessLogModelCompanion.insert({
    this.index = const Value.absent(),
    required DateTime date,
    required int exerciseIndex,
    this.set = const Value.absent(),
    this.kgWeight = const Value.absent(),
    this.lbWeight = const Value.absent(),
    this.unit = const Value.absent(),
    this.time = const Value.absent(),
    this.reps = const Value.absent(),
    required int order,
    this.createdAt = const Value.absent(),
  })  : date = Value(date),
        exerciseIndex = Value(exerciseIndex),
        order = Value(order);
  static Insertable<FitnessLogModelData> custom({
    Expression<int>? index,
    Expression<DateTime>? date,
    Expression<int>? exerciseIndex,
    Expression<int>? set,
    Expression<double>? kgWeight,
    Expression<double>? lbWeight,
    Expression<String>? unit,
    Expression<int>? time,
    Expression<int>? reps,
    Expression<int>? order,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (index != null) 'index': index,
      if (date != null) 'date': date,
      if (exerciseIndex != null) 'exercise_index': exerciseIndex,
      if (set != null) 'set': set,
      if (kgWeight != null) 'kg_weight': kgWeight,
      if (lbWeight != null) 'lb_weight': lbWeight,
      if (unit != null) 'unit': unit,
      if (time != null) 'time': time,
      if (reps != null) 'reps': reps,
      if (order != null) 'order': order,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FitnessLogModelCompanion copyWith(
      {Value<int>? index,
      Value<DateTime>? date,
      Value<int>? exerciseIndex,
      Value<int?>? set,
      Value<double?>? kgWeight,
      Value<double?>? lbWeight,
      Value<String?>? unit,
      Value<int?>? time,
      Value<int?>? reps,
      Value<int>? order,
      Value<DateTime>? createdAt}) {
    return FitnessLogModelCompanion(
      index: index ?? this.index,
      date: date ?? this.date,
      exerciseIndex: exerciseIndex ?? this.exerciseIndex,
      set: set ?? this.set,
      kgWeight: kgWeight ?? this.kgWeight,
      lbWeight: lbWeight ?? this.lbWeight,
      unit: unit ?? this.unit,
      time: time ?? this.time,
      reps: reps ?? this.reps,
      order: order ?? this.order,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (exerciseIndex.present) {
      map['exercise_index'] = Variable<int>(exerciseIndex.value);
    }
    if (set.present) {
      map['set'] = Variable<int>(set.value);
    }
    if (kgWeight.present) {
      map['kg_weight'] = Variable<double>(kgWeight.value);
    }
    if (lbWeight.present) {
      map['lb_weight'] = Variable<double>(lbWeight.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FitnessLogModelCompanion(')
          ..write('index: $index, ')
          ..write('date: $date, ')
          ..write('exerciseIndex: $exerciseIndex, ')
          ..write('set: $set, ')
          ..write('kgWeight: $kgWeight, ')
          ..write('lbWeight: $lbWeight, ')
          ..write('unit: $unit, ')
          ..write('time: $time, ')
          ..write('reps: $reps, ')
          ..write('order: $order, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MemoModelTable extends MemoModel
    with TableInfo<$MemoModelTable, MemoModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
      'memo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [index, order, memo];
  @override
  String get aliasedName => _alias ?? 'memo_model';
  @override
  String get actualTableName => 'memo_model';
  @override
  VerificationContext validateIntegrity(Insertable<MemoModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('memo')) {
      context.handle(
          _memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    } else if (isInserting) {
      context.missing(_memoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {index};
  @override
  MemoModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoModelData(
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}index'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      memo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memo'])!,
    );
  }

  @override
  $MemoModelTable createAlias(String alias) {
    return $MemoModelTable(attachedDatabase, alias);
  }
}

class MemoModelData extends DataClass implements Insertable<MemoModelData> {
  final int index;
  final int order;
  final String memo;
  const MemoModelData(
      {required this.index, required this.order, required this.memo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['index'] = Variable<int>(index);
    map['order'] = Variable<int>(order);
    map['memo'] = Variable<String>(memo);
    return map;
  }

  MemoModelCompanion toCompanion(bool nullToAbsent) {
    return MemoModelCompanion(
      index: Value(index),
      order: Value(order),
      memo: Value(memo),
    );
  }

  factory MemoModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoModelData(
      index: serializer.fromJson<int>(json['index']),
      order: serializer.fromJson<int>(json['order']),
      memo: serializer.fromJson<String>(json['memo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'index': serializer.toJson<int>(index),
      'order': serializer.toJson<int>(order),
      'memo': serializer.toJson<String>(memo),
    };
  }

  MemoModelData copyWith({int? index, int? order, String? memo}) =>
      MemoModelData(
        index: index ?? this.index,
        order: order ?? this.order,
        memo: memo ?? this.memo,
      );
  @override
  String toString() {
    return (StringBuffer('MemoModelData(')
          ..write('index: $index, ')
          ..write('order: $order, ')
          ..write('memo: $memo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(index, order, memo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoModelData &&
          other.index == this.index &&
          other.order == this.order &&
          other.memo == this.memo);
}

class MemoModelCompanion extends UpdateCompanion<MemoModelData> {
  final Value<int> index;
  final Value<int> order;
  final Value<String> memo;
  const MemoModelCompanion({
    this.index = const Value.absent(),
    this.order = const Value.absent(),
    this.memo = const Value.absent(),
  });
  MemoModelCompanion.insert({
    this.index = const Value.absent(),
    required int order,
    required String memo,
  })  : order = Value(order),
        memo = Value(memo);
  static Insertable<MemoModelData> custom({
    Expression<int>? index,
    Expression<int>? order,
    Expression<String>? memo,
  }) {
    return RawValuesInsertable({
      if (index != null) 'index': index,
      if (order != null) 'order': order,
      if (memo != null) 'memo': memo,
    });
  }

  MemoModelCompanion copyWith(
      {Value<int>? index, Value<int>? order, Value<String>? memo}) {
    return MemoModelCompanion(
      index: index ?? this.index,
      order: order ?? this.order,
      memo: memo ?? this.memo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoModelCompanion(')
          ..write('index: $index, ')
          ..write('order: $order, ')
          ..write('memo: $memo')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $ExerciseModelTable exerciseModel = $ExerciseModelTable(this);
  late final $FitnessLogModelTable fitnessLogModel =
      $FitnessLogModelTable(this);
  late final $MemoModelTable memoModel = $MemoModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [exerciseModel, fitnessLogModel, memoModel];
}
