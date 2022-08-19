import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: SizedBox(
        height: 240,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            // for (var i; i< 3; i++)
            Card(
              child: Container(
                height: 240,
                width: 170,
                color: Colors.amber,
              ),
            ),
            Card(
              child: Container(
                height: 240,
                width: 170,
                color: Colors.amber,
              ),
            ),
            Card(
              child: Container(
                height: 240,
                width: 170,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade300,
    );
  }
}
