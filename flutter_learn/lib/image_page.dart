import 'dart:io';

import 'package:flutter/material.dart';
//获取储存卡的路径
import 'package:path_provider/path_provider.dart';
//在内存中加载图片
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImagePage extends StatefulWidget {
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '图片',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('图片'),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: Column(
            children: <Widget>[
              Image(width: 100, height: 100, image: AssetImage('images/r.jpg')),
              Image.asset('images/r.jpg',width:100,height: 100,),
              Image.file(File('/sdcard/Download/Stack.png')),
              FutureBuilder(
                future: _getLocalFile("Download/Stack.png"),
                builder: (BuildContext context, AsyncSnapshot<File> snapshot){
                  return snapshot.data != null?Image.file(snapshot.data):Container();
                },
              ),
              Stack(
                children: <Widget>[
                  Center(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: 'http://www.devio.org/img/avatar.png',
                    ),
                  )
                ],
              ),
              //下载图片缓存，
              CachedNetworkImage(
                placeholder: (context,url)=>CircularProgressIndicator(),
                imageUrl: 'https://picsum.photos/250?image=9',
              )
            ],
          )),
    );

  }
  Future<File> _getLocalFile(String filename) async{
    String dir = (await getExternalStorageDirectory()).path;
    File f = new File('$dir/$filename');
    return f;
  }
//  _getLocalFile(String s) {}
}
