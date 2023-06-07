import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/weatherProvider.dart';

class SevenForecast extends StatelessWidget {
  final Size size;
  final brightness;
  final isDarkMode;

  const SevenForecast({
    Key? key,
    required this.size,
    required this.brightness,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherProv = Provider.of<WeatherProvider>(context, listen: false);

    return Column(
      children: [
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
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: size.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.005),
                  child: Column(
                    children: [
                      for (var i = 0; i < 7; i++)
                        buildSevenDayForecast(
                          weatherProv.dayDateForecast[i], //day
                          weatherProv.dayDateMinTemp[i], //min temperature
                          weatherProv.dayDateMaxTemp[i], //max temperature
                         weatherProv.getWeatherCondition(i,'7day'), //weather icon
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
    );
  }

  Widget buildSevenDayForecast(String time, double minTemp, double maxTemp,
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
