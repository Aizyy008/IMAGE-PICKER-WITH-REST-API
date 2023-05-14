import 'package:flutter/material.dart';
import 'package:login_signup_postapi/upload_image.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage(
                    "https://thumbs.dreamstime.com/b/smiley-yellow-face-emoji-white-background-smiley-yellow-face-emoji-white-background-vector-150787032.jpg"),
                fit: BoxFit.contain,),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageScreen()));
                
              }, child: Text("UPLOAD IMAGE", style: TextStyle(fontWeight: FontWeight.bold),))
            ],
          )),
    );
  }
}
