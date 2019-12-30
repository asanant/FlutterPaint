import 'package:flutter/material.dart';

class BgButtonBubble extends CustomPainter{
  Paint mPaint;
  double transformOffest;
  BgButtonBubble(this.transformOffest){

    if(mPaint==null){
      mPaint =Paint()
        ..isAntiAlias=true
        ..style=PaintingStyle.fill;
    }

  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var center_offest=Offset(size.width/2,size.height/2);
    var radius= size.width/2;
    if(mPaint.shader==null){
      mPaint.shader=new LinearGradient(colors:[Colors.blue,Colors.green]).createShader(Rect.fromCenter(center: center_offest,width: size.width,height:size.height));
    }
     canvas.drawCircle(center_offest, radius, mPaint);
    if(transformOffest<0.5){
      Path path =Path()
        ..moveTo(size.width*0.3, size.height*0.5)
        ..quadraticBezierTo(center_offest.dx, size.height-((0.7-transformOffest)*(size.height*0.5)), size.width-(size.width*0.3), size.height*0.5);

      canvas.drawPath(path, mPaint);

    }


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }



}