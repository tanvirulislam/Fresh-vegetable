// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:fresh_vegetable/model/delivery_address_model.dart';
import 'package:fresh_vegetable/pages/checkOut/deliveryDetalis/single_delivery_item.dart';
import 'package:fresh_vegetable/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  final DeliveryAddressModel deliveryAddress;
  Payment({Key? key, required this.deliveryAddress}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  // late CartProvider cartProvidersss;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartProvider cartProvider = Provider.of(context, listen: false);
    cartProvider.getCart();
    // print(cartProvider.cartDataList);
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvidersss = Provider.of(context);
    double discount = 10;
    double subtotalPrice = cartProvidersss.getTotalPrice();
    double discountPrice=0;
    if (subtotalPrice > 300) {
      double savings = subtotalPrice * (10 / 100);
       discountPrice = subtotalPrice - savings;
      print('discountPrice------- ${discountPrice}');
    }
    print('discountPrice------- ${discountPrice}');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Payment summery'),
        ),
        bottomNavigationBar: Card(
          color: Colors.grey[200],
          elevation: 2,
          child: ListTile(
            title: Text('Total Amount'),
            subtitle: Text('TK ${discountPrice==0?subtotalPrice+20:discountPrice+20}'),
            trailing: ElevatedButton(onPressed: () {}, child: Text('Place order')),
          ),
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  child: SingleDeliveryItem(
                    number: 'Mobile: ${widget.deliveryAddress.mobile}',
                    title: 'Name: ${widget.deliveryAddress.firstName}',
                    addressType: '',
                    address: 'City: ${widget.deliveryAddress.city}',
                  ),
                ),
                Divider(),
                ExpansionTile(
                  title: Text(
                      'Total order items  ${cartProvidersss.getCartDataList.length}'),
                  children: cartProvidersss.getCartDataList.map<Widget>((e) {
                    return ListTile(
                      leading: Image.network(e.cartImage),
                      title: Text(e.cartName),
                      subtitle: Text(e.cartQty.toString()),
                      trailing: Text('TK ${e.cartPrice.toString()}'),
                    );
                  }).toList(),
                ),
                ListTile(
                  title: Text('Subtotal'),
                  trailing:
                      Text('TK ${cartProvidersss.getTotalPrice().toString()}'),
                ),
                ListTile(
                  title: Text('Shipping charge'),
                  trailing: Text('TK 20'),
                ),
                ListTile(
                  title: Text('Compen discount'),
                  subtitle: Text('Discount will apply above TK300'),
                  trailing: Text('10%'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
