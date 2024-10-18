import 'package:flutter/material.dart';
import 'package:weather_forecasting/list_icon_state.dart';

class WeatherDialog extends StatelessWidget {
  final String temp;
  final String tempMax;
  final String tempMin;
  final String feelsLike;
  final String formattedDate;
  final String weatherDescription;
  final String icon;

  const WeatherDialog({
    Key? key,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.feelsLike,
    required this.formattedDate,
    required this.weatherDescription,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            child: SizedBox(
              height: 520,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 150),
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Color(0xff414475),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff4b4f85),
                          offset: Offset(0, 20),
                          blurRadius: 20,
                          spreadRadius: -12,
                        ),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -20,
                          left: 8,
                          child: Image.asset(
                            iconState[0][icon],
                            height: 150,
                            width: 150,
                          ),
                        ),
                        Positioned(
                          top: 40,
                          right: 40,
                          child: Text(
                            temp,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 45),
                          ),
                        ),
                        const Positioned(
                          top: 44,
                          right: 15,
                          child: Text(
                            '°C',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          right: 40,
                          child: Text(
                            weatherDescription,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "AfacadFlux",
                              shadows: [
                                Shadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  offset: const Offset(1, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 165,
                          left: 13,
                          child: Row(
                            children: [
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 13,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.3),
                                      offset: const Offset(1, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 35),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 200, left: 4, right: 4),
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            decoration: const BoxDecoration(
                                color: Color(0xff393c69),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/temperature (1).png",
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  'Max: ',
                                  style: TextStyle(
                                      color: Colors.grey[200], fontSize: 13),
                                ),
                                Text(
                                  "$tempMax°",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(width: 8),
                                Image.asset(
                                  "assets/images/temperature.png",
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  'Min: ',
                                  style: TextStyle(
                                      color: Colors.grey[200], fontSize: 13),
                                ),
                                Text(
                                  "$tempMin°",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Feels Like: ",
                                  style: TextStyle(
                                      color: Colors.grey[200], fontSize: 13),
                                ),
                                Text(
                                  "$feelsLike°",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
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
    );
  }
}
