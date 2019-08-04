import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:event/services/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MonthData extends StatefulWidget {
  final year;
  MonthData(this.year);
  @override
  _MonthDataState createState() => _MonthDataState(this.year);
}

class _MonthDataState extends State<MonthData> {
  QuerySnapshot _monthwiseData;
  var year;
  InputType inputType = InputType.date;
  CrudServices _services = CrudServices();
  DateTime date;
  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  _MonthDataState(this.year);

  @override
  void initState() {
    _monthdata();
    super.initState();
  }

  Future _monthdata() async {
   await _services.monthWisedata(year).then((result){
      if(mounted){
        setState(() {
          _monthwiseData = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(year),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0,left: 8.0),
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Month',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20, fontWeight: FontWeight.bold),
                  ),
                ),
                
                Expanded(
                  child: Text(
                    'Revenue',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Expense',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Profit',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Expanded(flex: 1, child: _data()),
          ]),
        ));
  }

  Widget _data() {
    if (_monthwiseData != null) {
      return ListView.builder(
          itemCount: _monthwiseData.documents.length,
          itemBuilder: (BuildContext context, int item) {
            return Card(
              margin: EdgeInsets.only(top: 12.0, bottom: 2.0),
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _monthwiseData.documents[item].data['Month'],
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                    ),
                    
                    Expanded(
                      child: Text(
                        _monthwiseData.documents[item].data['Revenue'].toString(),
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _monthwiseData.documents[item].data['Expense'].toString(),
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _monthwiseData.documents[item].data['Total'].toString(),
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      return Center(
          child: Text("PLEASE WAIT.....", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)));
    }
  }
}