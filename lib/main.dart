// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fresh_vegetable/auth/google_service.dart';
import 'package:fresh_vegetable/pages/home.dart';
import 'package:fresh_vegetable/pages/signIn.dart';
import 'package:fresh_vegetable/providers/cart_provider.dart';
import 'package:fresh_vegetable/providers/checkout_provider.dart';
import 'package:fresh_vegetable/providers/product_provider.dart';
import 'package:fresh_vegetable/providers/theme_provider.dart';
import 'package:fresh_vegetable/providers/user_provider.dart';
import 'package:fresh_vegetable/providers/wish_list_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignIn();
  AuthClass authClass = AuthClass();

  Future<void> checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = Home();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProdcutProvider>(
          create: (context) => ProdcutProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: Mythemes.lightTheme,
        darkTheme: Mythemes.darkTheme,
        home: currentPage,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
