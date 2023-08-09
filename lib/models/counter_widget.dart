import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../customobjects/order.dart';
import '../customobjects/customer.dart';
import '../customobjects/globals.dart' as globals;

import '../customobjects/receipt.dart';
import '../customobjects/service_prices.dart';
import '../flutter_counter.dart';
import '../pages/login.dart';

class CounterWidget extends StatefulWidget {
  CounterWidget(this.image, this.nom, this.prix, this.service_prices,
      this.quantities, this.id, this.callback,
      {super.key});

  final String image, nom, prix;
  int selected = 0;
  int id = 0;
  double sum = 0;
  List<Service_price> service_prices = [];
  List<int> quantities = [];
  Function callback;

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<CounterWidget> {
  double sum = 0;

  @override
  Widget build(BuildContext context) {
    return buildContainerClothes(widget.image, widget.nom, widget.prix,
        widget.service_prices, widget.quantities);
  }

  Widget buildContainerClothes(String image, String nom, String prix,
      List<Service_price> servicePrices, List<int> quantities) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white70),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                )
              ]),
          child: Image.asset(
            image,
            height: 50,
            width: 50,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nom,
              style: TextStyle(fontSize: 22, color: Colors.grey[700]),
            ),
            Text(
              prix,
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ],
        ),
        Counter(
          minValue: 0,
          maxValue: 100,
          decimalPlaces: 0,
          initialValue: widget.selected,
          step: 1,
          color: Colors.white,
          textStyle: const TextStyle(letterSpacing: 0),
          onChanged: (value0) {
            print(value0);
            setState(() {
              widget.selected = value0.toInt();
              widget.quantities[widget.id] = value0.toInt();
            });
            double val = calculateTotal();
            globals.total_amount = val;
            // widget.callback(val);
          },
        ),
      ],
    );
  }

  void colleceAllOrder() {
    Map receipt = {};

    Map customer = {
      'id': globals.customer_id,
    };

    List orders = [];

    for (int i = 0; i < widget.service_prices.length; i++) {
      if (widget.quantities[i] > 0) {
        Map service_prices = {'id': widget.service_prices[i].id};

        Map order = {
          'quantity': widget.quantities[i],
          'price': widget.service_prices[i].price,
          'service_prices': service_prices
        };

        orders.add(order);
      }
    }

    receipt = {
      'customer': customer,
      'total_amount': globals.total_amount,
      'orders': orders
    };

    globals.receipt = receipt;
    var data = jsonEncode(globals.receipt);
    print(data);
  }

  double calculateTotal() {
    // print(widget.quantities);

    double sum = 0;

    // print(widget.service_prices[widget.id].price);

    for (int i = 0; i < widget.service_prices.length; i++) {
      double price = widget.service_prices[i].price;
      int quantity = widget.quantities[i];

      double multiplier = price * quantity;
      print(price.toString() +
          ' * ' +
          quantity.toString() +
          ' = ' +
          multiplier.toString());

      sum = sum + multiplier;
      // print(quantity);
    }

    print(sum);
    globals.total_amount = sum;
    colleceAllOrder();
    return sum;
  }
}
