import 'package:flutter/material.dart';

class AnimatedWidgetPage extends StatefulWidget {
  @override
  _AnimatedWidgetPageState createState() => _AnimatedWidgetPageState();
}

class AnimatedLogo extends AnimatedWidget{
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      height: animation.value,
      width: animation.value,
      child: FlutterLogo(),
    );
  }
}

class _AnimatedWidgetPageState extends State<AnimatedWidgetPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
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
          body:  AnimatedLogo(animation:animation)
    ),
    );
  }
}
