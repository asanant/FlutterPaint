import 'package:flutter/material.dart';

class BgButtonBubble extends CustomPainter{
  Paint mPaint;
  double transformOffest;
  double circleScaleValue;
  BgButtonBubble({this.transformOffest,this.circleScaleValue}){

    if(mPaint==null){
      mPaint =Paint()
        ..isAntiAlias=true
        ..style=PaintingStyle.fill;
    }

  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var centerOffset=Offset(size.width /2,size.height/2);
    var radius= ((size.height/2)*0.78) *circleScaleValue;

    mPaint.shader=null;
    mPaint.color=Colors.white;
    canvas.drawCircle(centerOffset, radius+radius*0.3, mPaint);


    if(mPaint.shader==null){
      mPaint.shader=new LinearGradient(colors:[Colors.blue,Colors.green]).createShader(Rect.fromCenter(center: centerOffset,width: size.width,height:size.height));
    }
    canvas.drawCircle(centerOffset, radius, mPaint);


    print("transformOffest:${transformOffest.toString()}");
   if(transformOffest>0){
     var tranheight=transformOffest;
     if(tranheight==1){
       tranheight=0;
     }
     Path path =Path()
       ..moveTo(centerOffset.dx-radius*0.93, centerOffset.dy+radius*0.4)
       ..quadraticBezierTo(centerOffset.dx, size.height+(radius*0.6)*tranheight, centerOffset.dx+radius*0.93, centerOffset.dy+radius*0.4);
     canvas.drawPath(path, mPaint);

   }




  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }



}