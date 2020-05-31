import 'package:flutter/material.dart';

class ResPage extends StatefulWidget {
  @override
  _ResPageState createState() => _ResPageState();
}

class _ResPageState extends State<ResPage> {
  String printString = '';
  double moveX = 0, moveY = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '使用资源文件',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('使用资源文件'),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  width: 100,
                  height: 100,
                  image: AssetImage('images/r.jpg'),
                )
              ],
            ),
          )),
    );
  }
}
