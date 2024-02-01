import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:lift_mate/component/custom_textfield.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:lift_mate/database/drift_database.dart';
import 'package:lift_mate/dialog/show_alert.dart';
import 'package:provider/provider.dart';

class ExerciseName extends StatefulWidget {
  final bool modify;
  final Function() parentState;
  final bool inputable;
  final bool alreadyInput;
  final GlobalKey<FormState> formKey1;

  const ExerciseName(
      {required this.modify,
      required this.parentState,
      required this.inputable,
      required this.alreadyInput,
      required this.formKey1,
      Key? key})
      : super(key: key);

  @override
  State<ExerciseName> createState() => _ExerciseNameState();
}

class _ExerciseNameState extends State<ExerciseName> {
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  List<String> fitnessDropdown = [
    '---',
    "가슴",
    "등",
    "하체",
    "어깨",
    "이두",
    "삼두",
    "복근",
    "맨몸",
    "유산소",
    "기타"
  ];
  int selectedValue = 0;
  int? tempValue;
  String? newMemo;

  @override
  Widget build(BuildContext context) {
    if(widget.alreadyInput){
      if(Provider.of<ExerciseProvider>(context, listen: false).exBodyPart == '유산소'){
        fitnessDropdown = ['유산소'];
      } else if (Provider.of<ExerciseProvider>(context, listen: false).exBodyPart == '맨몸'){
        fitnessDropdown = ['맨몸'];
      } else {
        fitnessDropdown = [
          "---",
          "가슴",
          "등",
          "하체",
          "어깨",
          "이두",
          "삼두",
          "복근",
          "기타"
        ];
        //print(Provider.of<ExerciseProvider>(context, listen: false).exBodyPart);
        //print(fitnessDropdown.indexOf("${Provider.of<ExerciseProvider>(context, listen: false).exBodyPart}"));
        selectedValue = fitnessDropdown.indexOf("${Provider.of<ExerciseProvider>(context, listen: false).exBodyPart}");
      }
    }
    return Form(
      //key: Provider.of<FormKeyProvider>(context).formKey2,
      key: widget.formKey1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 33,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextButton(
              onPressed: widget.inputable
                  ? () {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                color: Colors.grey[300],
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          '취소',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                    const Material(
                                      type: MaterialType.transparency,
                                      child: Text(
                                        '운동 부위 선택',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            if (tempValue != null) {
                                              selectedValue = tempValue!;
                                              Provider.of<ExerciseProvider>(
                                                          context,
                                                          listen: false)
                                                      .bodyPart =
                                                  fitnessDropdown[
                                                      selectedValue];
                                            }
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('저장')),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey[300],
                                height: 300,
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                      initialItem: selectedValue),
                                  backgroundColor: Colors.grey[100],
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  itemExtent: 32.0,
                                  onSelectedItemChanged: (int seletedItem) {
                                    setState(() {
                                      tempValue = seletedItem;
                                    });
                                  },
                                  children: List<Widget>.generate(
                                      fitnessDropdown.length, (int index) {
                                    return Center(
                                      child: Text(
                                        fitnessDropdown[index],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          );
                        },
                        barrierDismissible: true,
                      );
                    }
                  : () {},
              child: Text(
                widget.inputable
                    ? fitnessDropdown[selectedValue]
                    : Provider.of<ExerciseProvider>(context, listen: false)
                        .bodyPart,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          if (widget.inputable)
            CustomTextField(
              hintText: '운동명',
              width: 180,
              onSaved: (String? val) {
                Provider.of<ExerciseProvider>(context, listen: false)
                    .exerciseName = val;
              },
            ),
          if (!widget.inputable)
            SizedBox(
              width: 130,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "${Provider.of<ExerciseProvider>(context, listen: false).exerciseName}",
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          if (widget.inputable)
            IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 12,
                child: Icon(
                  FontAwesomeIcons.check,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              onPressed: widget.parentState,
            ),
          if (!widget.inputable)
            Row(
              children: [
                IconButton(
                  icon: const CircleAvatar(
                    backgroundColor: Colors.indigo,
                    radius: 12,
                    child: Icon(
                      FontAwesomeIcons.penToSquare,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  //onPressed: widget.modify ? (){} : widget.parentState,
                  onPressed: () async {
                    int? savedOrder = await GetIt.I<LocalDatabase>().getOrder(
                        Provider.of<FitnessLogProvider>(context, listen: false)
                            .logDate,
                        Provider.of<ExerciseProvider>(context, listen: false)
                            .exerciseIndex!);
                    if (savedOrder == null) {
                      showAlert(
                          context: context,
                          message: '1회 이상의 입력을 해야\n 메모가 가능합니다.');
                    } else {
                      String? initialMemo = await GetIt.I<LocalDatabase>()
                          .getMemo(Provider.of<FitnessLogProvider>(context,
                                  listen: false)
                              .order!);
                      _memoDialog(initialMemo: initialMemo);
                    }
                    print(
                        Provider.of<FitnessLogProvider>(context, listen: false)
                            .order);
                  },
                ),
                IconButton(
                  icon: const CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 12,
                    child: Icon(
                      FontAwesomeIcons.wrench,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  onPressed: widget.parentState,
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _memoDialog({required String? initialMemo}) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          SizedBox(
                            width: 30,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              //color: Colors.red,
                              height: 30,
                              child: Text(
                                'Memo',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          child: Form(
                            key: formKey2,
                            child: TextFormField(
                              onSaved: (String? val) {
                                newMemo = val;
                              },
                              maxLines: null,
                              expands: true,
                              initialValue: initialMemo,
                              cursorColor: Colors.grey,
                              textAlign: TextAlign.left,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                hintText: '메모를 입력하세요.',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.grey[300],
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              formKey2.currentState!.save();
                              if (initialMemo != null) {
                                await GetIt.I<LocalDatabase>().updateMemo(
                                    Provider.of<FitnessLogProvider>(context,
                                            listen: false)
                                        .order!,
                                    MemoModelCompanion(
                                      memo: Value(newMemo!),
                                    ));
                              } else {
                                await GetIt.I<LocalDatabase>().createMemo(
                                  MemoModelCompanion(
                                    memo: Value(newMemo!),
                                    order: Value(
                                        Provider.of<FitnessLogProvider>(context,
                                                listen: false)
                                            .order!),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                            },
                            child: const Text('입력'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
