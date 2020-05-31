import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;

  double animationValue;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          animationValue = animation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          animationStatus = status;
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '动画',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('动画'),
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
              GestureDetector(
                onTap: () {
                  controller.reset();
                  controller.forward();
                },
                child: Text(
                  'start',
                  textDirection: TextDirection.ltr,
                ),
              ),
              Text(
                'Start:' + animationStatus.toString(),
                textDirection: TextDirection.ltr,
              ),
              Text(
                'Value:' + animationValue.toString(),
                textDirection: TextDirection.ltr,
              ),
              Container(
                height: animation.value,
                width: animation.value,
                child: FlutterLogo(),
              )
            ],
          ))),
    );
  }
}
