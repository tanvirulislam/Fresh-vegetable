// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fresh_vegetable/const/app_colors.dart';

class SingleDeliveryItem extends StatelessWidget {
  var title;
   String address;
  final String number;
  final String addressType;
  SingleDeliveryItem({
    Key? key,
    this.title,
    required this.addressType,
    required this.address,
    required this.number,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Container(
                width: 60,
                padding: EdgeInsets.all(1),
                height: 20,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    addressType,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: CircleAvatar(
            radius: 8,
            backgroundColor: primaryColor,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address),
              SizedBox(
                height: 5,
              ),
              Text(number),
            ],
          ),
        ),
        Divider(
          height: 35,
        ),
      ],
    );
  }
}
