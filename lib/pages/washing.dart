import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../customobjects/receipt.dart';
import '../confirmation_page.dart';
import '../customobjects/service_prices.dart';
import '../customobjects/globals.dart' as globals;
import '../customobjects/customer.dart';
import '../customobjects/cloth.dart';



import '../models/counter_widget.dart';
import 'login.dart';

class Washing extends StatefulWidget {
  const Washing({super.key, this.operation});
  final String? operation;
  @override
  WashingState createState() => WashingState();
}

class WashingState extends State<Washing> {
  // var service_columns = [];
  // List <Service_price> service_prices = [];
  double sum = 0;
  callback(varSum) {
    setState(() {
      // sum += varSum;
    });
  }

  double total_sum = 0;

  String response = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.grey[600],
                          size: 25,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          color: Colors.grey[600],
                          size: 25,
                        ),
                      )
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(widget.operation.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                height: 20,
              ),

              FutureBuilder(
                  future: getService(),
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          serviceColumns(),
                        ],
                      ),
                    );
                  })

              // serviceColumns(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.white, blurRadius: 1)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: AlertDialog(
                              title: const Text('Order'),
                              content: Text(
                                  'Please that will be GHS ${globals.total_amount}'),
                              actions: [
                                TextButton(
                                  // textColor: Colors.black,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('CANCEL'),
                                ),
                                TextButton(
                                  // textColor: Colors.black,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    orderAndRedirect();
                                  },
                                  child: const Text('ACCEPT'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                });
              },
              child: Container(
                width: 150,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0XFF0E2433)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Done",
                      style: TextStyle(color: Colors.white70),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white70,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// method for the search box
  Container buildSearchContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white70),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 3,
              offset: const Offset(0, 3),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextField(
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            fillColor: Colors.grey[500],
            icon: const Icon(Icons.search),
          ),
          maxLines: 1,
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }

  Future orderAndRedirect() async {
    await Receipt().orders();

    String response = await globals.response;

    if (response == 'successful') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPage(),
        ),
      );
    }
  }

  // method to render the service columns

  Future<Object> getService() async {
    try {
      final result = await InternetAddress.lookup(Customer().server);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      this.response = 'error';
    }

    var url = Uri.parse('${Customer().server}/laundry/services.php');
    // var url = Uri.http(Customer().server, '/laundry/services.php');

    Map user_info = {
      'service_type': widget.operation,
    };

    var response = await http.post(url, body: user_info);

    if (response.statusCode == 200) {
      // print('status: ${response.statusCode}');

      this.response = response.body.toString();
      // print(this.response);

      return response.body.toString();
    } else {
      // print('status: ${response.statusCode}');

      this.response = 'error';

      return response.body.toString();
    }
  }

  Column serviceColumns() {
    // getService();

    List<Widget> columns = [];
    List<Service_price> servicePrices = [];
    List children = [];
    List<int> quantities = [];

    if (!response.isNotEmpty) {
      // List children =  jsonDecode(this.response);
    } else if (response == 'error') {
      columns.add(const Text('error loading page'));
    } else {
      children = jsonDecode(response);

      for (int i = 0; i < children.length; i++) {
        Map data = children[i];
        Service_price servicePrice = Service_price();
        servicePrice.id = int.parse(data['id']);
        servicePrice.cloth = Cloth(0, data['type_of_cloth'].toString());
        servicePrice.price = double.parse(data['price']);

        servicePrices.add(servicePrice);

        String imageUrl = data['image_url'].toString();
        String typeOfCloth = data['type_of_cloth'].toString();
        String price_ = data['price'].toString();

        int id = int.parse(data['id']);
        double price = double.parse(price_);
        //
        //
        //
        quantities.add(0);
        columns.add(CounterWidget(imageUrl, typeOfCloth, "\$" + price_,
            servicePrices, quantities, i, callback));

        if (i != children.length - 1) {
          columns.add(const SizedBox(
            height: 20,
          ));
        }
      }

      if (response == 'error') {
        return Column();
      }
    }

    if (columns.isEmpty) {
      columns.add(const Text('loading...'));
    }
    //
    //
    return Column(
      children: columns,
    );
  }
}
