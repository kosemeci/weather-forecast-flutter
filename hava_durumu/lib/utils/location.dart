import 'package:location/location.dart';

class LocationHelper{
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async{
    Location location=Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    //location için servis ayakta mı
    serviceEnabled=await location.serviceEnabled();
    if(!serviceEnabled){
      //eğer ayakta değilse
      serviceEnabled=await location.requestService();
      if(!serviceEnabled){
        return;
      }
    }

    //konum izni kontrolü
    permissionGranted=await location.hasPermission();
    if(permissionGranted==PermissionStatus.denied){
      permissionGranted=await location.requestPermission();
      if(permissionGranted!=PermissionStatus.granted){
        return;
      }
    }

    // izinler tamam ise
    locationData=await location.getLocation();
    latitude=locationData.latitude!;
    longitude=locationData.longitude!;

  }
}