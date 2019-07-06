import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:event/details.dart';
import 'package:event/internetConnectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CheckConnectivity extends StatefulWidget {
  @override
  _CheckConnectivityState createState() => _CheckConnectivityState();
}

class _CheckConnectivityState extends State<CheckConnectivity> {
Connectivity connectivity;
StreamSubscription<ConnectivityResult> subscription;


  @override
  void initState(){
    
    connectivityCheck();
    // print(_email);
    
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

Future<String> getemail() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String _email = _preferences.getString('email');
    return _email;
  }

connectivityCheck() async {
  connectivity = new Connectivity();
    var _email = await getemail();
    print(_email);
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result){
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        print("entry of net");
        // Navigator.of(context).popUntil((route) => route.isFirst);
        
          if(_email != "" && _email != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
       return Details();
      }));
    }else {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return SignIn();
      }));
    }
      }else{
        // Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
       return InternetConnectivity();
      }));
      }
    });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}