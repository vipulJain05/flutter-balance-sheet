// import 'dart:async';

// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:event/services/services.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class Profit extends StatefulWidget {
//   @override
//   _ProfitState createState() => _ProfitState();
// }

// class _ProfitState extends State<Profit> {
//   QuerySnapshot _profitLoss;
//   InputType inputType = InputType.date;
//   CrudServices _services = CrudServices();
//   bool editable = true;
//   DateTime date;
//   final formats = {
//     InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
//     InputType.date: DateFormat('yyyy-MM-dd'),
//     InputType.time: DateFormat("HH:mm"),
//   };
//   TextEditingController _dateFrom = TextEditingController();
//   TextEditingController _dateTo = TextEditingController();

//   @override
//   void initState() {
//     _profit();
//     super.initState();
//   }

//   var profit;
//   Future _profit() async {
//     await _services.profitLoss().then((reve) {
//       _profitLoss = reve;
//       // print(reve.toString());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(top: 18.0),
//         child: Column(children: <Widget>[
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: DateTimePickerFormField(
//                   controller: _dateFrom,
//                   inputType: inputType,
//                   format: formats[inputType],
//                   editable: editable,
//                   decoration: InputDecoration(
//                     labelText: 'Date',
//                     hasFloatingPlaceholder: false,
//                     errorStyle: TextStyle(
//                       color: Colors.red,
//                       fontSize: 10.0,
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0)),
//                   ),
//                   onChanged: (dt) => setState(() => date = dt),
//                 ),
//               ),
//               Expanded(
//                 child: DateTimePickerFormField(
//                   controller: _dateTo,
//                   inputType: inputType,
//                   format: formats[inputType],
//                   editable: editable,
//                   decoration: InputDecoration(
//                     labelText: 'Date',
//                     hasFloatingPlaceholder: false,
//                     errorStyle: TextStyle(
//                       color: Colors.red,
//                       fontSize: 10.0,
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0)),
//                   ),
//                   onChanged: (dt) => setState(() => date = dt),
//                 ),
//               ),
//               Expanded(
//                 child: RaisedButton(
//                   child: Text('CHECK'),
//                   onPressed: () {
//                     //
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: <Widget>[],
//           ),
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: Text(
//                   'Month',
//                   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               // Padding(

//               // ),
//               Expanded(
//                 child: Text(
//                   'Product',
//                   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   'Expense',
//                   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   'Revenue',
//                   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   'Profit',
//                   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(flex: 1, child: _data()),
//         ]));
//   }

//   Widget _data() {
//     if (_profitLoss != null) {
//       return ListView.builder(
//           itemCount: _profitLoss.documents.length,
//           itemBuilder: (BuildContext context, int item) {
//             return Card(
//               margin: EdgeInsets.only(top: 12.0, bottom: 2.0),
//               child: ListTile(
//                 title: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Text(
//                         _profitLoss.documents[item].data['amount'],
//                         style: TextStyle(color: Colors.black, fontSize: 15.0),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         'oil',
//                         style: TextStyle(color: Colors.black, fontSize: 15.0),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         '2000',
//                         style: TextStyle(color: Colors.black, fontSize: 15.0),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         '3000',
//                         style: TextStyle(color: Colors.black, fontSize: 15.0),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         '1000',
//                         style: TextStyle(color: Colors.black, fontSize: 15.0),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           });
//     } else {
//       return Center(
//           child: Text("UNDER DEVELOPMENT.....", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)));
//     }
//   }
// }

import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:event/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Profit extends StatefulWidget {
  @override
  _ProfitState createState() => _ProfitState();
}

class _ProfitState extends State<Profit> {
  QuerySnapshot _profitLoss;
  QuerySnapshot _revenue;
  QuerySnapshot _expenditure;
  int profitLoss = 0;
  int totalrevenue = 0;
  int _totalexpanditure = 0;
  static var _count = 0;
  var _currentstep = 1;
  InputType inputType = InputType.date;
  CrudServices _services = CrudServices();
  bool editable = true;
  DateTime date;
  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };
  TextEditingController _dateFrom = TextEditingController();
  TextEditingController _dateTo = TextEditingController();

  @override
  void initState() {
    _profit();
    super.initState();
  }

  var profit;
  Future _profit() async {
    await _services.getData('Revenue').then((result) {
      setState(() {
        _revenue = result;
        for(int i = 0; i< _revenue.documents.length;i++){
          totalrevenue += int.parse(_revenue.documents[i].data['amount']);
        }
      });

      
    });
    await _services.getData("Expenditure").then((exp) {
      setState(() {
       _expenditure = exp;
       for(int i = 0; i< _expenditure.documents.length;i++){
          _totalexpanditure += int.parse(_expenditure.documents[i].data['amount']);
        } 
      });
    }).catchError((err) {
      print("Error $err");
    });

    if (_revenue.documents.length > _expenditure.documents.length) {
      _count = _revenue.documents.length;
    } else {
      _count = _expenditure.documents.length;
    }
    profitLoss = totalrevenue - _totalexpanditure;
    // _count = 5;
  }


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(top: 18.0),
//         child: Column(children: <Widget>[
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: DateTimePickerFormField(
//                   controller: _dateFrom,
//                   inputType: inputType,
//                   format: formats[inputType],
//                   editable: editable,
//                   decoration: InputDecoration(
//                     labelText: 'Date',
//                     hasFloatingPlaceholder: false,
//                     errorStyle: TextStyle(
//                       color: Colors.red,
//                       fontSize: 10.0,
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0)),
//                   ),
//                   onChanged: (dt) => setState(() => date = dt),
//                 ),
//               ),
//               Expanded(
//                 child: DateTimePickerFormField(
//                   controller: _dateTo,
//                   inputType: inputType,
//                   format: formats[inputType],
//                   editable: editable,
//                   decoration: InputDecoration(
//                     labelText: 'Date',
//                     hasFloatingPlaceholder: false,
//                     errorStyle: TextStyle(
//                       color: Colors.red,
//                       fontSize: 10.0,
//                     ),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0)),
//                   ),
//                   onChanged: (dt) => setState(() => date = dt),
//                 ),
//               ),
//               Expanded(
//                 child: RaisedButton(
//                   child: Text('CHECK'),
//                   onPressed: () {
//                     //
//                   },
//                 ),
//               ),
//             ],
//           ),
// //          Row(
// //            children: <Widget>[],
// //          ),
// //          Row(
// //            children: <Widget>[
// //              Expanded(
// //                child: Text(
// //                  'Month',
// //                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// //                ),
// //              ),
// //              // Padding(
// //
// //              // ),
// //              Expanded(
// //                child: Text(
// //                  'Product',
// //                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// //                ),
// //              ),
// //              Expanded(
// //                child: Text(
// //                  'Expense',
// //                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// //                ),
// //              ),
// //              Expanded(
// //                child: Text(
// //                  'Revenue',
// //                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// //                ),
// //              ),
// //              Expanded(
// //                child: Text(
// //                  'Profit',
// //                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// //                ),
// //              ),
// //            ],
// //          ),
//           Expanded(flex: 1, child: _data()),
//         ]));
//   }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: _data(),
    );
  }

  Widget _data() {
    if (_count >= 0) {
      return ListView.builder(
          itemCount: _count,
          itemBuilder: (BuildContext context, int item) {
            return GestureDetector(
                          child: Card(
                margin: EdgeInsets.only(top: 5.0),
                child: Column(
                  children: <Widget>[
                    Text("2019",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Revenue",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        child: Text("Expense",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        child: Text("profit",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("$totalrevenue",style: TextStyle(fontSize: 15.0),),
                      ),
                      Expanded(
                        child: Text("$_totalexpanditure",style: TextStyle(fontSize: 15.0),),
                      ),
                      Expanded(
                        child: Text("$profitLoss",style: TextStyle(fontSize: 15.0),),
                      ),
                    ],
                  ),
                  ],
                ),
              ),
              onTap: () {
                print("gesture detected");
              },
            );
          });
    } else {
      return Center(
        child: Text(
          "PLEASE WAIT",
          style: TextStyle(fontSize: 20.0),
        ),
      );
    }
  }

  // Widget _data() {
  //   if (_profitLoss != null) {
  //     return ListView.builder(
  //         itemCount: _profitLoss.documents.length,
  //         itemBuilder: (BuildContext context, int item) {
  //           return Card(
  //             margin: EdgeInsets.only(top: 12.0, bottom: 2.0),
  //             child: ListTile(
  //               title: Row(
  //                 children: <Widget>[
  //                   Expanded(
  //                     child: Text(
  //                       _profitLoss.documents[item].data['amount'],
  //                       style: TextStyle(color: Colors.black, fontSize: 15.0),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Text(
  //                       'oil',
  //                       style: TextStyle(color: Colors.black, fontSize: 15.0),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Text(
  //                       '2000',
  //                       style: TextStyle(color: Colors.black, fontSize: 15.0),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Text(
  //                       '3000',
  //                       style: TextStyle(color: Colors.black, fontSize: 15.0),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Text(
  //                       '1000',
  //                       style: TextStyle(color: Colors.black, fontSize: 15.0),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         });
  //   } else {
  //     return Center(
  //         child: Text("UNDER DEVELOPMENT.....", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)));
  //   }
  // }


  Widget _plyw(String year,int count,QuerySnapshot revenue,QuerySnapshot expense) {
    for(int j=1;j<12;j++){
      
    }



    for(int i = 0; i<count;i++){
      if(revenue.documents[i].data['year'] == year){
        for(int j = 1; i<12;i++){

        }


        // var k= 0;
    // for (int i = 1; i < 12; i++) {
    //   int revenueCount = 0;
    //   for (int j = 0;j < _revenue.documents.length; j++) {
    //     if(int.parse(_revenue.documents[j].data['month']) == i){
    //       revenueCount += int.parse(_revenue.documents[j].data['amount']);
    //     } else {
    //       continue;
    //     }
    //   }
    //   if(revenueCount != 0) {
    //     // arr[][]
    //   }
    //   print("hsdkjhakj  $i  $revenueCount  $k");
    // }
      }
    }

    // return ListView.builder(
    //   itemBuilder: (BuildContext context,int item) {
    //     // for(int i=0;i < count;i++){
    //     //   if(revenue.documents.){}
    //     // }
    //   },
    // );
  }



}





















// return Card(
//               child: Column(
//                 children: <Widget>[
//                   Expanded(
//                     child: Center(
//                       child: Text("2019"),
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: <Widget>[
//                         Expanded(
//                           child: Row(
//                             children: <Widget>[
//                               Expanded(
//                                 child: Text("Revenue"),
//                               ),
//                               Expanded(
//                                 child: Text("Expenditure"),
//                               ),
//                               Expanded(
//                                 child: Text("Profit"),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Row(
//                             children: <Widget>[
//                               Expanded(
//                                 child: Text("2000"),
//                               ),
//                               Expanded(
//                                 child: Text("1000"),
//                               ),
//                               Expanded(
//                                 child: Text("1000"),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             );