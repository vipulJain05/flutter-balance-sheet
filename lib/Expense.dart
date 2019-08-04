import 'dart:async';

import 'package:event/services/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Expense extends StatefulWidget {
  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  var flag = 0;
  var deletedItem;
  QuerySnapshot expenditure;
  // var size = MediaQuery.of(context).size.width / 6;
  // StreamSubscription<DocumentSnapshot> subscription;
  CrudServices services = CrudServices();
  // final DocumentReference documentReference = Firestore.instance.document('Expenditure');
  @override
  void initState() {
    _fetch();
    super.initState();
  }

  Future _fetch() async {
    await services.getData('Expenditure').then((result) {
      if(this.mounted){
        setState(() {
          expenditure = result;
        });
      }
        
      // }
    });
  }
  // @override
  // void dispose() {
  //   subscription?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 18;
    return Container(
      margin: EdgeInsets.only(top: 20.0,left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: width, fontWeight: FontWeight.bold),
                ),
              ),
              // Padding(

              // ),
              Expanded(
                child: Text(
                  'Date',
                  style: TextStyle(fontSize: width, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Amount',
                  style: TextStyle(fontSize: width, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Desc',
                  style: TextStyle(fontSize: width, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(flex: 1, child: Container(child: _data())),
        ],
      ),
    );
  }

  Widget _data() {
    if (expenditure != null) {
      return ListView.builder(
          itemCount: expenditure.documents.length == null
              ? 0
              : expenditure.documents.length,
          itemBuilder: (BuildContext context, int item) {
            return Card(
              margin: EdgeInsets.only(top: 12.0, bottom: 2.0),
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        expenditure.documents[item].data['name'],
                        style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width / 23),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        expenditure.documents[item].data['date'].toString(),
                        style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width / 23),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Text(
                        expenditure.documents[item].data['amount'],
                        style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width / 23),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Icon(Icons.description),
                        onTap: () {
                          _showDescription(item);
                        },
                      ),
                    ),
                  ],
                ),
                onLongPress: () {
                   services.delete('Expenditure', expenditure.documents[item].documentID,expenditure.documents[item].data['date'],expenditure.documents[item].data['amount']).catchError((err){
                     SnackBar(content: Text('$err'));
                   });
                  AlertDialog alertDialog = AlertDialog(
                          title: Text("Item Deleted"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                _fetch();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => alertDialog
                    );
                },
              ),
            );
          });
    } else {
      return Center(
        child: Text("Please wait ... ", style: TextStyle(fontSize: MediaQuery.of(context).size.width /18)),
      );
    }
  }

  _showDescription(int item) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        'Description',
        style: TextStyle(fontSize: 15.0),
      ),
      content: Text(
        expenditure.documents[item].data['description'],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }
}
