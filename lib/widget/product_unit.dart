// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProductUnit extends StatelessWidget {
  var onTap;
   String title;
  ProductUnit({Key? key, required this.onTap,  required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
