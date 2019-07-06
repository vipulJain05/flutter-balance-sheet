import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InternetConnectivity extends StatefulWidget {
  @override
  _InternetConnectivityState createState() => _InternetConnectivityState();
}

class _InternetConnectivityState extends State<InternetConnectivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Container(
        // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/2.5,vertical: MediaQuery.of(context).size.height / 2.5),
        body: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.network_check,size: 50.0,),
              Text("CHECK INTERNET",style: TextStyle(fontSize: 30.0),)
            ],
          ),
        ),
      // ),
    );
  }
}