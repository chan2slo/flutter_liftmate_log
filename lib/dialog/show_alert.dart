import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlert({required BuildContext context, required String message}) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        content: Text(
          message,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("확인"),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      );
    },
  );
}

Future<bool> showAlert2({required BuildContext context, required String message}) async {
  bool result = await showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        content: Text(
          message,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("취소", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.pop(context, false); // false를 반환합니다.
              }),
          CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("확인"),
              onPressed: () {
                Navigator.pop(context, true); // true를 반환합니다.
              }),

        ],
      );
    },
  );
  return result;
}