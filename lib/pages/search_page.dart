// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fresh_vegetable/const/app_colors.dart';
import 'package:fresh_vegetable/model/product_model.dart';
import 'package:fresh_vegetable/pages/single_item.dart';

class Search extends StatefulWidget {
  List<ProductModel> search;
  Search(this.search, {Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = '';
  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> searchtems = searchItem(query);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Search product'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('Items'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 60,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Input search item',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                  ),
                ),
              ),
            ),
            Column(
              children: searchtems
                  .map(
                    (data) => SingleItem(
                        false,
                        false,
                        data.productImage,
                        data.productName,
                        data.productPrice,
                        data.productId,
                        data.productQty,
                        () {}),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
