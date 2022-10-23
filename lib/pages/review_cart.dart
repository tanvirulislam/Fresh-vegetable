// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fresh_vegetable/model/cart_model.dart';
import 'package:fresh_vegetable/pages/checkOut/deliveryDetalis/deliveryDetails.dart';
import 'package:fresh_vegetable/pages/single_item.dart';
import 'package:fresh_vegetable/providers/cart_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatefulWidget {
  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  late CartProvider cartProvider;

  showAlertDialog(BuildContext context, CartModel delete) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Yes"),
      onPressed: () {
        cartProvider.deleteCart(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you devete on cartProduct?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    CartProvider cartProviders =
        Provider.of<CartProvider>(context, listen: false);
    cartProviders.getCart();
    cartProviders.getTotalPrice();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProviders = Provider.of<CartProvider>(context);
    cartProviders.getCart();
    Widget _reviewCart() {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: cartProviders.getCartDataList
              .map<Widget>(
                (data) => SingleItem(
                  true,
                  false,
                  data.cartImage,
                  data.cartName,
                  data.cartPrice,
                  data.cartId,
                  data.cartQty.toString(),
                  () {
                    cartProviders.deleteCart(data.cartId);
                  },
                ),
              )
              .toList(),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart review'),
        ),
        body: cartProviders.getCartDataList.isNotEmpty
            ? _reviewCart()
            : Center(
                child: Text('No Item'),
              ),
        // body: cartProvider.getCartDataList.isEmpty
        //     ? Center(child: Text('No item'))
        //     : ListView.builder(
        //         itemCount: cartProvider.getCartDataList.length,
        //         itemBuilder: (context, index) {
        //           CartModel data = cartProvider.getCartDataList[index];
        //           return SingleItem(
        //             true,
        //             false,
        //             data.cartImage,
        //             data.cartName,
        //             data.cartPrice,
        //             data.cartId,
        //             data.cartQty.toString(),
        //             () {
        //               showAlertDialog(context, data);
        //             },
        //           );
        //         },
        //       ),
        bottomNavigationBar: cartProviders.getCartDataList.isNotEmpty
            ? Card(
                elevation: 11,
                child: ListTile(
                  title: Text('Total amount: '),
                  subtitle: Text('TK ${cartProviders.getTotalPrice()}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: DeliveryDetails(),
                        ),
                      );
                    },
                    child: Text('Check Out'),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
