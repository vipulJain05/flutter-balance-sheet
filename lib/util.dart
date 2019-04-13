// import 'package:firebase_database/firebase_database.dart';

// class Util {
//   var _id;
//   String _choice;
//   String _productName;
//   var _date;
//   var _amount;
//   String _description;

//   Util(this._id, this._choice, this._productName, this._date, this._amount,
//       [this._description]);
//   String get choice => _choice;
//   String get productName => _productName;
//   String get date => _date;
//   double get amount => _amount;
//   String get description => _description;

//   Util.fromSnapshot(DataSnapshot snapshot) {
//     _id = snapshot.key;
//     _choice = snapshot.value['choice'];
//     _productName = snapshot.value['productName'];
//     _date = snapshot.value['date'];
//     _amount = snapshot.value['amount'];
//     _description = snapshot.value['description'];
//   }
// }
