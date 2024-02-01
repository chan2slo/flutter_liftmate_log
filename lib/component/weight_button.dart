import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:provider/provider.dart';

class WeightButton extends StatefulWidget {
  final double kgWeight;
  final double lbWeight;
  final String unit;

  const WeightButton(
      {required this.kgWeight,
      required this.lbWeight,
      required this.unit,
      Key? key})
      : super(key: key);

  @override
  State<WeightButton> createState() => _WeightButtonState();
}

class _WeightButtonState extends State<WeightButton> {
  List<String> unitDropdown = ['Kg', 'Lb'];
  int selectedUnit = 0;
  int selectedHundreds = 0;
  int selectedTens = 0;
  int selectedOnce = 0;
  int selectedDecimal1 = 0;
  int selectedDecimal2 = 0;
  bool isChange = false;
  late double weight;
  late String unit;

  @override
  void initState() {
    super.initState();

    // 초기 weight 값을 widget.unit 값에 따라 설정
    if (widget.unit == 'Kg') {
      weight = widget.kgWeight;
    } else {
      weight = widget.lbWeight;
    }
    unit = widget.unit;
  }

  @override
  Widget build(BuildContext context) {
    if (weight != 0.0) {
      String weightString = weight.toStringAsFixed(2).padLeft(6, '0');
      selectedHundreds = int.parse(weightString[0]);
      selectedTens = int.parse(weightString[1]);
      selectedOnce = int.parse(weightString[2]);
      selectedDecimal1 = int.parse(weightString[4]);
      selectedDecimal2 = int.parse(weightString[5]);
      if (unit == 'Lb') {
        selectedUnit = 1;
      }
    }
    return Container(
      height: 40,
      width: 110,
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
          Provider.of<StateProvider>(context, listen: false)
              .isChangeTrue(dataType: DataType.weight);
          Provider.of<FitnessLogProvider>(context, listen: false)
              .changeWeightUnit(weight, unit);
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //SizedBox(height: 30,),
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
                            '무게',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                valueCalculator();
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text('저장')),
                      ],
                    ),
                  ),
                  Material(
                    child: Container(
                      height: 40,
                      //color: Colors.red,
                      color: Colors.grey[100],
                      child: Center(
                        child: Text(
                          Provider.of<FitnessLogProvider>(context).unit == 'Kg'
                              ? 'Lb 단위 환산 : ${(Provider.of<FitnessLogProvider>(context).weight * 2.204623).toStringAsFixed(2)}Lb'
                              : 'Kg 단위 환산 : ${(Provider.of<FitnessLogProvider>(context).weight * 0.453592).toStringAsFixed(2)}Kg',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey[300],
                    height: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: selectedHundreds),
                            backgroundColor: Colors.grey[100],
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32.0,
                            onSelectedItemChanged: (int seletedItem) {
                              setState(() {
                                selectedHundreds = seletedItem;
                                valueCalculator();
                                // _updateData(result, unitDropdown[selectedUnit]);
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
                        Material(
                          child: Container(
                            height: double.infinity,
                            color: Colors.grey[100],
                            child: const Center(
                              child: Text(
                                '.',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: selectedDecimal1),
                            backgroundColor: Colors.grey[100],
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32.0,
                            onSelectedItemChanged: (int seletedItem) {
                              setState(() {
                                selectedDecimal1 = seletedItem;
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
                                initialItem: selectedDecimal2),
                            backgroundColor: Colors.grey[100],
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32.0,
                            onSelectedItemChanged: (int seletedItem) {
                              setState(() {
                                selectedDecimal2 = seletedItem;
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
                                initialItem: selectedUnit),
                            backgroundColor: Colors.grey[100],
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32.0,
                            onSelectedItemChanged: (int seletedItem) {
                              setState(() {
                                selectedUnit = seletedItem;
                                valueCalculator();
                              });
                            },
                            children: List<Widget>.generate(unitDropdown.length,
                                (int index) {
                              return Center(
                                child: Text(
                                  unitDropdown[index],
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
          isChange == false ? "--- $unit" : weight.toString() + unit,
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
    double newWeight = selectedHundreds * 100 +
        selectedTens * 10 +
        selectedOnce +
        selectedDecimal1 / 10 +
        selectedDecimal2 / 100;
    String newUnit = unitDropdown[selectedUnit];
    setState(() {
      weight = newWeight;
      unit = newUnit;
    });
    Provider.of<FitnessLogProvider>(context, listen: false)
        .changeWeightUnit(newWeight, newUnit);
    // Provider.of<StateProvider>(context, listen: false)
    //     .isChangeTrue(dataType: DataType.weight);
  }
}
