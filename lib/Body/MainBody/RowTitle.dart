import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_interview/Object/DayViewObject.dart';

class RowTitle extends StatefulWidget {
  @override
  _RowTitleState createState() => _RowTitleState();
}

class _RowTitleState extends State<RowTitle> {
  List<String> titleList = ["Name","ID","Tier","Total Trans.","Total Point","Remaning Point"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Container(
        width: 880.0,
        color: Theme.of(context).accentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             listOfTitle()
          ],
        ),
      ),
    );
  }

  Widget listOfTitle() {
    String title = "";
    for (var item in titleList) {
      title += item ;
    }
    return Text(
      title.substring(0, title.length - 3),
      style: Theme.of(context).primaryTextTheme.headline2
      
    );
}
}