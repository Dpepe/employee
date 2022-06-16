import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'provide_employee.dart';


class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: LandingScreen(),
        ),
      ),
    );
  }
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {


  File? imageFile;
  void _openGallery(BuildContext context) async {

    final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(picture!.path); 
    });
    Navigator.of(context).pop();
    
  }
File? _storedImage;
Future imgTakePicture() async {
  final imageFile = await ImagePicker().pickImage(
    source: ImageSource.camera,
    maxHeight: 600,
  );
}
 File? picture;
 void _openCamera(BuildContext context) async {
    final picture = await ImagePicker().pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture!.path); 
    });
    Navigator.of(context).pop();
  }

  File? _image;
  final picker = ImagePicker();

  Future getImage(BuildContext context) async {
    final  pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage == null) return;

    File tmpFile = File(pickedImage.path);
  
    final path =  (await getApplicationDocumentsDirectory()).path;
   
    final newImage = await tmpFile.copy('$path/android_rob.jpg');
    
    setState(() {
      _image = newImage;
    });
  }
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    /* GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    ), */
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera SAVE LOCAL"),
                      onTap: () {
                        getImage(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }
  
  Widget _setImageView() {
    if (imageFile != null) {

      
      return Image.file(File(imageFile!.path), width: 400, height: 400);
    } else {
      return Text("No Image Selected");
    }
  }
  Widget _setImageGuarda() {
    if (_image != null) {
      return Image.file(File(_image!.path), width: 400, height: 400);
    } else {
      return Text("No Image Selected");
    }
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
             
              _setImageView(),
              _setImageGuarda(),
              GestureDetector(
                onTap: () {
                  _showChoiceDialog(context);
                },
                child: Text("Select Image!"),
              )
            ],
          ),
        ),
      ),
    );
  }
}