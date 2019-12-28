import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class QNavButtonState extends State<QNavButton> with SingleTickerProviderStateMixin<QNavButton> {
  double circleExtend=30;
  double maxOffset=15;
  AnimationController _animationController;
  CurvedAnimation _animation;
  @override
  void initState() {
    // TODO: implement initState
    _animationController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );


    _animation= CurvedAnimation(parent: Tween<double>(begin: 0.6, end: 1.0).animate(_animationController),curve:  Curves.bounceInOut)..addListener((){
      setState(() {
      });
    });



    super.initState();

  }
  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          alignment: Alignment.center,
          height: widget.navHeight,
          child: Stack(
             alignment: Alignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: MediaQuery.of(context).size.width,),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    width: circleExtend,
                    height:circleExtend,
                    transform: Matrix4.translationValues(0, widget.selected? -(maxOffset*_animation.value):0, 0),
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                        gradient:widget.selected? LinearGradient(
                            colors: [Color(0xFFF1585A), Colors.green[300]]
                        ):null,
                        shape: CircleBorder()
                    ),
                    child: Container(
                      constraints:BoxConstraints.tight(Size( 25,25)),
                      child: widget.tabView.tabView,
                    ),
                  ),
                ],
              ),
              Positioned(
                child:Text(widget.tabView.tabText,style: TextStyle(color: widget.selected? Colors.red:Color(0xFF333333)),),
                bottom: 0,
              )
            ],
          ),
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

    if(widget.selected&&!_animationController.isAnimating){
      _animationController.forward();
    }else{
      _animationController.reverse();
    }
  }
}

class  QNavTab{
  String tabText;
  Widget tabView;

  QNavTab({this.tabText, this.tabView});
}