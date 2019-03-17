import 'package:event/Add_Values.dart';
import 'package:event/Expense.dart';
import 'package:event/Revenue.dart';
import 'package:event/dashboard.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  TabController tabcontroller;

  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
        bottom: TabBar(
          controller: tabcontroller,
          tabs: <Widget>[
            tabbar('profit/loss'),
            tabbar('revenue'),
            tabbar('expenditure'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        tooltip: 'Add transaction',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return AddDetails();
          }));
        },
      ),
      body: TabBarView(
        controller: tabcontroller,
        children: <Widget>[
          // Newtab('profit or loss'),
          // Newtab('Revenue'),
          // Newtab('Expenditure'),

          //Newtab(),
          Profit(),
          Revenue(),
          Expense(),
          // Newtab('Revenue'),
          // Newtab('Expenditure'),
        ],
      ),
    );
  }

  Widget tabbar(String data) {
    return Tab(
      text: data,
    );
  }
}
