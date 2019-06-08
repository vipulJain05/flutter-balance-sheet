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

  static var revenue = 0;
  static var expense = 0;
  static var total = 0;
  var _monthTotal = 0;
  static var _totalrevenue = 0;
  static var _totalexpense = 0;
/*
function to add data into database
@required: data
*/
  Future<void> addData(data) async {
    // var date = data['date'].toString().split('-');
    // var year = date[0];
    // var month = date[1];

    var _email = await getPreference();

    adddataMonthWise(_email, data['choice'],data);

    //add data in Revenue field daily uploaded
    if (data['choice'] == 'REVENUE') {
      await Firestore.instance
          .collection('$_email')
          .document('data')
          .collection('Revenue')
          .add(data)
          .catchError((err) => print(err));


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


    }

    // await addYearList();
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
  Future delete(String page, var docId, var olddate, var amount) async {
    QuerySnapshot value;
    QuerySnapshot _yearValue;
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


    await Firestore.instance.collection(_email)
        .document('data')
        .collection('MonthWise').where('Year',isEqualTo: year).where('Month',isEqualTo: month).getDocuments().then((result){
          value = result;
          print("object");
          print(result.documents);
        });

        var monthDocId = value.documents[0].documentID;
if(page == "Revenue"){
        revenue = value == null ? 0 : int.parse(value.documents[0].data['Revenue'].toString()) - int.parse(amount.toString()) ;
        expense = value.documents[0].data['Expense'];
      }else {
        print("sucessful");
        expense = value == null ? 0 : int.parse(value.documents[0].data['Expense'].toString()) - int.parse(amount.toString());
        revenue = value.documents[0].data['Revenue'];
      }
      

      Map<String,dynamic> _record = {'Year' : year,'Month':month,'Revenue' : revenue,'Expense' : expense};
      await Firestore.instance.collection(_email).document('data').collection('MonthWise').where('Year',isEqualTo: year).where('Month',isEqualTo: month).reference().document(monthDocId).updateData(_record).then((onValue){
      });


await Firestore.instance.collection(_email).document('data').collection('YearlyData').where('Year',isEqualTo: year).getDocuments().then((result){
      _yearValue = result;
    });
     var yeardocId = _yearValue.documents[0].documentID;


if(page == "Revenue"){
        _totalrevenue = int.parse(_yearValue.documents[0].data['TotalRevenue'].toString()) - int.parse(amount.toString()) ;
        _totalexpense = int.parse(_yearValue.documents[0].data['TotalExpense'].toString());
      }else {
        _totalexpense = int.parse(_yearValue.documents[0].data['TotalExpense'].toString()) - int.parse(amount.toString());
        _totalrevenue = int.parse(_yearValue.documents[0].data['TotalRevenue'].toString());
      }
      total = _totalrevenue - _totalexpense;

      Map<String,dynamic> _yearRecord = {'Year' : year,'Total' : total,'TotalRevenue' : _totalrevenue,'TotalExpense' : _totalexpense};
      await Firestore.instance.collection(_email).document('data').collection('YearlyData').where('Year',isEqualTo: year).reference().document(yeardocId).updateData(_yearRecord).then((onValue){
      });
  }


  Future adddataMonthWise(var _email, var page,var data) async {

    QuerySnapshot value;
    QuerySnapshot _yearValue;
    var date = data['date'].toString().split('-');
    var year = date[0];
    var month = date[1];
print(month);
    await Firestore.instance
        .collection(_email)
        .document('data')
        .collection('MonthWise').where('Year',isEqualTo: year).where('Month',isEqualTo: month)
        .getDocuments()
        .then((result) {
          value = result;
      print("result");
      // print(result.documents.length);
    });


    var check = value.documents.toString();
      if (check.indexOf('[') == 0 && check.indexOf(']') == 1) {
        check = '';
      }


    if(check.isEmpty){
      revenue = 0;
      expense = 0;
      _monthTotal = 0;
      if(page == 'REVENUE') {
        revenue = int.parse(data['amount'].toString());
      }else {
        expense = int.parse(data['amount'].toString());
      }

      _monthTotal = revenue - expense;
      print("in if $_monthTotal");
      Map<String,dynamic> _record = {'Year' : year,'Month':month,'Revenue' : revenue,'Expense' : expense,'Total' : _monthTotal};
      await Firestore.instance.collection(_email).document('data').collection('MonthWise').add(_record);
    }else {

_monthTotal = 0;
      if(page == "REVENUE"){
        revenue = value == null ? 0 : int.parse(data['amount'].toString()) +  int.parse(value.documents[0].data['Revenue'].toString());
      }else {
        print("sucessful");
        expense = value == null ? 0 : int.parse(data['amount'].toString()) + int.parse(value.documents[0].data['Expense'].toString());
      }
      _monthTotal = revenue - expense;
      print("in else $_monthTotal");
              var docId = value.documents[0].documentID;


      Map<String,dynamic> _record = {'Year' : year,'Month':month,'Revenue' : revenue,'Expense' : expense,'Total' : _monthTotal};
      await Firestore.instance.collection(_email).document('data').collection('MonthWise').where('Year',isEqualTo: year).where('Month',isEqualTo: month).reference().document(docId).updateData(_record).then((onValue){
      });
    }


     await Firestore.instance.collection(_email).document('data').collection('YearlyData').where('Year',isEqualTo: year).getDocuments().then((result){
      _yearValue = result;
    });


    var yearData = _yearValue.documents.toString();
      if (yearData.indexOf('[') == 0 && yearData.indexOf(']') == 1) {
        yearData = '';
      }

      if(yearData.isEmpty) {
        _totalexpense = 0;
        _totalrevenue = 0;
        total = 0;

        if(page == 'REVENUE') {
          _totalrevenue = int.parse(data['amount'].toString());
        }else {
          _totalexpense = int.parse(data['amount'].toString());
        }
        total = _totalrevenue - _totalexpense;
        Map<String,dynamic> yearData = {'Year' : year,'TotalRevenue' : _totalrevenue,'TotalExpense' : _totalexpense,'Total' : total};

        await Firestore.instance.collection(_email).document('data').collection('YearlyData').add(yearData).then((result) {
          print(result);
          print("succesfully uploaded");
        });
      } else {
        if(page == "REVENUE"){
        _totalrevenue = int.parse(data['amount'].toString()) +  int.parse(_yearValue.documents[0].data['TotalRevenue'].toString());
      }else {
        _totalexpense = int.parse(data['amount'].toString()) + int.parse(_yearValue.documents[0].data['TotalExpense'].toString());
      }
      total = _totalrevenue - _totalexpense;
      
      
              var docId = _yearValue.documents[0].documentID;

      Map<String,dynamic> _record = {'Year' : year,'Total' : total,'TotalRevenue' : _totalrevenue,'TotalExpense' : _totalexpense};
      await Firestore.instance.collection(_email).document('data').collection('YearlyData').where('Year',isEqualTo: year).reference().document(docId).updateData(_record).then((onValue){
      });
      }

  }


  Future profitLoss() async {
    var _email = await getPreference();

    return await Firestore.instance.collection('$_email').document('data').collection('YearlyData').orderBy('Year',descending: true).getDocuments().catchError((err){
      print(err);
    });
  }


  Future monthWisedata(var year) async{
    var _email = await getPreference();
    return Firestore.instance.collection(_email).document('data').collection('MonthWise').where('Year',isEqualTo: year).getDocuments().catchError((err){print(err);});
  }
}
