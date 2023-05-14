import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';
import 'package:login_signup_postapi/main_screen.dart';
import 'package:login_signup_postapi/sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController  = TextEditingController();
  TextEditingController passwordController  = TextEditingController();



  void login(String email, String password) async {
    try{
      Response response = await http.post(Uri.parse("https://reqres.in/api/login"),
          body: {
            "email" : email,
            "password": password
          }
      );
      if(response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Successfully'),
          ),
        );
        var data = jsonDecode(response.body.toString());
        print(data);

        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
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
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email,color: Colors.teal.shade900,),
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
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.teal.shade900,),
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
                  child: Text("LogIn"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not having account??"),
              TextButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) =>SignUpScreen()));
              }, child: Text("Sign Up", style: TextStyle(fontSize: 20, color: Colors.white),))
            ],
          )
        ],
      ),
    );
  }
}
