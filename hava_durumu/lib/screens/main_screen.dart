import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hava_durumu/utils/weather.dart';

class MainScreen extends StatefulWidget {

  final WeatherData weatherData;
  const MainScreen({super.key, required this.weatherData});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late int temperature;
  late Icon weatherIcon;
  late AssetImage backgroundImage;

  void updateDisplayInfo(WeatherData weatherData){
    setState(() {
      temperature=weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData=weatherData.getWeatherDisplayData();
      backgroundImage=weatherDisplayData.weatherImage;
      weatherIcon=weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50,),
             Container(
              child:  weatherIcon,
            ),
            const SizedBox(height: 15,),
             Center(
              child: Text('$temperature°',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 80.0,
                letterSpacing: -5,
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
