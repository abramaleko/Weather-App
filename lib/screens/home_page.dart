import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weatherProvider.dart';
import 'package:weather_app/widgets/headerForecast.dart';
import 'package:weather_app/widgets/sevenForecast.dart';
import 'package:weather_app/widgets/todayForecast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Initialization logic here
    _getData();
  }

  Future<void> _getData() async {
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    await weatherData.getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black : Colors.white,
          ),
          child: SafeArea(child: Consumer<WeatherProvider>(
            builder: (context, weatherProv, child) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.05,
                        ),
                        child: Text(
                          'Weather App', //TODO: change app name
                          style: GoogleFonts.questrial(
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xff1D1617),
                            fontSize: size.height * 0.021,
                          ),
                        ),
                      ),
                      weatherProv.isLoading
                          ? const Center(
                              heightFactor: 10,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.blueAccent,
                                color: Colors.white,
                              ),
                            )
                          : Container(
                              child: Column(
                                children: [
                                  HeaderForecast(
                                    size: size,
                                    brightness: brightness,
                                    isDarkMode: isDarkMode,
                                  ),
                                  TodayForecast(
                                      size: size,
                                      brightness: brightness,
                                      isDarkMode: isDarkMode),
                                  SevenForecast(
                                      size: size,
                                      brightness: brightness,
                                      isDarkMode: isDarkMode)
                                ],
                              ),
                            )
                    ]),
                  ),
                ],
              );
            },
          )),
        ),
      ),
    );
  }
}
