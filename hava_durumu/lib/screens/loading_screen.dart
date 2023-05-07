import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hava_durumu/screens/main_screen.dart';
import 'package:hava_durumu/utils/location.dart';
import 'package:hava_durumu/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;
  Future<void> getLocationData() async {
     locationData=LocationHelper();
     await locationData.getCurrentLocation();
     if(locationData.latitude==null||locationData.longitude==null){
       print("konum bilgileri gelmiyor");
     }
     else{
       print("latitude: ${locationData.latitude}");
       print("longitude: ${locationData.longitude.toString()}");

     }
  }

  void getWeatherData() async{
    await getLocationData();
    WeatherData weatherData=WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();
    if(weatherData.currentCondition==null || weatherData.currentTemperature==null){
      print("Apıden sıcaklık degerleri gelmiyor");
    }
    else{
      //sayfa değiştirme
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return  MainScreen(weatherData: weatherData,);
      }));
    }
  }

  @override
  void initState() {
    //başlangıçta çalıştırmak için
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple,Colors.pinkAccent]
          )
        ),
        child: const Center(
          child: SpinKitFoldingCube (
            color:  Colors.cyanAccent,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
