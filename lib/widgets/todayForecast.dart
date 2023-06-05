import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:weather_app/provider/weatherProvider.dart';
// import 'package:weather_app/widgets/headerForecast.dart';

class TodayForecast extends StatelessWidget {
  final Size size;
  final brightness;
  final isDarkMode;

  const TodayForecast({
    Key? key,
    required this.size,
    required this.brightness,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.05),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.width * 0.03,
                    ),
                    child: Text(
                      'Forecast for today',
                      style: GoogleFonts.questrial(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: size.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.005),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        //TODO: change weather forecast from local to api get
                        buildForecastToday(
                          "Now", //hour
                          27, //temperature to change
                          20, //wind (km/h)
                          0, //rain chance (%)
                          FontAwesomeIcons.sun, //weather icon
                          size,
                          isDarkMode,
                        ),
                        buildForecastToday(
                          "15:00",
                          1,
                          10,
                          40,
                          FontAwesomeIcons.cloud,
                          size,
                          isDarkMode,
                        ),
                        buildForecastToday(
                          "16:00",
                          0,
                          25,
                          80,
                          FontAwesomeIcons.cloudRain,
                          size,
                          isDarkMode,
                        ),
                        buildForecastToday(
                          "17:00",
                          -2,
                          28,
                          60,
                          FontAwesomeIcons.snowflake,
                          size,
                          isDarkMode,
                        ),
                        buildForecastToday(
                          "18:00",
                          -5,
                          13,
                          40,
                          FontAwesomeIcons.cloudMoon,
                          size,
                          isDarkMode,
                        ),
                        buildForecastToday(
                          "19:00",
                          -8,
                          9,
                          60,
                          FontAwesomeIcons.snowflake,
                          size,
                          isDarkMode,
                        ),
                        buildForecastToday(
                          "20:00",
                          -13,
                          25,
                          50,
                          FontAwesomeIcons.snowflake,
                          size,
                          isDarkMode,
                        ),
                        buildForecastToday(
                          "21:00",
                          -14,
                          12,
                          40,
                          FontAwesomeIcons.cloudMoon,
                          size,
                          isDarkMode,
                        ),
                        buildForecastToday(
                          "22:00",
                          -15,
                          1,
                          30,
                          FontAwesomeIcons.moon,
                          size,
                          isDarkMode,
                        ),
                        buildForecastToday(
                          "23:00",
                          -15,
                          15,
                          20,
                          FontAwesomeIcons.moon,
                          size,
                          isDarkMode,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildForecastToday(String time, int temp, int wind, int rainChance,
      IconData weatherIcon, size, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.025),
      child: Column(
        children: [
          Text(
            time,
            style: GoogleFonts.questrial(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.height * 0.02,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.005,
                ),
                child: FaIcon(
                  weatherIcon,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$temp˚C',
            style: GoogleFonts.questrial(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.height * 0.025,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                ),
                child: FaIcon(
                  FontAwesomeIcons.wind,
                  color: Colors.grey,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$wind km/h',
            style: GoogleFonts.questrial(
              color: Colors.grey,
              fontSize: size.height * 0.02,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                ),
                child: FaIcon(
                  FontAwesomeIcons.umbrella,
                  color: Colors.blue,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$rainChance %',
            style: GoogleFonts.questrial(
              color: Colors.blue,
              fontSize: size.height * 0.02,
            ),
          ),
        ],
      ),
    );
  }
}
