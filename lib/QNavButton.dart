import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_piant/BgButtonBubble.dart';

class QNavButton extends StatefulWidget{
  QNavTab tabView;
  double navHeight ;
  bool selected;
  final VoidCallback onPress;
  QNavButton({this.tabView,this.navHeight,this.selected,this.onPress});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QNavButtonState();
  }


}

class QNavButtonState extends State<QNavButton> with TickerProviderStateMixin<QNavButton> {
  double circleExtend=38;
  double maxOffset=12;
  AnimationController _animationController;
  AnimationController _animationWidthController;
  CurvedAnimation _animation;
  CurvedAnimation _animationCircleWith;
  @override
  void initState() {
    // TODO: implement initState
    _animationController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _animationWidthController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _animationCircleWith=CurvedAnimation(
      parent:  Tween<double>(begin: 0, end: 1.0).animate(_animationWidthController),curve: Curves.linear
    );

    _animation= CurvedAnimation(parent: Tween<double>(begin: 0, end: 1.0).animate(_animationController),curve:  Curves.bounceOut);

    Listenable.merge([_animationCircleWith,_animation]).addListener((){
      setState(() {
      });
    });
    _animationWidthController.addStatusListener((status){
      if(status==AnimationStatus.completed){
      _animationController.forward();
      };
    });


    super.initState();

  }
  @override
  Widget build(BuildContext context) {

     final  width=MediaQuery.of(context).size.width;
    // TODO: implement build
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child:Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(width:width,height: widget.navHeight,),
            Positioned(
              child:Container(
                transform: Matrix4.translationValues(0, widget.selected? -(maxOffset*_animation.value):0, 0),
                child: CustomPaint(
                  painter:widget.selected?  BgButtonBubble(transformOffest: _animation.value,circleScaleValue: _animationCircleWith.value):null,
                  child: Container(
                    margin: widget.selected? null: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    child: Container(
                      constraints:BoxConstraints.tight(Size( 25,25)),
                      child: widget.tabView.tabView,
                    ),
                  ),
                ),
              ),
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
            ),

            Positioned(
              child:Text(widget.tabView.tabText,style: TextStyle(color: widget.selected? Colors.red:Color(0xFF333333),),),
              bottom: 0,
                  )
          ],
        ),
        onTap: ()=>widget.onPress(),
      ),
    );
  }

  @override
  void didUpdateWidget(oldWidget) {


    _startAnimation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {

    if(widget.selected&&!_animationWidthController.isAnimating){
      _animationWidthController.forward();
    }else{
      _animationController.reverse();
      _animationWidthController.reverse();
    }
  }
}

class  QNavTab{
  String tabText;
  Widget tabView;

  QNavTab({this.tabText, this.tabView});
}