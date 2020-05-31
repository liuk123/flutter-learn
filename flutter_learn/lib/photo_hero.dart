import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class PhoneHero extends StatelessWidget {

  const PhoneHero({Key key, this.photo, this.onTap, this.width}) : super(key:key);
  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Hero(tag: photo, child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(photo, fit: BoxFit.contain,),
          ),
        ),)
    );
  }
}



class HeroAnimation extends StatefulWidget{
  @override
  _HeroAnimationState createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Basic hero animation'),),
      body: Center(child:
      PhoneHero(
        photo: 'http://www.devio.org/img/avatar.png',
        width: 300.0,
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Scaffold(
              appBar: AppBar(title: const Text('flippers Page'),),
              body: Container(
                color: Colors.lightBlueAccent,
                padding: EdgeInsets.all(16),
                alignment: Alignment.topLeft,
                child: PhoneHero(
                  photo: 'http://www.devio.org/img/avatar.png',
                  width: 100.0,
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                ),
              ),
            );
          }));
        },
      ),),
    );
  }
}

