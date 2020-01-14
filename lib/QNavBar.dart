import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'QNavButton.dart';

class QNavBar extends StatefulWidget{
  double navHeight;
  double navTextSize=16;
  List<QNavTab> navTabs;
  QNavBar({ @required this.navTabs,this.navHeight:56,this.navTextSize});
  QNavBarState createState()=> QNavBarState();
}

class QNavBarState extends  State<QNavBar>{
  int selectIndex=0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var viewSize=MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top:BorderSide(width: 0.4,color: Colors.red))
      ),
      width: viewSize.width,
      height: widget.navHeight,
      child: Row(
        children: _buildNavButtons(),
      ),
    );
  }

  _buildNavButtons() {
    return widget.navTabs.map((tabItem){
      return QNavButton(
        tabView: tabItem,
        navHeight: widget.navHeight,
        selected: selectIndex==widget.navTabs.indexOf(tabItem),
        onPress:()=>onTapItem(widget.navTabs.indexOf(tabItem)),);
    }).toList();
  }

  onTapItem(int index) {
    if(selectIndex!=index){
      setState(() {
        selectIndex=index;
      });
    }
  }

}