import 'package:flutter/material.dart';

class AppLifecycle extends StatefulWidget {
  @override
  _AppLifecycleState createState() => _AppLifecycleState();
}

class _AppLifecycleState extends State<AppLifecycle> with WidgetsBindingObserver{
  
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state = $state');
    if(state== AppLifecycleState.paused){
      print('App进入后台');
    }else if(state == AppLifecycleState.resumed){
      print('App进入前台');
    }else if(state ==AppLifecycleState.inactive){
      print('App处于非活动状态,被挂起，并且未收到用户输入时调用，比如：来了个电话');
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  Widget build(BuildContext context) {
    print('===build===');
    return MaterialApp(
      title: '生命周期',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('生命周期'),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
              child: Column(
            children: <Widget>[

            ],
          ))),
    );
  }
}
