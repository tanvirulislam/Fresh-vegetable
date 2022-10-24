// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh_vegetable/providers/cart_provider.dart';
import 'package:fresh_vegetable/widget/count.dart';
import 'package:provider/provider.dart';

class SingleItem extends StatefulWidget {
  bool isBool = false;
  bool wishListBool = false;
  String productImage;
  String productName;
  int productPrice;
  String productId;
  String productQty;
  var onDelete;
  SingleItem(
    this.isBool,
    this.wishListBool,
    this.productImage,
    this.productName,
    this.productPrice,
    this.productId,
    this.productQty,
    this.onDelete,
  );

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  @override
  void initState() {
    // TODO: implement initState
    CartProvider cartProvider = Provider.of(context, listen: false);
    cartProvider.getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    // cartProvider.getCart();
    // print(widget.productQty);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
        child: Card(
          color: Colors.grey.shade100,
          elevation: 2,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    height: 120,
                    child: Center(
                      child: FancyShimmerImage(
                        height: 107,
                        // width: 100,
                        boxFit: BoxFit.cover,
                        errorWidget: Center(child: Text('Image not Found')),
                        imageUrl: widget.productImage,
                      ),
                      // Image.network(
                      //   widget.productImage,
                      //   fit: BoxFit.cover,
                      //   height: 107,
                      // ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: widget.isBool == false
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('TK${widget.productPrice} / 500g'),
                        SizedBox(
                          height: 5,
                        ),
                        widget.isBool == false
                            ? InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height /
                                                3),
                                    context: context,
                                    builder: (context) => ListView(
                                      children: [
                                        Card(
                                          child: ListTile(
                                            title: Text('50gm'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Card(
                                          child: ListTile(
                                            title: Text('250gm'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Card(
                                          child: ListTile(
                                            title: Text('1kg'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Card(
                                          child: ListTile(
                                            title: Text('1kg'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Card(
                                          child: ListTile(
                                            title: Text('1kg'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Card(
                                  child: SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '50 g',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Text(
                                '50 g',
                                style: TextStyle(fontSize: 17),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: widget.isBool == false
                      ? Count(
                          widget.productId,
                          widget.productName,
                          widget.productPrice,
                          widget.productImage,
                        )
                      : Container(
                          // color: Colors.pink,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Count(
                                widget.productId,
                                widget.productName,
                                widget.productPrice,
                                widget.productImage,
                              ),
                              ElevatedButton.icon(
                                onPressed: widget.onDelete,
                                icon: Icon(Icons.delete_outline),
                                label: Text('Delete'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
