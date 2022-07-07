// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fresh_vegetable/const/app_colors.dart';
import 'package:fresh_vegetable/widget/drawer.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget customeListTile(IconData iconData, String title) {
      return Column(
        children: [
          ListTile(
            leading: Icon(Icons.shop_outlined),
            title: Text(title),
            trailing: Icon(Icons.arrow_forward_outlined),
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Profile'),
        ),
        drawer: drawerCustom(context),
        body: Column(
          children: [
            Container(
              height: 120,
              color: primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/fresh-vegetable-1918b.appspot.com/o/banner.jpg?alt=media&token=f4e04671-c51a-4708-ab21-2c80b7e0facc'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tanvirul islam'),
                      Text('Tanvirul@gmail.com'),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: scaffoldBackground,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit_note),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            customeListTile(Icons.shop_outlined, 'My orders'),
            customeListTile(Icons.shop_outlined, 'My orders'),
            customeListTile(Icons.shop_outlined, 'My orders'),
            customeListTile(Icons.shop_outlined, 'My orders'),
            customeListTile(Icons.shop_outlined, 'My orders'),
            customeListTile(Icons.shop_outlined, 'My orders'),
            customeListTile(Icons.shop_outlined, 'My orders'),
            customeListTile(Icons.shop_outlined, 'My orders'),
          ],
        ),
      ),
    );
  }
}
