import 'package:flutter/material.dart';

class WidgetLifecycle extends StatefulWidget {
  @override
  _WidgetLifecycleState createState() => _WidgetLifecycleState();
}

class _WidgetLifecycleState extends State<WidgetLifecycle> {
  int _count = 0;
  //创建widget时调用的除构造方法外第一个方法
  @override
  void initState() {
    print('===initState===');
    super.initState();
  }

  //initState之后调用
  //他所依赖的state改变的时候调用
  @override
  void didChangeDependencies() {
    print('===didChangeDependencies===');
    super.didChangeDependencies();
  }

  //didChangeDependencies方法之后调用
  //实现需要呈现的页面，当调用setState之后也会再次调用
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
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _count += 1;
                  });
                },
                child: Text(
                  '点我',
                  style: TextStyle(fontSize: 26),
                ),
              ),
              Text(_count.toString())
            ],
          ))),
    );
  }

  //父组件需要重新绘制时调用
  //该方法携带一个oldWidget方法，可以将其与当前的widget进行对比已便执行额外的逻辑
  //if (oldWidget.xxx != widget.xxx)...
  @override
  void didUpdateWidget(WidgetLifecycle oldWidget){
    print('===didUpdateWidget===');
    super.didUpdateWidget(oldWidget);
  }

  //很少使用，再组件被移除的时候调用，再dispose之前调用
  @override
  void deactivate() {
    print('===deactivate===');
    super.deactivate();
  }
  @override
  void dispose() {
    print('===dispose===');
    super.dispose();
  }
}
