import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpPage extends StatefulWidget {
  @override
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  String showResult = '';

  Future<CommonModel> fetchPost() async {
    final response = await http
        .get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    Utf8Decoder utf8Decoder = Utf8Decoder();//fix 中文乱码
    final result = json.decode(utf8Decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'http',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('http'),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: FutureBuilder<CommonModel>(
              future: fetchPost(),
              builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                    return Text('Input a URL to start');
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator(),);
                  case ConnectionState.active:
                    return Text('');
                  case ConnectionState.done:
                    if(snapshot.hasError){
                      return Text(
                        '${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      );
                    }else{
                      return Column(children: <Widget>[
                        Text('icon: ${snapshot.data.icon}')
                      ],);
                    }
                }
                return null;
              }
          )
      ),
    );
  }
}

class CommonModel {
  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}
