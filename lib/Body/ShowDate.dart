import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:test_interview/Body/MainBody/ColoumName.dart';
import 'package:test_interview/Body/MySelectionItem.dart';

class ShowDate extends StatefulWidget {
  ShowDate({Key key}) : super(key: key);
  @override
  _ShowDateState createState() => _ShowDateState();
}

class _ShowDateState extends State<ShowDate> {

  String dropdownValue = 'Day View';
  String dateValue = 'Day View';

  @override
  Widget build(BuildContext context) {
    print("show date: "+dateValue);
    return ListTile(
      title: Text("$dateValue"),
      trailing: Container(
        width: 220.0,
          child: Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _dropdown(), 
          _dropdown()
          ],
      )),
    );
  }
   

  Widget _dropdown() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.amber[600]),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          dateValue = dropdownValue;
        });
      },
      items: <String>['Day View', 'Month View', 'Quarter View', 'Year View']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  void showdatePick(String dateValue) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ColName(showdatePick:dateValue)));
  }
}
