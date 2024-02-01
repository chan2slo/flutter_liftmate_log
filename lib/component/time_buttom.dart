import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:lift_mate/database/drift_database.dart';
import 'package:provider/provider.dart';

class InsertTime extends StatefulWidget {
  final bool isViewer;

  //final int? exerciseIndex;
  final bool modify;
  final int time;

  const InsertTime({
    this.time = 0,
    this.modify = false,
    this.isViewer = false,
    //this.exerciseIndex,
    Key? key,
  }) : super(key: key);

  @override
  State<InsertTime> createState() => _InsertTimeState();
}

class _InsertTimeState extends State<InsertTime> {
  bool isChange = false;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  int hoursTens = 0;
  int hoursOnes = 0;
  int minutesTens = 0;
  int minutesOnes = 0;
  int secondsTens = 0;
  int secondsOnes = 0;


  @override
  Widget build(BuildContext context) {
    int time = widget.time;
    if (widget.modify) {
      time = Provider.of<FitnessLogProvider>(context, listen: false).time;
    }
    if (time != 0) {
      formatSeconds(time);
      return _timePicker();
    } else {
      return _timePicker();
    }
  }

  Widget _timeText(int arg1, String arg2) {
    return Row(
      children: [
        Text(
          arg1.toString().padLeft(2, '0'),
          style: const TextStyle(fontSize: 40),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          arg2,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _timePicker() {
    return Expanded(
      child: Center(
        child: GestureDetector(
          onTap: widget.isViewer
              ? () {}
              : () {
                  setState(() {
                    isChange = true;
                  });
                  Provider.of<StateProvider>(context, listen: false)
                      .isChangeTrue(dataType: DataType.weight);
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
                                    '시간 설정',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: const Text('저장')),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.grey[300],
                            height: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: _customCupertinoPicker(1, hoursTens),
                                ),
                                Expanded(
                                  child: _customCupertinoPicker(2, hoursOnes),
                                ),
                                Material(
                                  child: Container(
                                    color: Colors.grey[100],
                                    height: double.infinity,
                                    child: const Center(child: Text('시간')),
                                  ),
                                ),
                                Expanded(
                                  child: _customCupertinoPicker(3, minutesTens),
                                ),
                                Expanded(
                                  child: _customCupertinoPicker(4, minutesOnes),
                                ),
                                Material(
                                  child: Container(
                                    color: Colors.grey[100],
                                    height: double.infinity,
                                    child: const Center(child: Text('분')),
                                  ),
                                ),
                                Expanded(
                                  child: _customCupertinoPicker(5, secondsTens),
                                ),
                                Expanded(
                                  child: _customCupertinoPicker(6, secondsOnes),
                                ),
                                Material(
                                  child: Container(
                                    color: Colors.grey[100],
                                    height: double.infinity,
                                    child: const Center(child: Text('초')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    barrierDismissible: true,
                  );
                },
          child: Container(
            height: MediaQuery.of(context).size.width * 0.30,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _timeText(hours, '시간'),
                _timeText(minutes, '분'),
                _timeText(seconds, '초')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customCupertinoPicker(int index, int initialItem) {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: initialItem),
      backgroundColor: Colors.grey[100],
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32.0,
      onSelectedItemChanged: (int newItem) {
        setState(() {
          if (index == 1) {
            hoursTens = newItem;
            hours = hoursTens * 10 + hoursOnes;
            _valueCalculator();
          } else if (index == 2) {
            hoursOnes = newItem;
            hours = hoursTens * 10 + hoursOnes;
            _valueCalculator();
          } else if (index == 3) {
            minutesTens = newItem;
            minutes = minutesTens * 10 + minutesOnes;
            _valueCalculator();
          } else if (index == 4) {
            minutesOnes = newItem;
            minutes = minutesTens * 10 + minutesOnes;
            _valueCalculator();
          } else if (index == 5) {
            secondsTens = newItem;
            seconds = secondsTens * 10 + secondsOnes;
            _valueCalculator();
          } else {
            secondsTens = newItem;
            seconds = secondsTens * 10 + secondsOnes;
            _valueCalculator();
          }
        });
      },
      children: List<Widget>.generate(6, (int index) {
        return Center(
          child: Text(
            '$index',
          ),
        );
      }),
    );
  }

  void _valueCalculator() {
    int time = hours * 3600 + minutes * 60 + seconds;
    Provider.of<FitnessLogProvider>(context, listen: false).time = time;
  }

  void formatSeconds(int time) {
    hours = time ~/ 3600;
    minutes = (time % 3600) ~/ 60;
    seconds = time % 60;
    hoursTens = hours ~/ 10;
    hoursOnes = hours % 10;
    minutesTens = minutes ~/ 10;
    minutesOnes = minutes % 10;
    secondsTens = seconds ~/ 10;
    secondsOnes = seconds % 10;
    print(
        '$hoursTens$hoursOnes:$minutesTens$minutesOnes:$secondsTens$secondsOnes');
  }

  Future<int?> _getTime() async {
    int? result = await GetIt.I<LocalDatabase>().getTime(
      Provider.of<FitnessLogProvider>(context, listen: false).logDate,
      Provider.of<ExerciseProvider>(context, listen: false).exerciseIndex!,);
    return result;
  }
}
