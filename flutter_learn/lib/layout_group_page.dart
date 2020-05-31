import 'package:flutter/material.dart';

class LayoutGroupPage extends StatefulWidget {
  @override
  _LayoutGroupPageState createState() => _LayoutGroupPageState();
}

class _LayoutGroupPageState extends State<LayoutGroupPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter布局',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('flutter布局'),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipOval(
                    child: Image.network('http://www.devio.org/img/avatar.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Opacity(
                        opacity: 0.6,
                        child: Image.network(
                            'http://www.devio.org/img/avatar.png',
                            width: 100,
                            height: 100),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 100,
                  margin: EdgeInsets.all(10),
                  child: PhysicalModel(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    clipBehavior: Clip.antiAlias,
                    child: PageView(
                      children: <Widget>[
                        _item('Page1', Colors.deepOrange),
                        _item('Page2', Colors.deepPurple),
                        _item('Page3', Colors.red)
                      ],
                    ),
                  )),
              Column(
                children: <Widget>[
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Text('FractionallySizedBox宽度撑满'),
                    ),
                  )
                ],
              ),
              Stack(
                children: <Widget>[
                  Image.network(
                    'http://www.devio.org/img/avatar.png',
                    width: 100,
                    height: 100,
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Image.network(
                      'http://www.devio.org/img/avatar.png',
                      width: 36,
                      height: 36,
                    ),
                  )
                ],
              ),
              Wrap(
                spacing: 8,//水平边距
                runSpacing: 6,//垂直边距
                children: <Widget>[
                  _chip('Flutter'),
                  _chip('Flutter'),
                  _chip('Flutter'),
                  _chip('Flutter'),
                  _chip('Flutter'),
                  _chip('Flutter'),
                ],
              ),
              Expanded(child: Container(
                decoration: BoxDecoration(color:Colors.red),
                child: Text('自动充满Column'),
              ))
            ],
          ),
        ),
      ),
    );
  }

  _item(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }

  _chip(String label) {
    return Chip(
      label: Text(label),
      avatar: CircleAvatar(
        backgroundColor: Colors.blue.shade900,
        child: Text(
          label.substring(0, 1),
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
