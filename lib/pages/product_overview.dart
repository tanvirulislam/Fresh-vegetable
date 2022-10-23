// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_vegetable/const/app_colors.dart';
import 'package:fresh_vegetable/providers/wish_list_provider.dart';
import 'package:fresh_vegetable/widget/count.dart';
import 'package:provider/provider.dart';

import 'review_cart.dart';

class ProductOverview extends StatefulWidget {
  final String productName;
  final String productImage;
  final int productPrice;
  final String productId;
  final String productQty;
  List<dynamic> productUnit;

  ProductOverview(
    this.productName,
    this.productImage,
    this.productPrice,
    this.productId,
    this.productQty,
    this.productUnit,
  );

  @override
  State<ProductOverview> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductOverview> {
  bool wishListBool = false;
  Widget bottomNavBar(
    Color color,
    Color iconColor,
    Color backgroundColor,
    IconData icondata,
    String title,
    var onTap,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60,
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icondata,
                color: iconColor,
                size: 17,
              ),
              SizedBox(
                width: 6,
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }

  getWishListBool() {
    FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('YourWishListItems')
        .doc(widget.productId)
        .get()
        .then((value) => {
              // print(value.data()),
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        wishListBool = value.get('wishList');
                        // print(wishListBool);
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);
    getWishListBool();
    var screenWidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Tk ${widget.productPrice.toString()}'),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: FancyShimmerImage(
                  height: screenheight > 450 ? 300 : 150,
                  width: screenWidth < 400 ? double.infinity : 200,
                  boxFit: BoxFit.fill,
                  errorWidget: Center(child: Text('Image not Found')),
                  imageUrl: widget.productImage,
                ),

                // Image.network(
                //   widget.productImage,
                //   height: screenheight > 450 ? 300 : 150,
                //   width: screenWidth < 400 ? double.infinity : 200,
                //   fit: BoxFit.fill,
                // ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: TK 30'),
                  SizedBox(
                    width:
                        screenWidth < 400 ? screenWidth / 2 : screenWidth / 1.5,
                  ),
                  Count(
                    widget.productId,
                    widget.productName,
                    widget.productPrice,
                    widget.productImage,
                  )
                ],
              ),
              Text('About this product', textScaleFactor: 2),
              SizedBox(
                height: 8,
              ),
              Text(
                  'One way you should be able to do this is using a Row as the top child of the Column which will contain the title "Home" as the Text widget and a CircleAvatar for profile image, and setting the mainAxisAlignment of the row to spaceBetween like this.. Show activity on this post'),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: primaryColor,
          width: double.infinity,
          height: 60,
          child: Row(
            children: [
              bottomNavBar(
                scaffoldBackground,
                Colors.black,
                wishListBool == false ? Colors.grey : Colors.lightGreen,
                wishListBool == false ? Icons.favorite_outline : Icons.favorite,
                wishListBool == false ? 'Add to wishlist' : 'Added to wishlist',
                () {
                  setState(() {
                    wishListBool = !wishListBool;
                  });
                  if (wishListBool == true) {
                    // print(widget.productQty);
                    wishListProvider.addToWishList(
                      widget.productId,
                      widget.productImage,
                      widget.productName,
                      widget.productPrice,
                      widget.productQty,
                      widget.productUnit,
                    );
                  } else {
                    wishListProvider.deleteWishList(widget.productId);
                  }
                },
              ),
              bottomNavBar(
                scaffoldBackground,
                Colors.black,
                Colors.grey,
                Icons.shopping_cart_outlined,
                'Go to cart',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewCart(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
