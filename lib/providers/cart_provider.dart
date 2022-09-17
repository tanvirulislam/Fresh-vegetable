import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_vegetable/model/cart_model.dart';

class CartProvider with ChangeNotifier {
  // add to cart----------
  void addCart(
    String cartId,
    String cartImage,
    String cartName,
    int cartPrice,
    int cartQty,
  ) {
    FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('YourCartItems')
        .doc(cartId)
        .set({
      'cartId': cartId,
      'cartImage': cartImage,
      'cartName': cartName,
      'cartPrice': cartPrice,
      'cartQty': cartQty,
      'isAdd': true,
    });
  }

  // update----------
  void updateCart(
    String cartId,
    String cartImage,
    String cartName,
    int cartPrice,
    int cartQty,
  ) {
    FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('YourCartItems')
        .doc(cartId)
        .update({
      'cartId': cartId,
      'cartImage': cartImage,
      'cartName': cartName,
      'cartPrice': cartPrice,
      'cartQty': cartQty,
      'isAdd': true,
    });
  }

  // show cart--------

  List<CartModel> cartDataList = [];
  void getCart() async {
    List<CartModel> newList = [];
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('YourCartItems')
        .orderBy('cartName', descending: false)
        .get();
    for (var element in qn.docs) {
      // print(element.data());
      CartModel cartModel = CartModel(
        element.get('cartId'),
        element.get('cartImage'),
        element.get('cartName'),
        element.get('cartPrice'),
        element.get('cartQty'),
      );
      newList.add(cartModel);
    }
    cartDataList = newList;
    notifyListeners();
  }

  List<CartModel> get getCartDataList {
    return cartDataList;
  }

  // total price

  getTotalPrice() {
    double total = 0;
    for (var element in cartDataList) {
      total += element.cartPrice * element.cartQty;
      // print('total price ------ ${total}');
    }
    return total;
  }

  deleteCart(cartId) {
    FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('YourCartItems')
        .doc(cartId)
        .delete();
    notifyListeners();
  }

  deleteAllCart() async {
    var collection = await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('YourCartItems')
        .get();
    for (var doc in collection.docs) {
      doc.reference.delete();
    }
  }
}
