import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh_vegetable/model/product_model.dart';

class ProdcutProvider with ChangeNotifier {
  late ProductModel productModel;
  List<ProductModel> search = [];
  productsModel(QueryDocumentSnapshot querySnapshot) {
    productModel = ProductModel(
      querySnapshot.get('productImage'),
      querySnapshot.get('productName'),
      querySnapshot.get('productPrice'),
      querySnapshot.get('productId'),
      querySnapshot.get('productQty'),
      querySnapshot.get('productUnit'),
    );
    search.add(productModel);
  }

  // herbs products --------------------------------------
  List<ProductModel> herbProductList = [];

  fatchHerbsProductData() async {
    List<ProductModel> newHerbProductList = [];
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('HerbsProduct')
        .orderBy('productName', descending: false)
        .get();
    for (var element in qn.docs) {
      // print(element.data());

      productsModel(element);
      newHerbProductList.add(productModel);
    }
    herbProductList = newHerbProductList;
    notifyListeners();
  }

  List<ProductModel> get getHerbProductDataList {
    return herbProductList;
  }
  // fresh products---------------------------------------

  List<ProductModel> freshProductList = [];
  fatchFreshProductData() async {
    List<ProductModel> newFreshProductList = [];
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('FreshProduct')
        .orderBy('productName', descending: false)
        .get();
    qn.docs.forEach(
      (element) {
        // print(element.data());
        productsModel(element);
        newFreshProductList.add(productModel);
      },
    );
    freshProductList = newFreshProductList;
    notifyListeners();
  }

  List<ProductModel> get getFreshProductDataList {
    return freshProductList;
  }

  // root food-----------------
  List<ProductModel> rootProductList = [];
  fatchRootProductData() async {
    List<ProductModel> newRootProductList = [];
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('RootProduct')
        .orderBy('productName', descending: false)
        .get();
    qn.docs.forEach(
      (element) {
        // print(element.data());
        productsModel(element);
        newRootProductList.add(productModel);
      },
    );
    rootProductList = newRootProductList;
    notifyListeners();
  }

  List<ProductModel> get getRootProductDataList {
    return rootProductList;
  }

  // get search product
  List<ProductModel> get getRootProductSearchList {
    return search;
  }
}
