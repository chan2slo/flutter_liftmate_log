import 'package:flutter/material.dart';

class renderColumn extends StatelessWidget {
  final double width;
  final String content;

  const renderColumn({
    required this.width,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: width,
        child: Center(
          child: Text(
            content,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        //decoration: BoxDecoration(border: Border(right: BorderSide())),
      ),
    );
  }
}