import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  late Map weather;
  late Map currentWeather;
  late String currentCountry, currentArea, currentCity;
  bool isLoading = false;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future getCurrentWeather() async {
    isLoading = true;

    Position position = await determinePosition(); //get the current position

    //get the current info location
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    currentCountry = placemarks.first.country!;
    currentArea = placemarks.first.administrativeArea!;
    currentCity = placemarks.first.locality!;

    Uri weatherUrl = Uri(
        scheme: 'https',
        host: 'api.open-meteo.com',
        path: '/v1/forecast',
        queryParameters: {
          'longitude': position.longitude.toString(),
          'latitude': position.latitude.toString(),
          'hourly': 'temperature_2m,rain,windspeed_10m',
          'daily': 'weathercode',
          'current_weather': 'true',
          'timezone': 'auto',
        });

    try {
      final response = await http.get(weatherUrl);
      currentWeather = jsonDecode(response.body);
      print(currentWeather);
      isLoading = false;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  getweatherCondition() {
    String weatherConditon = '';
    switch (currentWeather['current_weather']['weathercode']) {
      case 0:
        weatherConditon = 'Clear Sky';
        break;
      case 1:
        weatherConditon = 'Mainly clear';
        break;
      case 2:
        weatherConditon = 'Partly cloudy';
        break;
      case 3:
        weatherConditon = 'Overcast';
        break;
      case 45:
        weatherConditon = 'Fog';
        break;
      case 48:
        weatherConditon = 'Depositing rime fog';
        break;
      case 51:
        weatherConditon = 'Drizzle: Light';
        break;
      case 53:
        weatherConditon = 'Drizzle moderate';
        break;
      case 55:
        weatherConditon = 'Drizzle dense intensity';
        break;
      case 56:
        weatherConditon = 'Freezing Drizzle light';
        break;
      case 57:
        weatherConditon = 'Freezing Drizzle dense intensity';
        break;
      case 61:
        weatherConditon = 'Rain Slight';
        break;
      case 63:
        weatherConditon = 'Rain moderate';
        break;
      case 65:
        weatherConditon = 'Rain heavy intensity';
        break;
      case 66:
        weatherConditon = 'Freezing Rain Light';
        break;
      case 67:
        weatherConditon = 'Freezing Rain heavy intensity';
        break;
      case 71:
        weatherConditon = 'Snow fall Slight';
        break;
      case 73:
        weatherConditon = 'Snow fall moderate';
        break;
      case 75:
        weatherConditon = 'Snow fall heavy intensity';
        break;
      case 77:
        weatherConditon = 'Snow grains';
        break;
      case 80:
        weatherConditon = 'Rain showers slight';
        break;
      case 81:
        weatherConditon = 'Rain showers moderate';
        break;
      case 82:
        weatherConditon = 'Rain showers violent';
        break;
      case 85:
        weatherConditon = 'Snow showers slight';
        break;
      case 86:
        weatherConditon = 'Snow showers heavy';
        break;
      case 95:
        weatherConditon = 'Thunderstorm slight or moderate';
        break;
      case 96:
      case 99:
        weatherConditon = 'Thunderstorm with slight and heavy hail';
        break;
      default:
    }

    return weatherConditon;
  }
}
