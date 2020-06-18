import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:test_interview/Object/DayViewObject.dart';
import 'package:json_table/src/json_table_column.dart';

class BuildBottomTab extends StatefulWidget {
  @override
  _BuildBottomTabState createState() => _BuildBottomTabState();
}

class _BuildBottomTabState extends State<BuildBottomTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 880.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildMainPageWidget(),
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
            var _dayList = dayObject.data.summary;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200.0,
                  width: 880.0,
                  color: Colors.amber[300],
                  child: CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 50.0, // image height
                          child: ListView.builder(
                            //physics: AlwaysScrollableScrollPhysics(),
                            itemExtent: 880.0, //image width
                            itemCount: 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              color: Theme.of(context).primaryColor,
                              height: 100.0,
                              //margin: EdgeInsets.all(5.0),
                              child: Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Container(
                                            child: Text("Total",
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline1)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 345.0),
                                        child: Container(
                                            child: Text(
                                                _dayList.lifetimevalue
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline1)),
                                      ),
                                       Container(height: 20,width: 20, child: VerticalDivider(color: Colors.white)),
                                       Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30.0,right:30.0),
                                        child: Container(
                                            child: Text(
                                                _dayList.totaltransaction
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline1)),
                                      ),
                                      Container(height: 20,width: 20, child: VerticalDivider(color: Colors.white)),
                                       Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0,right:35.0),
                                        child: Container(
                                            child: Text(
                                                _dayList.totalpoint
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline1)),
                                      ),
                                      Container(height: 20,width: 20, child: VerticalDivider(color: Colors.white)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0,right:35.0),
                                        child: Container(
                                            child: Text(
                                                _dayList.remainingpoint
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline1)),
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
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<DayViewObject> _fetchMainPageList() async {
    // print('_fetchMainPageList');
    try {
      String homePageUrl =
          "https://wegivmerchantapp.firebaseapp.com/exam/bi-member-day-2020-04-01.json";
      Response response = await Dio().get(homePageUrl);
      var resultOfList = DayViewObject.fromJson(response.data);
      //print(response.data);
      // print("ResultOfList: $resultOfList");
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
