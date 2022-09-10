import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {

  File? image;
  bool showSpinner = false;

  Future pickImage() async{
    final pickImage = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50);

    if(pickImage != null){
      image = File(pickImage.path);
      setState(() {

      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error Occured')));
    }
  }

  Future<void> uploadImage ()async{

    setState(() {
      showSpinner = true ;
    });

    var stream  = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = new http.MultipartRequest('POST', uri);

    request.fields['title'] = "Static title" ;

    var multiport = new http.MultipartFile(
        'image',
        stream,
        length);

    request.files.add(multiport);

    var response = await request.send() ;

    print(response.stream.toString());
    if(response.statusCode == 200){
      setState(() {
        showSpinner = false ;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfuly uploaded')));
      print('image uploaded');
      image =null;
    }else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed')));
      print('failed');
      setState(() {
        showSpinner = false ;
      });

    }

  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(title: Text('Image Upload'),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: ()=>pickImage(),
              child: Container(
                child: image == null? Center(
                  child: Container(
                    height: 200,
                      width: 200,
                      color: Colors.grey,
                      child: Center(child: Text('Upload Image'),)),
                ):
                  Container(
                    child: Center(
                      child: Image.file(
                        File(image!.path).absolute,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ),
            ),

            SizedBox(height: 30,),

            ElevatedButton(onPressed: ()=>uploadImage(), child: Text('Upload'))
          ],
        ),
      ),
    );
  }
}
