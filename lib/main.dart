import 'package:flutter/material.dart';
import 'package:flutter_piant/QNavButton.dart';
import 'dart:math';

import 'QNavBar.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: CustomPaint(
          child:Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            child: Text("1111"),
          ),
          painter: new TestPaint(),
        ),
      ),
      bottomNavigationBar: QNavBar(navTabs: [
        QNavTab( tabText: "主页",tabView: Image.asset("assets/ic_test.png",width: 1000,)),
        QNavTab( tabText: "主页2",tabView:Image.asset("assets/ic_test.png")),
      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TestPaint extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
     Paint paint =Paint()
         ..strokeWidth=2
         ..isAntiAlias=true
         ..style=PaintingStyle.stroke
         ..color=Colors.red;
   //  canvas.drawLine(Offset(0,0), Offset(100,100), paint); 直线

   //  canvas.drawCircle(Offset(size.width/2,size.height/2,), 50, paint); 圆形

   //  canvas.drawRect(Rect.fromPoints(Offset(300, 300),Offset(400, 500)), paint); 矩形

   /*Path  path =Path()
     ..moveTo(10, 10)
     ..lineTo(300, 300)
     ..lineTo(20, 400);*/

 /*  Path path =Path()
     ..moveTo(200,200)
     ..quadraticBezierTo(210,100,300,200);*/ //二阶贝塞尔曲线


     var radius=size.width/2-10;
     var center=Offset(size.width/2,size.height/2);
     Path path =Path()
     ..moveTo(0, 0)
     ..arcTo(Rect.fromCircle(center:center,radius:radius ), 0.0, 3.14159*2 , true)
     ..moveTo(10, size.height/2)
     ..quadraticBezierTo((size.width/2)/2, (size.height/2)-(radius*0.6), center.dx, center.dy)
     ..moveTo(center.dx, center.dy)
     ..quadraticBezierTo((size.width/2)/2+radius, (size.height/2)+(radius*0.6), center.dx+radius, center.dy);
     canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}
