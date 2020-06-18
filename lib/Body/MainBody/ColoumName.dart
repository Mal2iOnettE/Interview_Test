import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:test_interview/Body/MainBody/DM.dart';
import 'package:test_interview/Object/DayViewObject.dart';
import 'package:string_validator/string_validator.dart';

class ColName extends StatefulWidget {
  final String showdatePick;
  const ColName({Key key, this.showdatePick}) : super(key: key);

  @override
  _ColNameState createState() => _ColNameState();
}

class _ColNameState extends State<ColName> {
  List<JsonTableColumn> columns;
  var datePick;

/*
  @override
  void initState() {
    selectedDM=dms[0];
  }*/

  @override
  Widget build(BuildContext context) {
     datePick = '${widget.showdatePick}';
    print("Show Date 2 : "+datePick);
    return jsonTable();
  }

  Widget jsonTable() {
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
            var _dayList = dayObject.data.list;
            print("length " + dayObject.data.list.length.toString());
           
            return Container(
                //width: 300.0,
                height: 900.0,
                child: CustomScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 900.0, // image height
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemExtent: 50.0,
                              itemCount: 1,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                  Color color = index.isEven
                                    ? Colors.grey[600]
                                    : Colors.white;
                                return Container(
                                  child: Container(
                                    height: 500,
                                    color: color,
                                    child: DataTable(
                                      columns: [
                                        DataColumn(
                                            label: Text('Name',
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline2)),
                                        DataColumn(
                                            label: Text('ID',
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline2)),
                                        DataColumn(
                                            label: Text('Tier',
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline2)),
                                        DataColumn(
                                            label: Text('LTV',
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline2)),
                                        DataColumn(
                                            label: Text('Total Trans.',
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline2)),
                                        DataColumn(
                                            label: Text('Total Points',
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline2)),
                                        DataColumn(
                                            label: Text('Remaining Points',
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline2)),
                                      ],
                                      rows: _dayList
                                          .map((_dayList) => DataRow(cells: [
                                                DataCell(Text(
                                                    _dayList.customername)),
                                                DataCell(Text(
                                                    _dayList.customerphone)),
                                                DataCell(Text(
                                                    _dayList.customertier)),
                                                DataCell(Text(_dayList
                                                    .totalamount
                                                    .toString())),
                                                DataCell(Text(_dayList
                                                    .totaltransaction
                                                    .toString())),
                                                DataCell(Text(_dayList
                                                    .totalreward
                                                    .toString())),
                                                DataCell(Text(_dayList
                                                    .remainingpoint
                                                    .toString())),
                                              ]))
                                          .toList(),
                                    ),
                                  ),
                                );
                              }
                              ),
                        ),
                      ),
                    ]));
          }
        });
  }
/*
  String dropdownValue = 'Day View';
  var dateValue;
  

   DM selectedDM;
  List<DM> dms = <DM>[
    const DM("https://wegivmerchantapp.firebaseapp.com/exam/bi-member-day-2020-04-01.json",0,"Day View"), 
    const DM("https://wegivmerchantapp.firebaseapp.com/exam/bi-member-month-2020-03.json",1,"Month View"),
    const DM("https://wegivmerchantapp.firebaseapp.com/exam/bi-member-month-2020-03.json",2,"Quaetere View"),
    const DM("https://wegivmerchantapp.firebaseapp.com/exam/bi-member-month-2020-03.json",3,"Year View")
    ];


  Widget test(){
    return DropdownButton<DM>(
      value: selectedDM,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.amber[600]),
      onChanged: (DM newValue) {
        setState(() {
          selectedDM = newValue;
          //dateValue = dropdownValue;
        });
      },
      items: dms.map((DM dm)){
              return new DropdownMenuItem<DM>(
                value: dm,
                child: new Text(dm.url),
              );
            }).toList(),
            );
          
          new Text("selected DM ${selectedDM.url}"
        );
  }*/

  Future<DayViewObject> _fetchMainPageList() async {
    // print('_fetchMainPageList');
    String monthListUrl ="https://wegivmerchantapp.firebaseapp.com/exam/bi-member-month-2020-03.json";
    String dayListUrl ="https://wegivmerchantapp.firebaseapp.com/exam/bi-member-day-2020-04-01.json";

          
          try {
            Response response = await Dio().get(dayListUrl);
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
      

