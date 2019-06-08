// import 'dart:async';

// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:event/services/services.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class DataBetweendates extends StatefulWidget {
//   @override
//   DataBetweendatesState createState() => DataBetweendatesState();
// }

// class DataBetweendatesState extends State<DataBetweendates> {
//   InputType inputType = InputType.date;
//   CrudServices _services = CrudServices();
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
//     _fetchdataByDates();
//     super.initState();
//   }

//   Future _fetchdataByDates() async {
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(top: 18.0),
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text("check"),
//           ),
//                   body: Row(
//               children: <Widget>[
//                 Column(children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: DateTimePickerFormField(
//                       controller: _dateFrom,
//                       inputType: inputType,
//                       format: formats[inputType],
//                       editable: false,
//                       decoration: InputDecoration(
//                         labelText: 'Date',
//                         hasFloatingPlaceholder: false,
//                         errorStyle: TextStyle(
//                           color: Colors.red,
//                           fontSize: 10.0,
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0)),
//                       ),
//                       onChanged: (dt) => setState(() => date = dt),
//                     ),
//                   ),
//                 ]),
//               Row(
//                 children: <Widget>[
//                     Expanded(
//                     child: DateTimePickerFormField(
//                       controller: _dateTo,
//                       inputType: inputType,
//                       format: formats[inputType],
//                       editable: false,
//                       decoration: InputDecoration(
//                         labelText: 'Date',
//                         hasFloatingPlaceholder: false,
//                         errorStyle: TextStyle(
//                           color: Colors.red,
//                           fontSize: 10.0,
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0)),
//                       ),
//                       onChanged: (dt) => setState(() => date = dt),
//                     ),
//                   ),
//                 ],
//               ),
                  
//                   Expanded(
//                     child: RaisedButton(
//                       child: Text('CHECK'),
//                       onPressed: () {
//                         //
//                       },
//                     ),
//                   ),
//                 ],
//               ),

//               Column(
//                 children: <Widget>[
//                   Expanded(
//                     child: RaisedButton(
//                       child: Text('CHECK'),
//                       onPressed: (){
//                         print("button clicked");
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               ],
//           ),
//         ),
//     );
//   }}




//           // Row(
//           //   children: <Widget>[],
//           // ),
//           // Row(
//           //   children: <Widget>[
//           //     Expanded(
//           //       child: Text(
//           //         'Month',
//           //         style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           //       ),
//           //     ),
//           //     // Padding(

//           //     // ),
//           //     Expanded(
//           //       child: Text(
//           //         'Product',
//           //         style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           //       ),
//           //     ),
//           //     Expanded(
//           //       child: Text(
//           //         'Expense',
//           //         style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           //       ),
//           //     ),
//           //     Expanded(
//           //       child: Text(
//           //         'Revenue',
//           //         style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           //       ),
//           //     ),
//           //     Expanded(
//           //       child: Text(
//           //         'Profit',
//           //         style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           //       ),
//           //     ),
//           //   ],
//           // ),
// //           Expanded(flex: 1, child: _data()),
// //         ]));
// //   }

// //   Widget _data() {
// //     if (_profitLoss != null) {
// //       return ListView.builder(
// //           itemCount: _profitLoss.documents.length,
// //           itemBuilder: (BuildContext context, int item) {
// //             return Card(
// //               margin: EdgeInsets.only(top: 12.0, bottom: 2.0),
// //               child: ListTile(
// //                 title: Row(
// //                   children: <Widget>[
// //                     Expanded(
// //                       child: Text(
// //                         _profitLoss.documents[item].data['amount'],
// //                         style: TextStyle(color: Colors.black, fontSize: 15.0),
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: Text(
// //                         'oil',
// //                         style: TextStyle(color: Colors.black, fontSize: 15.0),
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: Text(
// //                         '2000',
// //                         style: TextStyle(color: Colors.black, fontSize: 15.0),
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: Text(
// //                         '3000',
// //                         style: TextStyle(color: Colors.black, fontSize: 15.0),
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: Text(
// //                         '1000',
// //                         style: TextStyle(color: Colors.black, fontSize: 15.0),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           });
// //     } else {
// //       return Center(
// //           child: Text("UNDER DEVELOPMENT.....", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)));
// //     }
// //   }
// // }



import 'package:flutter/material.dart';

class MonthWise extends StatefulWidget {
  @override
  _MonthWiseState createState() => _MonthWiseState();
}

class _MonthWiseState extends State<MonthWise> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MonthWise'),
        ),
        body: Scaffold(),
      ),
    );
  }
}