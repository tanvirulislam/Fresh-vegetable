// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fresh_vegetable/const/app_colors.dart';
import 'package:fresh_vegetable/pages/product_overview.dart';
import 'package:fresh_vegetable/pages/review_cart.dart';
import 'package:fresh_vegetable/pages/search_page.dart';
import 'package:fresh_vegetable/providers/product_provider.dart';
import 'package:fresh_vegetable/widget/drawer.dart';
import 'package:fresh_vegetable/widget/product_shimmer.dart';
import 'package:fresh_vegetable/widget/single_product.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // late ProdcutProvider prodcutProvider;
  @override
  void initState() {
    ProdcutProvider initProdcutProvider = Provider.of(context, listen: false);
    initProdcutProvider.fatchHerbsProductData();
    initProdcutProvider.fatchFreshProductData();
    initProdcutProvider.fatchRootProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProdcutProvider prodcutProvider = Provider.of(context);

    Widget _buildHerbsProduct() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Herbs food'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: Search(prodcutProvider.getHerbProductDataList),
                        ),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         Search(prodcutProvider.getHerbProductDataList),
                      //   ),
                      // );
                    },
                    child: Text('View all'))
              ],
            ),
          ),
          SizedBox(
            height: 240,
            child: prodcutProvider.getHerbProductDataList.isEmpty
                ? ProductShimmer()
                : ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: prodcutProvider.getHerbProductDataList
                        .map(
                          (herbProductData) => Card(
                            child: SingalProduct(
                              herbProductData.productImage,
                              herbProductData.productName,
                              () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ProductOverview(
                                        herbProductData.productName,
                                        herbProductData.productImage,
                                        herbProductData.productPrice,
                                        herbProductData.productId,
                                        herbProductData.productQty,
                                        herbProductData.productUnit),
                                  ),
                                );
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ProductOverview(
                                //         herbProductData.productName,
                                //         herbProductData.productImage,
                                //         herbProductData.productPrice,
                                //         herbProductData.productId,
                                //         herbProductData.productQty,
                                //         herbProductData.productUnit),
                                //   ),
                                // );
                              },
                              herbProductData.productPrice,
                              herbProductData.productId,
                              herbProductData,
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      );
    }

    Widget _buildFreshProduct() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fresh food'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child:
                              Search(prodcutProvider.getFreshProductDataList),
                        ),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         Search(prodcutProvider.getFreshProductDataList),
                      //   ),
                      // );
                    },
                    child: Text('View all'))
              ],
            ),
          ),
          SizedBox(
            height: 240,
            child: prodcutProvider.getFreshProductDataList.isEmpty
                ? ProductShimmer()
                : ListView(
                    scrollDirection: Axis.horizontal,
                    children: prodcutProvider.getFreshProductDataList
                        .map(
                          (freshProduct) => Card(
                            child: SingalProduct(
                              freshProduct.productImage,
                              freshProduct.productName,
                              () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ProductOverview(
                                        freshProduct.productName,
                                        freshProduct.productImage,
                                        freshProduct.productPrice,
                                        freshProduct.productId,
                                        freshProduct.productQty,
                                        freshProduct.productUnit),
                                  ),
                                );
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ProductOverview(
                                //         freshProduct.productName,
                                //         freshProduct.productImage,
                                //         freshProduct.productPrice,
                                //         freshProduct.productId,
                                //         freshProduct.productQty,
                                //         freshProduct.productUnit),
                                //   ),
                                // );
                              },
                              freshProduct.productPrice,
                              freshProduct.productId,
                              freshProduct,
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      );
    }

    Widget _buildRootProduct() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Root food'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: Search(prodcutProvider.getRootProductDataList),
                        ),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         Search(prodcutProvider.getRootProductDataList),
                      //   ),
                      // );
                    },
                    child: Text('View all'))
              ],
            ),
          ),
          SizedBox(
            height: 240,
            child: prodcutProvider.getRootProductDataList.isEmpty
                ? ProductShimmer()
                : ListView(
                    scrollDirection: Axis.horizontal,
                    children: prodcutProvider.getRootProductDataList
                        .map(
                          (rootProduct) => Card(
                            child: SingalProduct(
                              rootProduct.productImage,
                              rootProduct.productName,
                              () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ProductOverview(
                                        rootProduct.productName,
                                        rootProduct.productImage,
                                        rootProduct.productPrice,
                                        rootProduct.productId,
                                        rootProduct.productQty,
                                        rootProduct.productUnit),
                                  ),
                                );
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ProductOverview(
                                //         rootProduct.productName,
                                //         rootProduct.productImage,
                                //         rootProduct.productPrice,
                                //         rootProduct.productId,
                                //         rootProduct.productQty,
                                //         rootProduct.productUnit),
                                //   ),
                                // );
                              },
                              rootProduct.productPrice,
                              rootProduct.productId,
                              rootProduct,
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: Search(prodcutProvider.getRootProductSearchList),
                    ),
                  );
                },
                icon: Icon(Icons.search)),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: ReviewCart(),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart_outlined),
            ),
          ],
        ),
        drawer: drawerCustom(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/fresh-vegetable-1918b.appspot.com/o/banner.jpg?alt=media&token=f4e04671-c51a-4708-ab21-2c80b7e0facc',
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      width: 80,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: Center(
                        child: Text(
                          'Vegetable',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('30% off',
                                  textScaleFactor: 2,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                'on all vegetable products',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildHerbsProduct(),
              _buildFreshProduct(),
              _buildRootProduct(),
            ],
          ),
        ),
        // bottomNavigationBar: BottomCustome(),
      ),
    );
  }
}
