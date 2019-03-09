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
      body: TabBarView(
        controller: tabcontroller,
        children: <Widget>[
          Newtab('profit or loss'),
          Newtab('Revenue'),
          Newtab('Expenditure'),
        ],      
      ),
    );
  }

  Widget tabbar(String data){
    return Tab(text: data,);
  }
}

class Newtab extends StatelessWidget {
  final data;
  Newtab(this.data);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(data),
    );
  }
}