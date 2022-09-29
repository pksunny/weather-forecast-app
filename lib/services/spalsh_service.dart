
// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waether_forecast_app/views/home/home_screen.dart';

class SplashService {
  

  void splashRoute(BuildContext context){

    Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())));

  }
}