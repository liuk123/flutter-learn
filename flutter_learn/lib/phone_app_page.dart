import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhoneApp extends StatefulWidget {
  @override
  _PhoneAppState createState() => _PhoneAppState();
}

class _PhoneAppState extends State<PhoneApp> {

  List<File> _images =[];
  Future getImage(bool isTakePhone) async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(source: isTakePhone?ImageSource.camera:ImageSource.gallery);
    setState(() {
      _images.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'phone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('phone'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: _getImages(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pickImage,
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
  _pickImage(){
    showModalBottomSheet(context: context, builder: (context)=>Container(
      height: 160,
      child: Column(
        children: <Widget>[
          _item('拍照',true),
          _item('从相册选择',false),
        ],
      ),
    ));
  }

  _item(String title, bool isTakePhone) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(isTakePhone? Icons.camera_alt:Icons.image_aspect_ratio),
        title: Text(title),
        onTap: ()=>getImage(isTakePhone),
      ),
    );
  }

  _getImages() {
    return _images.map((file){
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.file(
                file,
              width:100,
              height:90,
              fit: BoxFit.fill
            ),
          ),
          Positioned(
              right:5,
              top:5,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    _images.remove(file);
                  });
                },
                child: ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(color: Colors.black54),
                    child: Icon(Icons.close,size: 18,color: Colors.white,),
                  ),
                ),
              )
          )
        ],
      );
    }).toList();
  }
}
