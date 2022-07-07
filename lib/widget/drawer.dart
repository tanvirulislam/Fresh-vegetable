// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fresh_vegetable/auth/google_service.dart';
import 'package:fresh_vegetable/const/app_colors.dart';
import 'package:fresh_vegetable/main.dart';
import 'package:fresh_vegetable/pages/home.dart';
import 'package:fresh_vegetable/pages/my_profile.dart';
import 'package:fresh_vegetable/pages/review_cart.dart';
import 'package:fresh_vegetable/pages/signIn.dart';
import 'package:fresh_vegetable/pages/wish_list.dart';

Widget drawerCustom(context) {
  AuthClass authClass = AuthClass();
  var token = authClass.getToken();
  return Container(
    width: MediaQuery.of(context).size.width / 1.3,
    color: Colors.grey[200],
    child: ListView(
      children: [
        DrawerHeader(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 40,
                child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/fresh-vegetable-1918b.appspot.com/o/home_bg.png?alt=media&token=51f9e97d-eff2-4c7f-9c16-9800cc0c37f9'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome guest'),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await authClass.logout();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ));
                    },
                    child: Text('Logout'),
                  )
                ],
              )
            ],
          ),
        ),
        InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home())),
            child: ListTile(leading: Icon(Icons.home, color: primaryColor), title: Text('Home'))),
        InkWell(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                ),
            child: ListTile(
                leading: Icon(Icons.shopping_cart, color: primaryColor), title: Text('Cart'))),
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProfile()));
            },
            child:
                ListTile(leading: Icon(Icons.person, color: primaryColor), title: Text('Profile'))),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishList(),
                ));
          },
          child: ListTile(
            leading: Icon(Icons.favorite, color: primaryColor),
            title: Text('WishList'),
          ),
        ),
        ListTile(leading: Icon(Icons.star_outlined, color: primaryColor), title: Text('Rating')),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Contact support'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Contact us: 01756819542'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Email us: tanvirul.cse.diu@gmail.com'),
        ),
      ],
    ),
  );
}
