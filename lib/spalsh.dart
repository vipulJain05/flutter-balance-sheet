import 'dart:async';
import 'package:event/checkInternet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {

  final _data;

  Splash(this._data);
  @override
  _SplashState createState() => _SplashState(_data);
}

class _SplashState extends State<Splash> {
  final _data;
  _SplashState(this._data);
  @override
  void initState() {
getPreferences(this._data);
    super.initState();
    Timer(Duration(seconds: 2),() {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
  return CheckConnectivity();
}));
    }); 
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


  // Future<Null> checkLogin() async {
  //   var _connectionState = "unknown";
  //   Connectivity connectivity = new Connectivity();;
  //   var _email = await getPreferences();
  //   StreamSubscription<ConnectivityResult> subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result){
  //     print(result);
  //     if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
  //       // Navigator.of(context).popUntil((route) => route.isFirst);
  //         if(_email != "" && _email != null){
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
  //      return Details();
  //     }));
  //   }else {
  //      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
  //       return SignIn();
  //     }));
  //   }
  //     }else{
  //       print("net connection lost");
  //       // Navigator.of(context).popUntil((route) => route.isFirst);
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
  //      return InternetConnectivity();
  //     }));
  //     }
  //   });

  //   // @override
  //   // void dispose(){
  //   //   subscription.cancel();
  //   //   super.dispose();
  //   // }

    
    
  // }

  Future<String> getPreferences(var _state) async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();

    if(_state == "Logout") {
      _sharedPreferences.remove('email');
    }
    return null;
    // var _email = _sharedPreferences.getString('email');
    // return _email;
  }
}