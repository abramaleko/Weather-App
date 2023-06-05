import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weatherProvider.dart';

class HeaderForecast extends StatelessWidget {
  final Size size;
  final brightness;
  final isDarkMode;

  const HeaderForecast({
    Key? key,
    required this.size,
    required this.brightness,
    required this.isDarkMode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final weatherProv = Provider.of<WeatherProvider>(context);

    return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.03,
            ),
            child: Align(
              child: Text(
                weatherProv.currentArea,
                style: GoogleFonts.questrial(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: size.height * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.005,
            ),
            child: Align(
              child: Text(
                'Today', //day
                style: GoogleFonts.questrial(
                  color: isDarkMode ? Colors.white54 : Colors.black54,
                  fontSize: size.height * 0.025,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.03,
            ),
            child: Align(
              child: Text(
                weatherProv.currentWeather['current_weather']['temperature']
                        .toString() +
                    '˚C', //curent temperature
                style: GoogleFonts.questrial(
                  color: weatherProv.currentWeather['current_weather']
                              ['temperature'] <=
                          0
                      ? Colors.blue
                      : weatherProv.currentWeather['current_weather']
                                      ['temperature'] >
                                  0 &&
                              weatherProv.currentWeather['current_weather']
                                      ['temperature'] <=
                                  15
                          ? Colors.indigo
                          : weatherProv.currentWeather['current_weather']
                                          ['temperature'] >
                                      15 &&
                                  weatherProv.currentWeather['current_weather']
                                          ['temperature'] <
                                      30
                              ? Colors.deepPurple
                              : Colors.pink,
                  fontSize: size.height * 0.13,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
            child: Divider(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.005,
            ),
            child: Align(
              child: Text(
                weatherProv.getweatherCondition(), // weather
                style: GoogleFonts.questrial(
                  color: isDarkMode ? Colors.white54 : Colors.black54,
                  fontSize: size.height * 0.03,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.03,
              bottom: size.height * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weatherProv.currentCountry, // min temperature
                  style: GoogleFonts.questrial(
                    color: Colors.blueAccent,
                    fontSize: size.height * 0.022,
                  ),
                ),
                if (weatherProv.currentCity.isNotEmpty)
                  Text(
                    '- (${weatherProv.currentCity})',
                    style: GoogleFonts.questrial(
                      color: Colors.blueAccent,
                      fontSize: size.height * 0.022,
                    ),
                  )
              ],
            ),
          ),
        ],
      );
  }
}
