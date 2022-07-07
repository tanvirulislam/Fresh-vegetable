import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fresh_vegetable/const/app_colors.dart';

class BottomCustome extends StatelessWidget {
  const BottomCustome({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 200),
          backgroundColor: Colors.white,
          color: primaryColor,
          height: 60,
          items: <Widget>[
            Icon(Icons.home ),
            Icon(Icons.shopping_cart_outlined),
            Icon(Icons.shopping_bag_outlined),
            Icon(Icons.person_outline),
          ],
          onTap: (index) {
            //Handle button tap
          },
        );
  }
}