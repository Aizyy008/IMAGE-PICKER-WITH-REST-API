import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? imagePath;
  final imagePicker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final imagePicked = await imagePicker.pickImage(
        source: ImageSource.gallery
        , imageQuality: 80);

    if (imagePicked != null) {
      imagePath = File(imagePicked!.path);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No image selected")));
    }
  }


  Future<void> uploadImage()  async{

    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(imagePath!.openRead());
    stream.cast();


    var length = await imagePath!.length();
    
    var uri = Uri.parse("https://fakestoreapi.com/products");
    var request = await http.MultipartRequest('POST', uri);
    request.fields["title"] = "Static Title";

    var multiport = http.MultipartFile('image', stream, length);

    request.files.add(multiport);

    var response = await request.send();
    if(response.statusCode == 200){
      setState(() {
        showSpinner = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image Uploaded")));
    }else{
      setState(() {
        showSpinner = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
          title: Text("Upload Image"),
        ),
        backgroundColor: Colors.black12,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: imagePath == null
                  ? Center(
                      child: TextButton(
                        onPressed: () {
                          getImage();
                        },
                        child: Text("Pick image"),
                      ),
                    )
                  : Container(
                      child: Image.file(
                        File(imagePath!.path).absolute,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),

            SizedBox(
              width: 240,
              height: 30,
              child: FloatingActionButton(onPressed: (){uploadImage();},child: Text("Upload Image"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),),
            )
          ],
        ),
      ),
    );
  }
}
