
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:waether_forecast_app/models/city_model.dart';
import 'package:waether_forecast_app/services/common_dialog.dart';

class WeatherController with ChangeNotifier {

  // GET CITY DATA
  List<CityModel> cityList = [];

  Future<CityModel> getCityData() async{
    var response=await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Rawalpindi&appid=69b52b1c50f780b395e918dbe00bb06d'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200)
    {
      print("Successfull Show Record");
      print(data);
      return CityModel.fromJson(data);
    }
    else
      return CommonDialog.showErrorDialog(title: 'Oops', description: 'Unable to load data');
  }

  

  // GET CITY DATA USING MAP

  String? location = 'Rawalpindi';
  double? temp;
  String? humidity;
  String? air_speed;
  String? description;
  String? main;
  String? icon;

  Future<void> getCityDataMap() async {

    try {
      var response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=69b52b1c50f780b395e918dbe00bb06d'));
      Map data = jsonDecode(response.body);
      print(data);

      // For TEMP, Humidity
      Map temp_data = data['main'];
      temp = (temp_data['temp'] - 273);
      humidity = temp_data['humidity'].toString();

      // For air speed
      Map wind = data['wind'];
      air_speed = wind['speed'].toString();

      // For Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      main = weather_main_data['main'];
      description = weather_main_data['description'];

      // For Icon
      icon = weather_main_data['icon'];
      print(icon);

      notifyListeners();

    } catch (e) {
      location = 'Location not correct';
      temp = 0.0;
      humidity = 'Data not found';
      air_speed = 'Data not found';
      description = 'Data not found';
      main = 'Data not found';
      icon = 'not found';

      print(location);

      notifyListeners();
    }

    // print('${weather_data} \t :  ${weather_main_data}');

    // print(temp);
  }



  Future<void> getCityDataMap2(city) async {

    try {
      var response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=69b52b1c50f780b395e918dbe00bb06d'));
      Map data = jsonDecode(response.body);
      print(data);

      // For TEMP, Humidity
      Map temp_data = data['main'];
      temp = (temp_data['temp'] - 273);
      humidity = temp_data['humidity'].toString();

      // For air speed
      Map wind = data['wind'];
      air_speed = wind['speed'].toString();

      // For Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      main = weather_main_data['main'];
      description = weather_main_data['description'];

      // For Icon
      icon = weather_main_data['icon'];
      print(icon);

      notifyListeners();

    } catch (e) {
      location = 'Location not correct';
      temp = 0.0;
      humidity = 'Data not found';
      air_speed = 'Data not found';
      description = 'Data not found';
      main = 'Data not found';
      icon = 'not found';

      notifyListeners();
    }
  }

  // Future<FiveDaysModel> getFiveDaysData() async{


  //   var response=await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=33.5651&lon=73.0169&appid=69b52b1c50f780b395e918dbe00bb06d'));
  //   var data = jsonDecode(response.body.toString());
    
  //   if(response.statusCode==200)
  //   {
  //     print("Successfull Show Record");
  //     return FiveDaysModel.fromJson(data);
  //   } else {
  //     return CommonDialog.showErrorDialog(title: 'Oops', description: 'Unable to load data');
  //   }
  // }
}