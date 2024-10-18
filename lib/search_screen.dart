import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'list_icon_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(this.weather, {super.key});
  final Map<String, dynamic>? weather;

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  String formattedDate =
      DateFormat('EEEE, d, MMMM, h:mm a').format(DateTime.now());
  String day = DateFormat('a').format(DateTime.now());
  String hour = DateFormat('h').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    // Change icon depending on the weather description
    final String desp = widget.weather?['weather'][0]['description'] ?? '';
    late String icon;
    if (desp.contains('clouds')) {
      icon = 'clouds';
    } else if (desp.contains('clear') && day == 'AM' ||
        double.parse(hour) >= 1 && double.parse(hour) <= 6) {
      icon = 'clearlight';
    } else if (desp.contains('clear') && day == 'PM') {
      icon = 'clearnight';
    } else if (desp.contains('rain')) {
      icon = 'rain';
    } else if (desp.contains('wind')) {
      icon = 'wind';
    } else if (desp.contains('snow')) {
      icon = 'snow';
    } else if (desp.contains('fog')) {
      icon = 'fog';
    } else if (desp.contains('mist')) {
      icon = 'mist';
    } else {
      icon = 'unknownWeather';
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(
              0.5), // Adjust opacity by changing the value (0.0 to 1.0)
        ),
        child: Stack(
          children: [
            //********************data for search weather******************
            Positioned(
              top: 150,
              child: Container(
                // color: Color(0xff0c0c0c),
                height: 450,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 75),
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color(0xff414475),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff4b4f85),
                              offset: Offset(0, 20),
                              blurRadius: 20,
                              spreadRadius: -12,
                            )
                          ]),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                              top: -75,
                              left: 10,
                              child: Image.asset(
                                // iconState[0][icon],
                                iconState[0][icon],

                                height: 205,
                                width: 205,
                              )),
                          Positioned(
                              top: 20,
                              right: 65,
                              child: Text(
                                "${(widget.weather?['main']['temp']).toInt()}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 65),
                              )),
                          const Positioned(
                            top: 30,
                            right: 44,
                            child: Text('°C',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          Positioned(
                            top: 100,
                            right: 38,
                            child: Text(
                                '${widget.weather?['weather'][0]['description']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: "AfacadFlux",
                                  shadows: [
                                    Shadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      offset: const Offset(1, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                )),
                          ),
                          Positioned(
                            top: 155,
                            left: 15,
                            child: Row(
                              children: [
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 15,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(
                                            0.3), // Shadow color with opacity
                                        offset: const Offset(
                                            1, 1), // Shadow position (x, y)
                                        blurRadius:
                                            2, // Blur radius for the shadow
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 35,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 190, left: 8, right: 8),
                            width: 400,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 6),
                            decoration: const BoxDecoration(
                                color: Color(0xff393c69),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/temperature (1).png",
                                  height: 34,
                                  width: 34,
                                ),
                                Text('Max : ',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 15)),
                                Text(
                                    '${(widget.weather?['main']['temp_max']).toInt()}°     ',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 14)),
                                Image.asset(
                                  "assets/images/temperature.png",
                                  height: 34,
                                  width: 34,
                                ),
                                Text('Min :  ',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 15)),
                                Text(
                                    '${(widget.weather?['main']['temp_min']).toInt()}°',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 15)),
                                Text('      Feels like ',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 15)),
                                Text(
                                    '${(widget.weather?['main']['feels_like']).toInt()}°',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 15)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 170, right: 170),
                      decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      width: 10,
                      height: 45,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Close the current screen
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
