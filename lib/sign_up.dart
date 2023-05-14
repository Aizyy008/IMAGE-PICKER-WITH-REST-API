import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  TextEditingController emailController  = TextEditingController();
  TextEditingController passwordController  = TextEditingController();



  void login(String email, String password) async {
    try{
        Response response = await http.post(Uri.parse("https://reqres.in/api/register"),
        body: {
          "email" : email,
    "password": password
        }
        );
        if(response.statusCode == 200){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Account Created Successfully'),
            ),
          );
          var data = jsonDecode(response.body.toString());
          print(data);
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed'),
            ),
          );
        }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text("Sign Up"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email,color: Colors.teal,),
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline, color: Colors.teal,),
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),

            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 30),
            child: SizedBox(
              width: 240,
              height: 30,
              child: FloatingActionButton(onPressed: (){
                login(emailController.text.toString(), passwordController.text.toString());
              },
                  backgroundColor: Colors.teal,
              child: Text("Sign Up"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
          ),


        ],
      ),
    );
  }
}
