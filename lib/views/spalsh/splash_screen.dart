// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:waether_forecast_app/services/spalsh_service.dart';
import 'package:waether_forecast_app/utils/txt_style.dart';

class SplashSCreen extends StatefulWidget {
  const SplashSCreen({super.key});

  @override
  State<SplashSCreen> createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {
  SplashService splasService = SplashService();

  @override
  void initState() {
    super.initState();
    splasService.splashRoute(context);
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            // CircleAvatar(
            //   radius: 50,
            //   child: Image.asset('assets/money-tracker.png', fit: BoxFit.contain),
            // ),

            // SizedBox(height: height * 0.05,),
            

            Text(
              'Weather Forecast',
              style: TxtStyle.headLineStyle3,
            ),
            Text(
              '☁',
              style: TxtStyle.headLineStyle3.copyWith(color: Colors.blueGrey),
            ),

            SizedBox(height: height * 0.05,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.05),
              child: LinearPercentIndicator(
                  animation: true,
                  animationDuration: 2300,
                  lineHeight: 30.0,
                  percent: 1.0,
                  center: Text("Loading...",style: TxtStyle.headLineStyle4.copyWith(color: Colors.white)),
                  // linearStrokeCap: LinearStrokeCap.round,
                  barRadius: Radius.circular(20),
                  progressColor: Colors.blue,
                  backgroundColor: Colors.cyan,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
