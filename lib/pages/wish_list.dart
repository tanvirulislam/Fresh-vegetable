// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_vegetable/const/app_colors.dart';
import 'package:fresh_vegetable/model/cart_model.dart';
import 'package:fresh_vegetable/model/product_model.dart';
import 'package:fresh_vegetable/pages/single_item.dart';
import 'package:fresh_vegetable/providers/wish_list_provider.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  void initState() {
    WishListProvider wishListProvider =
        Provider.of<WishListProvider>(context, listen: false);
    wishListProvider.WishListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);
    // wishListProvider.WishListData();
    // print(wishListProvider.getWishWishListData.length);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Wishlist'),
          ),
          body: ListView.builder(
            itemCount: wishListProvider.getWishWishListData.length,
            itemBuilder: (context, index) {
              ProductModel data = wishListProvider.getWishWishListData[index];
              return SingleItem(
                true,
                false,
                data.productImage,
                data.productName,
                data.productPrice,
                data.productId,
                data.productQty,
                () {
                  setState(() {
                    wishListProvider.deleteWishList(data.productId);
                  });
                },
              );
            },
          ),
          bottomNavigationBar: Card(
            elevation: 11,
            child: ListTile(
              title: Text('Total amount: '),
              subtitle: Text('TK 180'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: Text('Submit'),
              ),
            ),
          )),
    );
  }
}
