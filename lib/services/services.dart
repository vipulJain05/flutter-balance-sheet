import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CrudServices {
  //function to get shared preference value

  Future<String> getPreference() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String _email = _preferences.getString('email');
    return _email;
  }

/*
function to add data into database
@required: data
*/
  Future<void> addData(data) async {
    var date = data['date'].toString().split('-');
    var year = date[0];
    var month = date[1];
    int _newamount = int.parse(data['amount']);

    Map<String, dynamic> _data = {
      'amount': data['amount'],
      'month': month,
      'year': year
    };
    var _email = await getPreference();

    //add data in Revenue field daily uploaded
    if (data['choice'] == 'REVENUE') {
      await Firestore.instance
          .collection('$_email')
          .document('data')
          .collection('Revenue')
          .add(data)
          .catchError((err) => print(err));

      //add data in RevenueMonth field month wise
      QuerySnapshot revenueMonthTotal;
      await Firestore.instance
          .collection('$_email')
          .document('data')
          .collection('RevenueMonth')
          .where('year', isEqualTo: year)
          .where('month', isEqualTo: month)
          // .document('$year')
          // .collection('$month')
          .getDocuments()
          .then((reve) {
        print("getting first data");
        print(reve.documents);
        print(reve.documents.length);
        revenueMonthTotal = reve;
      });

      var check = revenueMonthTotal.documents.toString();
      if (check.indexOf('[') == 0 && check.indexOf(']') == 1) {
        check = '';
      }
//if no field present in database in revenueMonth
      if (check.isEmpty) {
        await Firestore.instance
            .collection('$_email')
            .document('data')
            .collection('RevenueMonth')
            // .document('$year')
            // .collection('$month')
            .add(_data);
      } else {
        //if field is present in database in revenueMonth

        QuerySnapshot _updateData;
        await Firestore.instance
            .collection('$_email')
            .document('data')
            .collection('RevenueMonth')
            .where('year', isEqualTo: '$year')
            .where('month', isEqualTo: month)
            // .document('$year')
            // .collection('$month')
            .getDocuments()
            .then((value) {
          _updateData = value;
          print("check new structure");
          print(value.documents[0].data);
        });
        var docId = _updateData.documents[0].documentID;
        int amount = _updateData == null
            ? 0
            : int.parse(_updateData.documents[0].data['amount'].toString());
        // int _updatedamount = amount + _newamount;
        _data = {'amount': amount + _newamount, 'month': month, 'year': year};
        //delete previous document
        await Firestore.instance
            .collection('$_email')
            .document('data')
            .collection('RevenueMonth')
            .where('year', isEqualTo: year)
            .where('month', isEqualTo: month)
            .reference()
            .document(docId)
            .updateData(_data)
            .then((onValue) {
          print("updated");
        });
      }
    } else {
      //add data for expenditure
      await Firestore.instance
          .collection('$_email')
          .document('data')
          .collection('Expenditure')
          .add(data)
          .then((onValue) {
        return true;
      }).catchError((err) => print(err));

      //add data for month wise calculation
      QuerySnapshot expenseMonthTotal;
      await Firestore.instance
          .collection('$_email')
          .document('data')
          .collection('ExpenseMonth')
          .where('year', isEqualTo: year)
          .where('month', isEqualTo: month)
          .getDocuments()
          .then((reve) {
        expenseMonthTotal = reve;
      });

      var check = expenseMonthTotal.documents.toString();
      if (check.indexOf('[') == 0 && check.indexOf(']') == 1) {
        check = '';
      }
      //if no field present
      if (check.isEmpty) {
        await Firestore.instance
            .collection('$_email')
            .document('data')
            .collection('ExpenseMonth')
            // .document('$year')
            // .collection('$month')
            .add(_data);
      } else {
        //if field present
        QuerySnapshot _updateData;
        await Firestore.instance
            .collection('$_email')
            .document('data')
            .collection('ExpenseMonth').where('year',isEqualTo: year).where('month',isEqualTo: month)
            // .document('$year')
            // .collection('$month')
            .getDocuments()
            .then((value) {
          _updateData = value;
        });
        var docId = _updateData.documents[0].documentID;
        int amount = _updateData == null
            ? 0
            : int.parse(_updateData.documents[0].data['amount'].toString());
        // int _updatedamount = amount + _newamount;
        _data = {'amount': amount + _newamount, 'month': month, 'year': year};

        await Firestore.instance
            .collection('$_email')
            .document('data')
            .collection('ExpenseMonth').where('year', isEqualTo: year)
            .where('month', isEqualTo: month)
            .reference()
            .document(docId)
            .updateData(_data);
            
      }
    }
  }

/*
function to get data
@required page and email
 */

  Future getData(String page) async {
    var _email = await getPreference();
    return Firestore.instance
        .collection('$_email')
        .document('data')
        .collection('$page')
        .orderBy('date', descending: true)
        .getDocuments()
        .catchError((err) => print(err));
  }

/*
function to delete data
@required page and documentId
 */
  Future delete(String page, var docId,var olddate,var amount) async {
    QuerySnapshot _result;
    var date = olddate.toString().split('-');
    var year = date[0];
    var month = date[1];
    var _email = await getPreference();
    await Firestore.instance
        .collection('$_email')
        .document('data')
        .collection('$page')
        .document(docId)
        .delete()
        .catchError((err) => print(err));

    var newpage;
    if(page == 'Revenue'){
      newpage = 'RevenueMonth';
    }else{
      newpage = 'ExpenseMonth';
    }


    await Firestore.instance.collection('$_email')
    .document('data').collection(newpage).where('year', isEqualTo: year)
            .where('month', isEqualTo: month).getDocuments().then((result){
              _result = result;
            });
          var docIdForMonth = _result.documents[0].documentID;
      var oldamount = _result == null ? 0 : int.parse(_result.documents[0].data['amount'].toString());
      // var _updatedamount = (oldamount - int.parse(amount.toString())).toString();
      Map<String,dynamic> _data = {'amount':(oldamount - int.parse(amount.toString())).toString()};
      await Firestore.instance.collection('$_email')
    .document('data').collection(newpage).where('year', isEqualTo: year)
            .where('month', isEqualTo: month).reference().document(docIdForMonth).updateData(_data);
  }
}
