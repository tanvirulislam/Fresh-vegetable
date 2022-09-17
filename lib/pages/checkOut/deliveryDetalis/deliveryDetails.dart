// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fresh_vegetable/model/delivery_address_model.dart';
import 'package:fresh_vegetable/pages/checkOut/add_delivery_address/add_delivery_address.dart';
import 'package:fresh_vegetable/pages/checkOut/deliveryDetalis/single_delivery_item.dart';
import 'package:fresh_vegetable/pages/checkOut/payment/payment.dart';
import 'package:fresh_vegetable/providers/checkout_provider.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({Key? key}) : super(key: key);

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  @override
  void initState() {
    CheckoutProvider initDeliveryAddress = Provider.of(context, listen: false);
    initDeliveryAddress.getDeliveryAddress();
    super.initState();
  }

  var addressModel;

  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddress = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Delivery Details'),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/fresh-vegetable-1918b.appspot.com/o/location.png?alt=media&token=cf38c87b-9c17-49d4-9041-4a1014210646',
              ),
              title: Text('Deliver to'),
            ),
            Divider(),
            Column(
              children: [
                deliveryAddress.getDeliveryAddressData.isEmpty
                    ? Container(
                        child: Center(
                          child: Text('No address'),
                        ),
                      )
                    : Column(
                        children: deliveryAddress.getDeliveryAddressData
                            .map<Widget>((val) {
                          setState(() {
                            addressModel = val;
                          });
                          return SingleDeliveryItem(
                            number: val.mobile,
                            title: val.firstName,
                            addressType: '',
                            address: val.city,
                          );
                        }).toList(),
                      )
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddDeliveryAddress(),
                ));
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          height: 48,
          color: Colors.grey[200],
          child: TextButton(
            onPressed: () {
              deliveryAddress.getDeliveryAddressData.isEmpty
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDeliveryAddress(),
                      ))
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Payment(deliveryAddress: addressModel),
                      ));
            },
            child: deliveryAddress.getDeliveryAddressData.isEmpty
                ? Text('Add new address')
                : Text('Payment'),
          ),
        ),
      ),
    );
  }
}
