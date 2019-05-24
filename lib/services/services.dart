import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CrudServices {
  Future<String> getPreference() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String _email = _preferences.getString('email');
    return _email;
  }

  Future<void> addData(data) async {
    var _email = await getPreference();
    if (data['choice'] == 'REVENUE') {
      await Firestore.instance
          .collection('$_email')
          .document('data')
          .collection('Revenue')
          .add(data)
          .catchError((err) => print(err));
    } else {
      await Firestore.instance
          .collection('$_email')
          .document('data')
          .collection('Expenditure')
          .add(data)
          .then((onValue) {
        return true;
      }).catchError((err) => print(err));
    }
  }

  Future getData(String page) async {
    var _email = await getPreference();
    return Firestore.instance
        .collection('$_email')
        .document('data')
        .collection('$page')
        .getDocuments()
        .catchError((err) => print(err));
  }

  Future delete(String page, var docId) async {
    var _email = await getPreference();
    await Firestore.instance
        .collection('$_email')
        .document('data')
        .collection('$page')
        .document(docId)
        .delete()
        .catchError((err) => print(err));
    // if(Firestore.instance.collection('$_email').document().)
  }

  Future profitLoss() async {
    var _email = await getPreference();
    var revenueCount = 0;
    var expenditureCount = 0;
    var _profit;
    QuerySnapshot _revenue = await Firestore.instance
        .collection('$_email')
        .document('data')
        .collection('Revenue')
        .getDocuments();
    // for (var totalRevenue in _revenue.documents) {
    //   revenueCount += int.parse(totalRevenue.data['amount']);
    // }
var k= 0;
    for (int i = 1; i < 12; i++) {
      revenueCount = 0;
      for (int j = 0;j < _revenue.documents.length; j++) {
        if(int.parse(_revenue.documents[j].data['month']) == i){
          revenueCount += int.parse(_revenue.documents[j].data['amount']);
        } else {
          continue;
        }
      }
      if(revenueCount != 0) {
        // arr[][]
      }
      print("hsdkjhakj  $i  $revenueCount  $k");
    }
    QuerySnapshot _expenditure = await Firestore.instance
        .collection('$_email')
        .document('data')
        .collection('Expenditure')
        .getDocuments();
    // for (var totalExpenditure in _expenditure.documents) {
    //   expenditureCount += int.parse(totalExpenditure.data['amount']);
    // }
    // _profit = revenueCount - expenditureCount;
    // //profitLoss.revenue = revenueCount;
    // Map<String,dynamic> profitLoss = {'Revenue' : revenueCount,'Expenditure' : expenditureCount,'Profit' : _profit};
    // profitLoss['expenditure'] = expenditureCount;
    // profitLoss['profit'] = _profit;
    // print("sjdlkajkldjkslajlkaskl;f" + _revenue.documents[0].data['amount'].toString());
    // return _revenue;
  }
}
