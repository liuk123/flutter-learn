import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  String printString = '';
  double moveX = 0, moveY = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '打开第三方应用',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('打开第三方应用'),
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
                RaisedButton(
                  onPressed: () => _launchURL(),
                  child: Text('打开浏览器'),
                ),
                RaisedButton(
                  onPressed: () => _openMap(),
                  child: Text('打开地图'),
                )
              ],
            ),
          )),
    );
  }

  _launchURL() async {
    const url = 'https://flutter.dev';
    print(123);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _openMap() async{
    const url = 'geo:50.32.4.917';
    if(await canLaunch(url)){
      await launch(url);
    }else{
      const url = 'http://maps.apple.com/?ll=52.23.4.917';
      if(await canLaunch(url)){
        await launch(url);
      }else{
        throw 'Could not launch';
      }
    }
  }
}
