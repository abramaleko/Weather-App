import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weatherProvider.dart';
import 'package:weather_app/widgets/headerForecast.dart';
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
    String cityName = "Katowice"; //city name
    int currTemp = 30; // current temperature
    int maxTemp = 30; // today max temperature
    int minTemp = 2; // today min temperature
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.bars,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            Align(
                              child: Text(
                                'Weather App', //TODO: change app name
                                style: GoogleFonts.questrial(
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xff1D1617),
                                  fontSize: size.height * 0.02,
                                ),
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.plusCircle,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ],
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
                                  HeaderForecast(size: size,brightness: brightness,isDarkMode: isDarkMode,),
                                  TodayForecast(size: size, brightness: brightness, isDarkMode: isDarkMode),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.05,
                                      vertical: size.height * 0.02,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color: Colors.white.withOpacity(0.05),
                                      ),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: size.height * 0.02,
                                                left: size.width * 0.03,
                                              ),
                                              child: Text(
                                                '7-day forecast',
                                                style: GoogleFonts.questrial(
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: size.height * 0.025,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(
                                                size.width * 0.005),
                                            child: Column(
                                              children: [
                                                //TODO: change weather forecast from local to api get
                                                buildSevenDayForecast(
                                                  "Today", //day
                                                  minTemp, //min temperature
                                                  maxTemp, //max temperature
                                                  FontAwesomeIcons
                                                      .cloud, //weather icon
                                                  size,
                                                  isDarkMode,
                                                ),
                                                buildSevenDayForecast(
                                                  "Wed",
                                                  -5,
                                                  5,
                                                  FontAwesomeIcons.sun,
                                                  size,
                                                  isDarkMode,
                                                ),
                                                buildSevenDayForecast(
                                                  "Thu",
                                                  -2,
                                                  7,
                                                  FontAwesomeIcons.cloudRain,
                                                  size,
                                                  isDarkMode,
                                                ),
                                                buildSevenDayForecast(
                                                  "Fri",
                                                  3,
                                                  10,
                                                  FontAwesomeIcons.sun,
                                                  size,
                                                  isDarkMode,
                                                ),
                                                buildSevenDayForecast(
                                                  "San",
                                                  5,
                                                  12,
                                                  FontAwesomeIcons.sun,
                                                  size,
                                                  isDarkMode,
                                                ),
                                                buildSevenDayForecast(
                                                  "Sun",
                                                  4,
                                                  7,
                                                  FontAwesomeIcons.cloud,
                                                  size,
                                                  isDarkMode,
                                                ),
                                                buildSevenDayForecast(
                                                  "Mon",
                                                  -2,
                                                  1,
                                                  FontAwesomeIcons.snowflake,
                                                  size,
                                                  isDarkMode,
                                                ),
                                                buildSevenDayForecast(
                                                  "Tues",
                                                  0,
                                                  3,
                                                  FontAwesomeIcons.cloudRain,
                                                  size,
                                                  isDarkMode,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                
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


  Widget buildSevenDayForecast(String time, int minTemp, int maxTemp,
      IconData weatherIcon, size, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(
        size.height * 0.005,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                ),
                child: Text(
                  time,
                  style: GoogleFonts.questrial(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: size.height * 0.025,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.25,
                ),
                child: FaIcon(
                  weatherIcon,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: size.height * 0.03,
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.15,
                  ),
                  child: Text(
                    '$minTemp˚C',
                    style: GoogleFonts.questrial(
                      color: isDarkMode ? Colors.white38 : Colors.black38,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                  ),
                  child: Text(
                    '$maxTemp˚C',
                    style: GoogleFonts.questrial(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
