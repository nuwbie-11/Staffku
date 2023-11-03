import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staffku/Components/MyButton/mybutton.dart';
import 'package:staffku/Components/MyTextField/mytextfield.dart';

import 'package:http/http.dart' as http;

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final unameController = TextEditingController();
  final passwdController = TextEditingController();
  final FilteringTextInputFormatter authFilter =
      FilteringTextInputFormatter.deny(RegExp(r'\s'));
  String resMessage = "";
  Map<String, dynamic> response = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  handleSubmit() async {
    try {
      final url = Uri.parse('http://10.0.2.2:8080/api/auth_user');
      final res = await http.post(
        url, 
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: 
          jsonEncode({
            'uname':unameController.text,
            'passwd':passwdController.text,
          })
        
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          if (data.containsKey('message')) {
            resMessage = "Auth Success";
          }
        });
        print(jsonDecode(res.body));
      }else{
        print("Failed to reach API");
      }

    } catch (e) {
      print("error code: ${e}");
    }
    // print(unameController.text);
    // print(passwdController.text);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 9,
                          offset: const Offset(0, 5),
                        )
                      ]),
                  height: height - 280,
                  width: width - 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        MyTextField(
                          hint: "Username",
                          controller: unameController,
                          obscureText: false,
                        ),
                        MyTextField(
                          hint: "Password",
                          controller: passwdController,
                        ),
                        Expanded(child: Container()),
                        MyButton(
                          label: "Masuk",
                          onPressed: handleSubmit,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:18.0),
              child: Center(
                child: Text(resMessage) ,
              ),
            )
          ],
        ),
      ),
    );
  }
}
