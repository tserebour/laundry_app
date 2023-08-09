abstract class Human {
  // final String server = '169.254.248.163';
  // final String server = '192.168.43.40';
  // final String server = 'https://superwashlaundry.000webhostapp.com';
  final String server = 'http://10.0.2.2';
  String response = "";

  int id = 0;
  String name = "";
  String username = "";
  String password = "";
  String confirm_password = "";

  Future login();
  Future signup();
}


