import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'render_column.dart';

class LiftSetRow extends StatelessWidget {
  final String set;
  final String weight;
  final String reps;
  final bool isTitle;

  const LiftSetRow({
    required this.set,
    required this.weight,
    required this.reps,
    Key? key,
    this.isTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isTitle
          ? const EdgeInsets.symmetric(horizontal: 8.0)
          : EdgeInsets.zero,
      child: Card(
        margin: EdgeInsets.all(2),
        child: Container(
          height: isTitle ? 30 : 45,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isTitle ? Colors.grey : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              renderColumn(width: 50, content: set),
              renderColumn(width: 50, content: weight == "-1.0" ? "---" : weight),
              renderColumn(width: 50, content: reps),
            ],
          ),
        ),
      ),
    );
  }
}
