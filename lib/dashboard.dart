import 'package:flutter/material.dart';

class Profit extends StatefulWidget {
  @override
  _ProfitState createState() => _ProfitState();
}

class _ProfitState extends State<Profit> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              Text(
                'Year',
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
              new Card(
                elevation: 1.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Month',
                         style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Product',
                         style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                    ),
                    Expanded(
                      child: Text(
                        'Expense',
                         style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                    ),
                    Expanded(
                      child: Text(
                        'Revenue',
                         style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                    ),
                    Expanded(
                      child: Text(
                        'Profit',
                         style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
