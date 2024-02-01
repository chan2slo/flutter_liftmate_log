import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateBanner extends StatelessWidget {
  final DateTime date;
  const DateBanner({required this.date, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
        width: double.infinity,
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${date.year}년 ${date.month}월', style: TextStyle(fontSize: 15,),),
              Text(DateFormat('MMM yyyy').format(date), style: TextStyle(fontSize: 15,),),
            ],
          ),
        ),
      ),
    );
  }
}
