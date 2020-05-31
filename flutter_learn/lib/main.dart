import 'package:flutter/material.dart';
import 'package:flutter_learn/animation_b_page.dart';
import 'package:flutter_learn/animation_page.dart';
import 'package:flutter_learn/animation_w_page.dart';
import 'package:flutter_learn/app_Lifecycle_page.dart';
import 'package:flutter_learn/gesture_page.dart';
import 'package:flutter_learn/http_page.dart';
import 'package:flutter_learn/image_page.dart';
import 'package:flutter_learn/launch_page.dart';
import 'package:flutter_learn/layout_group_page.dart';
import 'package:flutter_learn/phone_app_page.dart';
import 'package:flutter_learn/photo_hero.dart';
import 'package:flutter_learn/photo_hero_a.dart';
import 'package:flutter_learn/res_page.dart';
import 'package:flutter_learn/stateful_group_page.dart';
import 'package:flutter_learn/stateless_group_page.dart';
import 'package:flutter_learn/widget_Lifecycle_page.dart';

void main() => runApp(DynamicTheme());
class DynamicTheme extends StatefulWidget{
  @override
  _DynamicThemeState createState() => _DynamicThemeState();
}
class _DynamicThemeState extends State<DynamicTheme>{
  Brightness _brightness = Brightness.light;
  bool _isDark = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: _brightness,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('moban'),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: Column(children: <Widget>[
            SwitchListTile(
                title: Text('${_isDark? "夜间模式":"日间模式"}'),
                value: _isDark,
                onChanged: (value) {
                  setState(() {
                    _brightness = value?Brightness.dark:Brightness.light;
                    _isDark = value;
                  });
                }),
            RouteNavigator(),
          ],),
        ),
        routes: <String, WidgetBuilder>{
          'less': (BuildContext context) => StateLessGroupPage(),
          'ful': (BuildContext context) => StatefulGroupPage(),
          'layout': (BuildContext context) => LayoutGroupPage(),
          'gesture': (BuildContext context) => GesturePage(),
          'res': (BuildContext context) => ResPage(),
          'launch': (BuildContext context) => LaunchPage(),
          'widgetlifecycle': (BuildContext context) => WidgetLifecycle(),
          'applifecycle': (BuildContext context) => AppLifecycle(),
          'phone': (BuildContext context) => PhoneApp(),
          'image': (BuildContext context) => ImagePage(),
          'animation': (BuildContext context) => AnimationPage(),
          'animated': (BuildContext context) => AnimatedWidgetPage(),
          'animationBuilder': (BuildContext context) => AnimatedBuildPage(),
          'hero': (BuildContext context) => HeroAnimation(),
          'heroA': (BuildContext context) => RadialExpansionDemo(),
          'http': (BuildContext context) => HttpPage(),
        });
  }
}

class RouteNavigator extends StatefulWidget {
  @override
  _RouteNavigatorState createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;
  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Wrap(
            spacing:10,
          children: <Widget>[
            SwitchListTile(
                title: Text('${byName ? '' : '不'}通过路由名跳转'),
                value: byName,
                onChanged: (value) {
                  setState(() {
                    byName = value;
                  });
                }),
            _item('statelessWidget', StateLessGroupPage(), 'less'),
            _item('statefulWidget', StatefulGroupPage(), 'ful'),
            _item('布局', LayoutGroupPage(), 'layout'),
            _item('手势', GesturePage(), 'gesture'),
            _item('资源引入', ResPage(), 'res'),
            _item('打开第三方应用', LaunchPage(), 'launch'),
            _item('widget生命周期', WidgetLifecycle(), 'widgetlifecycle'),
            _item('应用生命周期', AppLifecycle(), 'applifecycle'),
            _item('照相机', PhoneApp(), 'phone'),
            _item('图片', ImagePage(), 'image'),
            _item('动画', AnimationPage(), 'animation'),
            _item('动画widget', AnimatedWidgetPage(), 'animated'),
            _item('动画builder', AnimatedBuildPage(), 'animationBuilder'),
            _item('动画hero', HeroAnimation(), 'hero'),
            _item('动画heroA', RadialExpansionDemo(), 'heroA'),
            _item('http', HttpPage(), 'http'),
          ],
        ),
      );

  }

  _item(String title, page, String routeName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (byName) {
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}
