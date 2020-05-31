import 'package:flutter/material.dart';

class AnimatedBuildPage extends StatefulWidget {
  @override
  _AnimatedBuildPageState createState() => _AnimatedBuildPageState();
}

class LogoWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget{

  GrowTransition({this.child,this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:animation,
      builder: (context, child) => Container(
        height: animation.value,
        width:animation.value,
        child: child,
      ),
      child: child,
    );
  }

}

class _AnimatedBuildPageState extends State<AnimatedBuildPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
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
          body:  GrowTransition(animation:animation, child: LogoWidget(),)
    ),
    );
  }
}
