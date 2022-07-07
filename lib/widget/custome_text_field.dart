import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String labText;
  final TextInputType keyboardType;
  const CustomeTextField({
    Key? key,
     required this.labText,
    required this.keyboardType,
    required this.textEditingController,
   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: textEditingController,
      decoration: InputDecoration(
       labelText: labText
      ),
    );
  }
}
