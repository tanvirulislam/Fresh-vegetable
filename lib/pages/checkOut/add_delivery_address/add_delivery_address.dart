// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fresh_vegetable/const/app_colors.dart';
import 'package:fresh_vegetable/providers/checkout_provider.dart';
import 'package:fresh_vegetable/widget/custome_text_field.dart';
import 'package:provider/provider.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    CheckoutProvider checkoutProvider = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add delivery address'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: checkoutProvider.firstName,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'please enter first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: checkoutProvider.lastName,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'please enter last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: checkoutProvider.mobile,
                  decoration: InputDecoration(labelText: 'Mobile No'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'please enter mobile no';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: checkoutProvider.city,
                  decoration: InputDecoration(labelText: 'City'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'please enter city';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: checkoutProvider.area,
                  decoration: InputDecoration(labelText: 'Area'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'please enter area';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    child: Container(
                        height: 40,
                        width: double.infinity,
                        child: Text('Set location'))),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          height: 48,
          color: Colors.grey[200],
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Address added')),
                );
                checkoutProvider.validator();
              }
            },
            child: Text('Add address'),
          ),
        ),
      ),
    );
  }
}
