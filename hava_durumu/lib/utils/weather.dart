import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'location.dart';

const apiKey="01f6d9160ed5c4f47bf9f1653213c8a0";

class WeatherDisplayData{
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});

}


class WeatherData{
  WeatherData({required this.locationData});

  late LocationHelper locationData;
  late double currentTemperature;
  late int currentCondition;

  Future<void> getCurrentTemperature() async {
    Response response =await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric"));

    if(response.statusCode==200){
      String data=response.body;
      var currentWeather= jsonDecode(data);
      try{
        currentTemperature=currentWeather['main']['temp'];
        currentCondition=currentWeather['weather'][0]['id'];
      }
      catch(e){
        print(e);
      }
    }
    else{
      print("apiden deger gelmiiiiiyooooo");
    }
  }
  WeatherDisplayData getWeatherDisplayData(){
    if(currentCondition<600){
      return WeatherDisplayData(weatherIcon: const Icon(
        FontAwesomeIcons.cloud,
        size: 75.0,
        color: Colors.white,
      ),
          weatherImage:const  AssetImage('assets/bulutlu.jpg'));
    }
    else{
      var now= DateTime.now();
      if(now.hour>=16){
        return WeatherDisplayData(weatherIcon: const Icon(
          FontAwesomeIcons.moon,
          size: 75.0,
          color: Colors.white,
        ),
            weatherImage: const AssetImage('assets/gece.webp'));
      }
      else{
        return WeatherDisplayData(weatherIcon: const Icon(
          FontAwesomeIcons.sun,
          size: 75.0,
          color: Colors.white,
        ),
            weatherImage: const AssetImage('assets/güneşlii.webp'));
      }
    }
  }


}