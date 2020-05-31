import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math' as math;

class Photo extends StatelessWidget {
  const Photo({Key key, this.photo, this.onTap, this.width}) : super(key: key);
  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(.3),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, size) {
            return Image.network(
              photo,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  const RadialExpansion({
    Key key,
    this.child,
    this.maxRadius,
  })  : clipRectSize = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);

  final double maxRadius;
  final clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class RadialExpansionDemo extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);
  static RectTween _createRectRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(
      BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: kMaxRadius * 2,
                height: kMaxRadius * 2,
                child: Hero(
                    createRectTween: _createRectRectTween,
                    tag: imageName,
                    child: RadialExpansion(
                      maxRadius: kMaxRadius,
                      child: Photo(
                        photo: imageName,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )),
              ),
              Text(
                description,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(
      BuildContext context, String imageName, String description) {
    return Container(
      width: kMinRadius * 2,
      height: kMinRadius * 2,
      child: Hero(
          createRectTween: _createRectRectTween,
          tag: imageName,
          child: RadialExpansion(
            maxRadius: kMaxRadius,
            child: Photo(
              photo: imageName,
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder<void>(pageBuilder:
                    (BuildContext context, Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: opacityCurve.transform(animation.value),
                        child: _buildPage(context, imageName, description),
                      );
                    },
                  );
                }));
              },
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Radial hero animation'),
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          alignment: FractionalOffset.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildHero(
                  context, 'http://www.devio.org/img/avatar.png', 'ddddd'),
            ],
          ),
        ));
  }
}
