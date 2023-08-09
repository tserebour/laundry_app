import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './signup.dart';
import '/customobjects/customer.dart';
import '../customobjects/globals.dart' as globals;

import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  LoginState createState() => LoginState();
}

//creating a new customer object
var customer = Customer();
var show_error = '';
FocusNode emailNode = FocusNode(), passwordNode = FocusNode();

class LoginState extends State<Login> {
  String? _email, _password;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/1.jpg"),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: 'Log',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 18, 67, 100),
                              fontSize: 25)),
                      TextSpan(
                          text: ' In',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 15, 42, 61),
                              fontSize: 25))
                    ])),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            emailText(),
                            const SizedBox(
                              height: 20,
                            ),
                            passwordText(),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  LoginAndRedirect();
                                }
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0XFF2c6cac),
                                      // boxShadow: const [
                                      //   BoxShadow(offset: Offset(0, 0), blurRadius: 0)
                                      // ]
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          (!loading)
                                              ? const Text(
                                                  "Login",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                )
                                              : const SizedBox(
                                                  child:
                                                      CircularProgressIndicator()),
                                        ])),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Colors.black45,
                              // fontSize: 12,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.end,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? ",
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const Signup(),
                              ),
                            ),
                            child: const Text("Sign Up",
                                style: TextStyle(
                                    color: Color(0XFF2c6cac),
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container emailText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 3,
              offset: const Offset(0, 4),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the username';
            }
            return null;
          },
          style: const TextStyle(
              fontSize: 16,
              color: Color(0XFF0E2433),
              fontWeight: FontWeight.w400),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            labelText: "Username",
            labelStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
                fontWeight: FontWeight.w400),
            hintStyle: const TextStyle(
                fontSize: 15,
                color: Color(0XFF0E2433),
                fontWeight: FontWeight.w400),
            fillColor: Colors.grey[500],
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.person,
              color: Color(0XFF0E2433),
            ),
          ),
          focusNode: emailNode,
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            customer.username = value;
            FocusScope.of(context).requestFocus(passwordNode);
          },
          onChanged: (value) {
            customer.username = value;
          },
        ),
      ),
    );
  }

  Container passwordText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white70),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3,
              offset: const Offset(0, 3),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                show_error = 'Please enter password';
                return show_error;
              } else if (show_error == 'incorrect password' ||
                  show_error == 'incorrect inputs') {
                show_error = 'incorrect inputs';
                return show_error;
              }
              return null;
            },
            style: TextStyle(
                fontSize: 14, color: Colors.grey[500], letterSpacing: 2),
            textAlignVertical: TextAlignVertical.center,
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Password",
              labelStyle: const TextStyle(
                fontSize: 17,
                color: Color(0XFF0E2433),
              ),
              hintStyle: const TextStyle(
                  fontSize: 17, color: Color(0XFF0E2433), letterSpacing: 3),
              fillColor: Colors.grey[500],
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0XFF0E2433),
              ),
            ),
            focusNode: passwordNode,
            maxLines: 1,
            textInputAction: TextInputAction.go,
            onFieldSubmitted: (value) {
              customer.password = value;
              // Focus.of(context).requestFocus(confirmPasswordNode);
            },
            onChanged: (value) {
              customer.password = value;
              // Focus.of(context).requestFocus(confirmPasswordNode);
            }),
      ),
    );
  }

  Future LoginAndRedirect() async {
    await customer.login();
    print(customer.response);

    if (customer.response.isNotEmpty) {
      var data = await json.decode(customer.response);
      print(data['response']);
      if (data['response'] == "successful") {
        globals.customer_name = data['name'];
        globals.number_of_orders = data['number_of_orders'];
        globals.customer_id = int.parse(data['id']);

        Navigator.pushReplacementNamed(context, '/home',
            arguments: {'name': data['name']});
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login successful!')));
      }
    } else if (customer.response == 'incorrect password' ||
        customer.response == 'incorrect username') {
      show_error = 'incorrect inputs';
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Incorrect user input!')));
    } else {
      print('error with server');
      customer.response = 'error with server';
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Server error!')));
    }
  }
}
