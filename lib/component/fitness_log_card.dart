import 'package:flutter/material.dart';
import 'package:lift_mate/component/slidable_row.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:lift_mate/screen/logging_screen.dart';
import 'package:provider/provider.dart';

class FitnessLogCard extends StatelessWidget {
  final DateTime date;
  final String bodyPart;
  final String exerciseName;

  const FitnessLogCard({
    required this.date,
    required this.bodyPart,
    required this.exerciseName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<FitnessLogProvider>(context, listen: false).logDate =
            DateTime.utc(date.year, date.month, date.day);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const LoggingScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, ),
        child: Container(
          color: Colors.white,
          height: 75,
          width: MediaQuery.of(context).size.width,
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _day(),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: _bodyPart(),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.green,
                    ),
                    Expanded(child: Align(alignment: Alignment.centerLeft, child: _exerciseName()))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _day() {
    return Container(
      width: 50,
      height: 50,
      child: Center(
        child: Text(
          date.day.toString(),
          style: TextStyle(fontSize: 30, color: Colors.black45),
        ),
      ),
    );
  }

  Widget _bodyPart() {
    return Container(
      child: Text(
        bodyPart,
        style: TextStyle(fontSize: 20),
        //textAlign: TextAlign.left,
      ),
    );
  }

  Widget _exerciseName() {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 10,),
          Text(
            exerciseName.length > 20
                ? "${exerciseName.substring(0, 20)}..."
                : exerciseName,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
