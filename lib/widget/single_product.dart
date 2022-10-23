// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh_vegetable/model/product_model.dart';
import 'package:fresh_vegetable/widget/count.dart';
import 'package:fresh_vegetable/widget/product_unit.dart';

class SingalProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final int productPrice;
  var onTap;
  final String productId;
  final ProductModel productUnit;

  // ignore: use_key_in_widget_constructors
  SingalProduct(
    this.productImage,
    this.productName,
    this.onTap,
    this.productPrice,
    this.productId,
    this.productUnit,
  );

  @override
  State<SingalProduct> createState() => _SingalProductState();
}

class _SingalProductState extends State<SingalProduct> {
  // ignore: prefer_typing_uninitialized_variables
  var unitData;
  // ignore: prefer_typing_uninitialized_variables
  var firstUnitValue;
  @override
  Widget build(BuildContext context) {
    widget.productUnit.productUnit.firstWhere((element) {
      setState(() {
        firstUnitValue = element;
      });
      return true;
    });

    return SizedBox(
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: widget.onTap,
              child: FancyShimmerImage(
                boxFit: BoxFit.cover,
                errorWidget: Center(child: Text('Image not Found')),
                imageUrl: widget.productImage,
              ),

              // Image.network(
              //   widget.productImage,
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              // ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      '${widget.productPrice}TK / ${unitData == null ? firstUnitValue : unitData}'),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ProductUnit(
                          onTap: () {
                            showModalBottomSheet(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height / 3),
                              context: context,
                              builder: (context) => ListView(
                                  children: widget.productUnit.productUnit
                                      .map<Widget>((data) => Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    unitData = data;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Card(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8,
                                                          horizontal: 4),
                                                      child: Text(data),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                      .toList()),
                            );
                          },
                          title: unitData == null ? firstUnitValue : unitData,
                        ),
                      ),
                      Count(
                        widget.productId,
                        widget.productName,
                        widget.productPrice,
                        widget.productImage,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          // SizedBox(height: ,)
        ],
      ),
    );
  }
}
