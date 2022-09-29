// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:waether_forecast_app/controllers/weather_controller.dart';
import 'package:waether_forecast_app/models/city_model.dart';
import 'package:waether_forecast_app/services/common_dialog.dart';
import 'package:waether_forecast_app/utils/txt_style.dart';
import 'package:waether_forecast_app/views/home/home_screen2.dart';
import 'package:waether_forecast_app/widgets/custom_text_field.dart';
import 'package:weather_icons/weather_icons.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double temp = 0.0;
  // String defaultIcon = '';

  void startApp() async {

    WeatherController weatherController = Provider.of<WeatherController>(context, listen: false);
    await weatherController.getCityDataMap();
    setState(() {
      weatherController.location.toString();
      weatherController.temp.toString();
      weatherController.humidity.toString();
      weatherController.air_speed.toString();
      weatherController.description.toString();
      weatherController.main.toString();
      weatherController.icon.toString();
      temp = double.parse(weatherController.temp.toString().substring(0, 2));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WeatherController weatherController = Provider.of<WeatherController>(context, listen: false);
    weatherController.getCityDataMap();
    weatherController.getCityData();
    startApp();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    WeatherController weatherController = Provider.of(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primary,
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: AppBar(
          backgroundColor: primary,
        ), 
        preferredSize: Size.fromHeight(0),
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            
            
            FutureBuilder<CityModel>(
              future: weatherController.getCityData(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
            
                  return Expanded(
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [

                            SizedBox(height: height * 0.02,),
        
                            CustomTextField(
                              controller: searchController, 
                              hintText: 'Search Cities',
                              prefixIcon: Icons.search,
                              suffixIcon: Icons.done,
                              onTap: () async {
                                print(searchController.text);
                                CommonDialog.showLoading();
                                Future.delayed(Duration(seconds: 1)).then((value) {
                                  Get.offAll(() => HomeScreen2(searchValue: searchController.text.toString(),));
                                });
                                
                              },
                            ),
                        
                            SizedBox(height: height * 0.03,),
                            
                            Container(
                              width: double.infinity,
                              height: height * 0.12,
                              margin: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.01),
                              padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10),
                                // ignore: prefer_const_literals_to_create_immutables
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: -10,
                                    blurRadius: 17,
                                    offset: Offset(5, -5),
                                    color: Colors.white
                                  ),
                                  BoxShadow(
                                    spreadRadius: -2,
                                    blurRadius: 10,
                                    offset: Offset(3, 10),
                                    color: Color.fromRGBO(146, 182, 216, 1)
                                  ),
                                ]
                              ),
                            
                              child: Row(
                                children: [
                        
                                  weatherController.icon == 'not found' ? Icon(Icons.search_off, size: 40, color: Colors.black26,)  :
                        
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: primary,
                                    backgroundImage: weatherController.icon == null ? 
                                      NetworkImage('http://openweathermap.org/img/wn/03d@2x.png') :
                                      NetworkImage('http://openweathermap.org/img/wn/${weatherController.icon.toString()}@2x.png'),
                                  ),
                        
                                  
                        
                                  SizedBox(width: width * 0.05,),
                        
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(weatherController.description.toString(), style: TxtStyle.headLineStyle3,),
                                      Text('in ' + weatherController.location.toString(), style: TxtStyle.headLineStyle2,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            Container(
                              width: double.infinity,
                              height: height * 0.3,
                              margin: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.01),
                              padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10),
                                // ignore: prefer_const_literals_to_create_immutables
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: -10,
                                    blurRadius: 17,
                                    offset: Offset(5, -5),
                                    color: Colors.white
                                  ),
                                  BoxShadow(
                                    spreadRadius: -2,
                                    blurRadius: 10,
                                    offset: Offset(3, 10),
                                    color: Color.fromRGBO(146, 182, 216, 1)
                                  ),
                                ]
                              ),
                            
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                        
                                  temp <= 10.0 ? 
                                        Icon(WeatherIcons.thermometer, color: Colors.blue, size: 30,)
                                      : temp >= 10.0 && temp <=20.0 ? 
                                        Icon(WeatherIcons.thermometer, color: Colors.black38, size: 30,)
                                      : temp >= 20.0 ? 
                                        Icon(WeatherIcons.thermometer, color: Colors.red, size: 30,)
                                      : Icon(WeatherIcons.thermometer, color: Colors.black38, size: 30,),
                        
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                      temp <= 10.0 ? 
                                        Text(temp.toString(), style: TxtStyle.headLineStyle1.copyWith(fontSize: 130, color: Colors.blue),)
                                      : temp >= 10.0 && temp <=20.0 ? 
                                        Text(temp.toString(), style: TxtStyle.headLineStyle1.copyWith(fontSize: 130),)
                                      : temp >= 20.0 ? 
                                        Text(temp.toString(), style: TxtStyle.headLineStyle1.copyWith(fontSize: 130, color: Colors.red),)
                                      : Text(temp.toString(), style: TxtStyle.headLineStyle1.copyWith(fontSize: 130),),
                        
                                      // Text(temp.toString().substring(0,2), style: TxtStyle.headLineStyle1.copyWith(fontSize: 130, color: Colors.blue),),
                        
                                      // SizedBox(width: width * 0.02,),
                                      temp <= 10.0 ? 
                                        Text('°C', style: TxtStyle.headLineStyle1.copyWith(color: Colors.blue),)
                                      : temp >= 10.0 && temp <=20.0 ? 
                                        Text('°C', style: TxtStyle.headLineStyle1)
                                      : temp >= 20.0 ? 
                                        Text('°C', style: TxtStyle.headLineStyle1.copyWith(color: Colors.red),)
                                      : Text('°C', style: TxtStyle.headLineStyle1),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: height * 0.18,
                                      margin: EdgeInsets.symmetric(vertical: height * 0.02),
                                      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02),
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(10),
                                        // ignore: prefer_const_literals_to_create_immutables
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: -10,
                                            blurRadius: 17,
                                            offset: Offset(5, -5),
                                            color: Colors.white
                                          ),
                                          BoxShadow(
                                            spreadRadius: -2,
                                            blurRadius: 10,
                                            offset: Offset(3, 10),
                                            color: Color.fromRGBO(146, 182, 216, 1)
                                          ),
                                        ]
                                      ),
                                            
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Icon(WeatherIcons.day_windy, color: Colors.black38,),
                                            ],
                                          ),
                                          SizedBox(height: height * 0.02,),
                                          Text(snapshot.data!.wind!.speed.toString(), style: TxtStyle.headLineStyle1.copyWith(fontSize: 30),),
                                          Text('Km/hr', style: TxtStyle.headLineStyle4,),
                                        ],
                                      ),
                                    ),
                                  ),
                        
                                  SizedBox(width: width * 0.04,),
                        
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: height * 0.18,
                                      margin: EdgeInsets.symmetric(vertical: height * 0.02),
                                      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02),
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(10),
                                        // ignore: prefer_const_literals_to_create_immutables
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: -10,
                                            blurRadius: 17,
                                            offset: Offset(5, -5),
                                            color: Colors.white
                                          ),
                                          BoxShadow(
                                            spreadRadius: -2,
                                            blurRadius: 10,
                                            offset: Offset(3, 10),
                                            color: Color.fromRGBO(146, 182, 216, 1)
                                          ),
                                        ]
                                      ),
                                            
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Icon(WeatherIcons.humidity, color: Colors.black38,),
                                              Text('Humidity', style: TxtStyle.headLineStyle4,),
                                            ],
                                          ),
                                          SizedBox(height: height * 0.02,),
                                          Text(snapshot.data!.main!.humidity.toString(), style: TxtStyle.headLineStyle1.copyWith(fontSize: 30),),
                                          Text('Percent', style: TxtStyle.headLineStyle4,),
                                        ],
                                      ),
                                    ),
                                  ),
                        
                        
                                ],
                              ),
                            ),

                            Row(
                              children: [

                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: height * 0.15,
                                    margin: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: height * 0.02),
                                    padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02),
                                    decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(10),
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: -10,
                                          blurRadius: 17,
                                          offset: Offset(5, -5),
                                          color: Colors.white
                                        ),
                                        BoxShadow(
                                          spreadRadius: -2,
                                          blurRadius: 10,
                                          offset: Offset(3, 10),
                                          color: Color.fromRGBO(146, 182, 216, 1)
                                        ),
                                      ]
                                    ),
                                          
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text('Clouds', style: TxtStyle.headLineStyle3,),
                                            ],
                                          ),
                                          SizedBox(height: height * 0.01,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Text('Feels Like', style: TxtStyle.headLineStyle3,),
                                              Text(snapshot.data!.main!.feelsLike.toString(), style: TxtStyle.headLineStyle3,),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Text('Pressure', style: TxtStyle.headLineStyle3,),
                                              Text(snapshot.data!.main!.pressure.toString(), style: TxtStyle.headLineStyle3,),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Container(
                                      height: height * 0.15,
                                      margin: EdgeInsets.symmetric(vertical: height * 0.02),
                                      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02),
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(10),
                                        // ignore: prefer_const_literals_to_create_immutables
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: -10,
                                            blurRadius: 17,
                                            offset: Offset(5, -5),
                                            color: Colors.white
                                          ),
                                          BoxShadow(
                                            spreadRadius: -2,
                                            blurRadius: 10,
                                            offset: Offset(3, 10),
                                            color: Color.fromRGBO(146, 182, 216, 1)
                                          ),
                                        ]
                                      ),
                                            
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(snapshot.data!.name.toString(), style: TxtStyle.headLineStyle3,),
                                            ],
                                          ),
                                          SizedBox(height: height * 0.01,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Text('Lat', style: TxtStyle.headLineStyle3,),
                                              Text(snapshot.data!.coord!.lat.toString(), style: TxtStyle.headLineStyle3,),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Text('Lng', style: TxtStyle.headLineStyle3,),
                                              Text(snapshot.data!.coord!.lon.toString(), style: TxtStyle.headLineStyle3,),
                                            ],
                                          ),
                                          
                                          
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                
                              ],
                            ),
                                
                            
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ), 
          ],
        ),
      ),
    );
  }
}