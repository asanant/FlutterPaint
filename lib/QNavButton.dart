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
      duration: Duration(milliseconds: 500),
    );
    _animationWidthController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animationCircleWith=CurvedAnimation(
      parent:  Tween<double>(begin: 0.8, end: 1.0).animate(_animationWidthController),curve: Curves.linear
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


    // TODO: implement build
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child:Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(width:MediaQuery.of(context).size.width ,height: widget.navHeight,),
            Positioned(
              child:Container(
                transform: Matrix4.translationValues(0, widget.selected? -(maxOffset*_animation.value):0, 0),
                child: CustomPaint(
                  painter:widget.selected?  BgButtonBubble(_animation.value):null,
                  child: Container(
                    width: widget.selected? circleExtend*_animationCircleWith.value:null,
                    height:widget.selected? circleExtend*_animationCircleWith.value:null,
                    alignment: Alignment.center,
                    child: Container(
                      constraints:BoxConstraints.tight(Size( 25,25)),
                      child: widget.tabView.tabView,
                    ),
                  ),
                ),
              ),
              bottom: SizedBox(child: Text("")).height,
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