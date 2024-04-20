import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double width;
  final String hintText;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    required this.width,
    required this.hintText,
    required this.onSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: width,
      child: TextFormField(
        onSaved: onSaved,
        cursorColor: Colors.grey,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          //prefixIcon: Icon(FontAwesomeIcons.dumbbell),
          hintText: hintText,
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300],
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
    );
  }

}
