import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './login.dart';
import 'home.dart';
import '/customobjects/customer.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  SignupState createState() => SignupState();
}

FocusNode usernameNode = FocusNode(),
    firstnameNode = FocusNode(),
    lastnameNode = FocusNode(),
    addressNode = FocusNode(),
    phoneNode = FocusNode(),
    emailNode = FocusNode(),
    passwordNode = FocusNode(),
    confirmPasswordNode = FocusNode();

class SignupState extends State<Signup> {
  Customer customer = Customer();
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: 'Sign',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xff2c6cac),
                              fontSize: 30)),
                      TextSpan(
                          text: ' Up',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Color(0XFF0e6e9e),
                              fontSize: 30))
                    ])),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                        key: _formKey,
                        // autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            usernameText(),
                            const SizedBox(
                              height: 15,
                            ),
                            firstnameText(),
                            const SizedBox(
                              height: 15,
                            ),
                            lastnameText(),
                            const SizedBox(
                              height: 15,
                            ),
                            addressText(),
                            const SizedBox(
                              height: 15,
                            ),
                            phoneText(),
                            const SizedBox(
                              height: 15,
                            ),
                            emailText(),
                            const SizedBox(
                              height: 15,
                            ),
                            passwordText(),
                            const SizedBox(
                              height: 15,
                            ),
                            confirmPassword(),
                            const SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  loading = true;
                                  SignupAndRedirect();
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
                                                  "Signup",
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
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account ? ",
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const Login(),
                              ),
                            ),
                            child: const Text("Login",
                                style: TextStyle(
                                    color: Color(0XFF2c6cac),
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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

  Container usernameText() {
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
          focusNode: usernameNode,
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            customer.username = value;
            FocusScope.of(context).requestFocus(firstnameNode);
          },
          onChanged: (value) {
            customer.username = value;
          },
        ),
      ),
    );
  }

  Future SignupAndRedirect() async {
    await customer.signup();
    if (customer.response == "successful") {
      Navigator.pushNamed(context, '/loginpage');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')));
    } else if (customer.response == "password confirm error") {
      print("Please enter");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password does not match!')));
    } else {
      print('ii');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error has occured!')));
    }
  }

  Container firstnameText() {
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
              return 'Please enter the firstname';
            }
            return null;
          },
          style: const TextStyle(
              fontSize: 16,
              color: Color(0XFF0E2433),
              fontWeight: FontWeight.w400),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            labelText: "Firstname",
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
          focusNode: firstnameNode,
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            customer.name = value;
            FocusScope.of(context).requestFocus(lastnameNode);
          },
          onChanged: (value) {
            customer.name = value;
          },
        ),
      ),
    );
  }

  Container lastnameText() {
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
              return 'Please enter the lastname';
            }
            return null;
          },
          style: const TextStyle(
              fontSize: 16,
              color: Color(0XFF0E2433),
              fontWeight: FontWeight.w400),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            labelText: "Lastname",
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
          focusNode: lastnameNode,
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            customer.lastname = value;
            FocusScope.of(context).requestFocus(addressNode);
          },
          onChanged: (value) {
            customer.lastname = value;
          },
        ),
      ),
    );
  }

  Container addressText() {
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
              return 'Please enter the address';
            }
            return null;
          },
          style: const TextStyle(
              fontSize: 16,
              color: Color(0XFF0E2433),
              fontWeight: FontWeight.w400),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            labelText: "GPS Address",
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
              Icons.location_pin,
              color: Color(0XFF0E2433),
            ),
          ),
          focusNode: addressNode,
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            customer.address = value;
            FocusScope.of(context).requestFocus(phoneNode);
          },
          onChanged: (value) {
            customer.address = value;
          },
        ),
      ),
    );
  }

  Container phoneText() {
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
              return 'Please enter phone number';
            }
            return null;
          },
          keyboardType: TextInputType.phone,
          style: const TextStyle(
              fontSize: 16,
              color: Color(0XFF0E2433),
              fontWeight: FontWeight.w400),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            labelText: "Phone",
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
              Icons.phone,
              color: Color(0XFF0E2433),
            ),
          ),
          focusNode: phoneNode,
          maxLines: 1,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            customer.phone = value;
            FocusScope.of(context).requestFocus(emailNode);
          },
          onChanged: (value) {
            customer.phone = value;
          },
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
              return 'Please enter the email';
            }
            return null;
          },
          style: const TextStyle(
              fontSize: 16,
              color: Color(0XFF0E2433),
              fontWeight: FontWeight.w400),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            labelText: "Email",
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
              Icons.mail_outline,
              color: Color(0XFF0E2433),
            ),
          ),
          focusNode: emailNode,
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            customer.email = value;
            FocusScope.of(context).requestFocus(passwordNode);
          },
          onChanged: (value) {
            customer.email = value;
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
              return 'Please enter the password';
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
            Focus.of(context).requestFocus(confirmPasswordNode);
          },
          onChanged: (value) {
            customer.password = value;
          },
        ),
      ),
    );
  }

  Container confirmPassword() {
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
              return 'Please enter the password';
            }
            return null;
          },
          style: TextStyle(
              fontSize: 14, color: Colors.grey[500], letterSpacing: 2),
          textAlignVertical: TextAlignVertical.center,
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: "Confirm Password",
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
          focusNode: confirmPasswordNode,
          maxLines: 1,
          textInputAction: TextInputAction.go,
          onFieldSubmitted: (value) {
            customer.confirm_password = value;
            confirmPasswordNode.unfocus();
          },
          onChanged: (value) {
            customer.confirm_password = value;
          },
        ),
      ),
    );
  }
}
