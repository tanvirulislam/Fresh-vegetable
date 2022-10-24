// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fresh_vegetable/model/product_model.dart';
import 'package:fresh_vegetable/pages/single_item.dart';
import 'package:fresh_vegetable/providers/wish_list_provider.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  void initState() {
    // WishListProvider wishListProvider =
    //     Provider.of<WishListProvider>(context, listen: false);
    // wishListProvider.wishListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);
    wishListProvider.wishListData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wishlist'),
        ),
        body: wishListProvider.getWishWishListData.isEmpty
            ? Center(
                child: Text('No Item'),
              )
            : ListView.builder(
                itemCount: wishListProvider.getWishWishListData.length,
                itemBuilder: (context, index) {
                  ProductModel data =
                      wishListProvider.getWishWishListData[index];
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
      ),
    );
  }
}
