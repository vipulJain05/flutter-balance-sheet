import 'package:flutter/material.dart';

class Revenue extends StatefulWidget {
  @override
  _RevenueState createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Name',
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ),
          // Padding(
            
          // ),
          Expanded(
            child: Text(
              'Date',
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              'Amount',
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              'Desc',
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      Expanded(
        flex: 1,
          child: Container(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int item) {
                    return Card(
                      margin: EdgeInsets.only(top: 12.0,bottom: 2.0),
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'oil',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '12-02-2019',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Text(
                                '5000',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Profit',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))),
    ]));
  }
}
