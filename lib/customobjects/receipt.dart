import 'dart:convert';

import 'customer.dart';
import 'order.dart';
import 'package:http/http.dart' as http;
import '../customobjects/globals.dart' as globals;

class Receipt{
  int id = 0;
  List<Order>orders_list  = [];
  Order order = Order();
  double total_amount = 0.0;
  Customer customer = Customer();
  DateTime date_time = DateTime.now();




  Future orders() async{

    print(customer.server);

    var data = await jsonEncode(globals.receipt);
    var url = Uri.parse('${customer.server}/laundry/order.php');
    // var url = Uri.http(customer.server, '/laundry/order.php');
    // print(customer.server+'/laundry/order.php');

    Map user_info = await{
      'data': data,

    };

    var response = await http.post(url, body: user_info);
    print('await');
    // var response = http.post(Uri.http(this.server, '/laundry/login_val.php'));

    String r = response.body.toString();

    if(response.statusCode == 200){

      print('status: ${response.statusCode}');
      // print('status: ${response.body}');

      globals.response = response.body;
      return response.body.toString();

    }else{
      return 'error';
    }

  }


}