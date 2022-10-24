// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_vegetable/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {
  String productId;
  String cartName;
  int cartPrice;
  String cartImage;
  Count(this.productId, this.cartName, this.cartPrice, this.cartImage,
      {Key? key})
      : super(key: key);

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;
  getAddAndQty() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("YourCartItems")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            print(value.data()),
            if (mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get(("cartQty"));
                      isTrue = value.get("isAdd");
                    })
                  }
              }
          },
        );
  }

  @override
  void initState() {
    // TODO: implement initState
    getAddAndQty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.productId);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Card(
      // elevation: 2,
      child: SizedBox(
        height: 36,
        width: 98,
        child: isTrue == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        if (count == 1) {
                          setState(() {
                            isTrue = false;
                          });
                          cartProvider.deleteCart(widget.productId);
                        }
                        if (count > 1) {
                          setState(() {
                            count--;
                          });
                          cartProvider.updateCart(
                            widget.productId,
                            widget.cartImage,
                            widget.cartName,
                            widget.cartPrice,
                            count,
                          );
                        }
                      },
                      child: Icon(Icons.remove)),
                  Text('$count'),
                  InkWell(
                    onTap: () {
                      setState(() {
                        count++;
                      });
                      cartProvider.updateCart(
                        widget.productId,
                        widget.cartImage,
                        widget.cartName,
                        widget.cartPrice,
                        count,
                      );
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    isTrue = true;
                  });
                  cartProvider.addCart(
                    widget.productId,
                    widget.cartImage,
                    widget.cartName,
                    widget.cartPrice,
                    count,
                  );
                },
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.shopping_cart_outlined),
                    Text('Add'),
                  ],
                )),
              ),
      ),
    );
  }
}
