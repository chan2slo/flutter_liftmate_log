import 'package:flutter/material.dart';
import 'package:lift_mate/component/reps_button.dart';
import 'package:lift_mate/component/weight_button.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:provider/provider.dart';

class InsertLiftSetRow extends StatefulWidget {
  final int set;
  final double kgWeight;
  final double lbWeight;
  final String unit;
  final int reps;

  const InsertLiftSetRow({
    required this.set,
    required this.kgWeight,
    required this.lbWeight,
    required this.unit,
    required this.reps,
    Key? key,
  }) : super(key: key);

  @override
  State<InsertLiftSetRow> createState() => _InsertLiftSetRowState();
}

class _InsertLiftSetRowState extends State<InsertLiftSetRow> {
  @override
  Widget build(BuildContext context) {
    String bodyPart =
        Provider.of<ExerciseProvider>(context, listen: false).bodyPart;
    if(bodyPart == '맨몸'){
      // Provider.of<StateProvider>(context, listen: false)
      //     .isChangeTrue(dataType: DataType.weight);
      Provider.of<FitnessLogProvider>(context, listen: false).weight = -1;
      Provider.of<FitnessLogProvider>(context, listen: false).unit = '';
    }
    Provider.of<FitnessLogProvider>(context, listen: false).set = widget.set;
    return Card(
      margin: const EdgeInsets.all(2),
      child: Container(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 50,
              child: Center(
                child: Text(
                  widget.set.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 1),
            bodyPart == '맨몸'
                ? const Text('---')
                : WeightButton(
                    kgWeight: widget.kgWeight,
                    lbWeight: widget.lbWeight,
                    unit: widget.unit,
                  ),
            const SizedBox(width: 1),
            RepsButton(
              reps: widget.reps,
            ),
          ],
        ),
      ),
    );
  }
}
