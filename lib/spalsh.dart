import 'dart:async';
import 'package:event/dashboard.dart';
import 'package:event/details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),() => checkLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[800],
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 40.0),
                              child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("SIT",style: TextStyle(fontSize: 85.0,color: Colors.white,fontFamily: 'Geometr'),)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("STUDY", style:TextStyle(fontSize:40.0,color: Colors.white,fontFamily: 'Geometr')),
                              Text("OF", style:TextStyle(fontSize:40.0,color: Colors.white,fontFamily: 'Geometr')),
                              Text("INFORMATION", style:TextStyle(fontSize:40.0,color: Colors.white,fontFamily: 'Geometr')),
                              Text("TECHNOLOGY", style:TextStyle(fontSize:40.0,color: Colors.white,fontFamily: 'Geometr')),
                              Container(
                      margin: EdgeInsets.all(30.0),
                    ),
                              Expanded(
                      child: Text("LOADING...",style: TextStyle(color: Colors.white,fontSize: 15.0,fontFamily: 'Arial'),),
                    ),
                    Expanded(
                      child: Text("Developed By : Vipul",style: TextStyle(color: Colors.white,fontSize: 15.0,fontFamily: 'Arial')),
                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
      ),
    );
  }


  Future<Null> checkLogin() async {
    var _email = await getPreferences();
    if(_email != "" && _email != null){
      print("already login");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        Profit();
      }));
    }else {
      print("go to login");
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        SignIn();
      }));
    }
  }

  Future<String> getPreferences() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var _email = _sharedPreferences.getString('email');
    return _email;
  }
}