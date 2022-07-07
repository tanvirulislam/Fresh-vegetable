import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh_vegetable/model/product_model.dart';

class WishListProvider with ChangeNotifier {
  void addToWishList(
    String wishListId,
    String wishListImage,
    String wishListName,
    String wishListPrice,
    String wishListQty,
      List<dynamic> wishListUnit,
  ) {
    FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('YourWishListItems')
        .doc(wishListId)
        .set({
      'wishListId': wishListId,
      'wishListImage': wishListImage,
      'wishListName': wishListName,
      'wishListPrice': wishListPrice,
      'wishListQty': wishListQty,
      'wishList': true,
      'wishListUnit':wishListUnit,
    });
  }

  // show wishList data------------------
  List<ProductModel> wishList = [];
 Future WishListData() async {
    List<ProductModel> newList = [];
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('YourWishListItems')
        .get();

    qn.docs.forEach((element) {
      print(element.data());
      ProductModel productModel = ProductModel(
        element.get('wishListImage'),
        element.get('wishListName'),
        element.get('wishListPrice'),
        element.get('wishListId'),
        element.get('wishListQty'),
        element.get('wishListUnit'),
      );
      newList.add(productModel);
    });
    wishList = newList;
    notifyListeners();
  }

  List<ProductModel> get getWishWishListData {
    return wishList;
  }

  // delete wishlist----------------
  deleteWishList(productId) {
    FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('YourWishListItems')
        .doc(productId)
        .delete();
        notifyListeners();
  }
}
