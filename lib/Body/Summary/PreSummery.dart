import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_interview/Body/Summary/PreSummery2.dart';
import 'package:test_interview/Object/DayViewObject.dart';
import 'package:test_interview/Object/ColorObject/ColorObject.dart';


class PreSummary extends StatefulWidget {
  @override
  _PreSummaryState createState() => _PreSummaryState();
}

class _PreSummaryState extends State<PreSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 880.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: [
              _buildMainPageWidget(),
              PreSummery2()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainPageWidget() {
    return FutureBuilder(
        future: _fetchMainPageList(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.none &&
              snapShot.hasData == null) {
            return Container(
              child: Text(
                'Your data is empty.',
                style: TextStyle(
                    color: Color.fromRGBO(233, 233, 232, 1),
                    fontWeight: FontWeight.w200,
                    fontFamily: 'prompt',
                    fontSize: 22),
              ),
            );
          } else if (snapShot.hasData) {
            DayViewObject dayObject = snapShot.data;
            var _dayList = dayObject.data.summarytier;
            return Container(
              width: 350.0,
              height: 150.0,
              color: Colors.amber[300],
              child: CustomScrollView(
                physics: NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260.0, // image height
                      child: ListView.builder(
                        //physics: AlwaysScrollableScrollPhysics(),
                        itemExtent: 350.0, //image width
                        itemCount: 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          color: Theme.of(context).primaryColor,
                          height: 100.0,
                          //margin: EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                        "Total Members: ",
                                        style: Theme.of(context).primaryTextTheme.headline1
                                      ),
                                      trailing: Text(_dayList[0].totalMembers.toString(),
                                        style: Theme.of(context).primaryTextTheme.headline1)
                                    ),
                                  ),
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                        "Total Rev.(THB): ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      trailing: Text(_dayList[0].totalAmount.toString(),
                                        style: Theme.of(context).primaryTextTheme.headline1)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<DayViewObject> _fetchMainPageList() async {
    try {
      String homePageUrl = "https://wegivmerchantapp.firebaseapp.com/exam/bi-member-day-2020-04-01.json";
      Response response = await Dio().get(homePageUrl);
      var resultOfList = DayViewObject.fromJson(response.data);
      //print(response.data);
      //print("ResultOfList: $resultOfList");
      if (resultOfList.code == 0) {
        return resultOfList;
      } else {
        _showDialog(resultOfList.msg);
        return null;
      }
    } on DioError catch (e) {
      //print('ERROR Message >>> ${e.message}');
      _showDialog(e.message);
      return null;
    }
  }

  void _showDialog(String errMessage) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
