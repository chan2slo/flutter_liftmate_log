import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:provider/provider.dart';

class RepsButton extends StatefulWidget {
  final int reps;
  const RepsButton({
    required this.reps,
    Key? key}) : super(key: key);

  @override
  State<RepsButton> createState() => _RepsButtonState();
}

class _RepsButtonState extends State<RepsButton> {
  int selectedTens = 0;
  int selectedOnce = 0;
  bool isChange = false;
  late int reps;

  @override
  void initState() {
    super.initState();
    // 초기 weight 값을 설정
    reps = widget.reps;
  }

  @override
  Widget build(BuildContext context) {
    if (reps != 0) {
      String repsString = reps.toString().padLeft(2, '0');
      selectedTens = int.parse(repsString[0]);
      selectedOnce = int.parse(repsString[1]);

    }
    return Container(
      height: 40,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: Colors.grey[300]),
        onPressed: () {
          setState(() {
            isChange = true;
          });
          Provider.of<StateProvider>(context, listen: false).isChangeTrue(dataType: DataType.reps);
          Provider.of<FitnessLogProvider>(context, listen: false).reps = reps;
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
                              '무게 단위 선택',
                              style: TextStyle(fontSize: 20),
                            )),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                //selectedUnit = tempValue!;
                                valueCalculator();
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text('저장')),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey[300],
                    height: 300,
                    //width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: selectedTens),
                            backgroundColor: Colors.grey[100],
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32.0,
                            onSelectedItemChanged: (int seletedItem) {
                              setState(() {
                                selectedTens = seletedItem;
                                valueCalculator();
                              });
                            },
                            children: List<Widget>.generate(10, (int index) {
                              return Center(
                                child: Text(
                                  '$index',
                                ),
                              );
                            }),
                          ),
                        ),
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: selectedOnce),
                            backgroundColor: Colors.grey[100],
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32.0,
                            onSelectedItemChanged: (int seletedItem) {
                              setState(() {
                                selectedOnce = seletedItem;
                                valueCalculator();
                              });
                            },
                            children: List<Widget>.generate(10, (int index) {
                              return Center(
                                child: Text(
                                  '$index',
                                ),
                              );
                            }),
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
        child: Text(
          isChange == false ? "---" : reps.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void valueCalculator() {
    int newReps = selectedTens * 10 + selectedOnce;
    setState(() {
      reps = newReps;
    });
    Provider.of<FitnessLogProvider>(context, listen: false).reps = newReps;
  }
}
