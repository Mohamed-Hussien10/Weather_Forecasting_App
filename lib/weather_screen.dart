// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecasting/components/small_container_state.dart';
import 'package:weather_forecasting/components/weather_search.dart';
import 'package:weather_forecasting/list_icon_state.dart';
import 'package:weather_forecasting/services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  final Map<String, dynamic> weather;
  double latitude;
  double longitude;

  WeatherScreen(
      {super.key,
      required this.weather,
      required this.latitude,
      required this.longitude});

  String formattedDate =
      DateFormat('EEEE, d, MMMM, h:mm a').format(DateTime.now());
  String day = DateFormat('a').format(DateTime.now());
  String hour = DateFormat('h').format(DateTime.now());

  @override
  State<WeatherScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WeatherScreen> {
  //---------------Start weather forcast----------
  WeatherService weatherService = WeatherService();
  Map<String, dynamic>? forecastData;

  @override
  void initState() {
    super.initState();
    _loadForecastData();
    _convertTemperature();
  }

  Future<void> _loadForecastData() async {
    final data = await weatherService.fetchFiveDayForecast(
        widget.latitude, widget.longitude); // Cairo's lat/lon
    setState(() {
      forecastData = data;
    });
  }
// function convert Temperature by switch
  bool _isCelsius = false;
  String _result = "";
  void _convertTemperature() {
    double inputTemperature = (widget.weather['main']['temp']).toDouble();
    if (_isCelsius) {
      double fahrenheit = (inputTemperature * 9 / 5) + 32;
      setState(() {
        _result = fahrenheit.toStringAsFixed(1);
      });
    } else {
      setState(() {
        _result = '${inputTemperature.toInt()}';
      });
    }
  }

  //---------------End weather forcast-------------

  bool temperature = false;
  bool wind = false;
  bool rain = false;
  bool notification = true;

  @override
  Widget build(BuildContext context) {
    //Change icon depending on the weather description
    final String desp = widget.weather['weather'][0]['description'];
    late String icon;
    if (desp.contains('clouds')) {
      icon = 'clouds';
    } else if (desp.contains('clear') && widget.day == 'AM' ||
        double.parse(widget.hour) >= 1 && double.parse(widget.hour) <= 6) {
      icon = 'clearlight';
    } else if (desp.contains('clear') && widget.day == 'PM') {
      icon = 'clearnight';
    } else if (desp.contains('rain')) {
      icon = 'rain';
    } else if (desp.contains('wind')) {
      icon = 'wind';
    } else if (desp.contains('snow')) {
      icon = 'snow';
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white, size: 30 // Change the drawer icon color here
            ),

        /* Replace the word "Cairo" with the value coming from the API through the location button.*/
        title: Center(
            child: Text(
          "${widget.weather['name']}",
          style: const TextStyle(color: Colors.white, fontSize: 30),
        )),
        backgroundColor: const Color(0xff352877), //black
        leading:
        IconButton(
          //search
            hoverColor: Colors.orange,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SearchWeather()));
            },
            icon: const Icon(Icons.search)),
        actions: [
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('  °C',
              style: TextStyle(color: Colors.white,fontSize: 15)),
          Switch(
            //switch button related to Celsius and Fahrenheit
            activeColor: Colors.orange,
            activeTrackColor: const Color(0xff292d4c),
            inactiveTrackColor: const Color(0xff292d4c),
            inactiveThumbColor: Colors.orange,
            value: _isCelsius,
            onChanged: (value) {
              setState(() {
                _isCelsius = value;
                _convertTemperature();
              });
            },
          ),
          const Text('°F  ',
              style: TextStyle(color: Colors.white,fontSize: 15)),
        ],

    ),
      ]
    ),
      body: Stack(
        children: [
          Positioned(
              child: Image.asset(
            "assets/images/background.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          )),
          Positioned(
            child: Container(
              // color: Color(0xff0c0c0c),

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
                              iconState[0][icon],
                              height: 205,
                              width: 205,
                            )),
                        Positioned(
                            top: 25,
                            right: 56,
                            child: Text(
                              // "${(widget.weather['main']['temp']).toInt()}",
                              _result,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 62),
                            )),
                        Positioned(
                          top: 35,
                          right: 34,
                          child:_isCelsius==false ?
                          const Text('°C',style:TextStyle(color: Colors.white, fontSize: 20)):
                          const Text('°F',style:TextStyle(color: Colors.white, fontSize: 20)),),

                        Positioned(
                          top: 105,
                          right: 38,
                          child: Text(
                              '${widget.weather['weather'][0]['description']}',
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
                                widget.formattedDate,
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
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 190, left: 5, right: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 6),
                            decoration: const BoxDecoration(
                                color: Color(0xff393c69),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/temperature (1).png",
                                  height: 34,
                                  width: 35,
                                ),
                                Text('Max: ',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 16)),
                                Text(
                                    '${(widget.weather['main']['temp_max']).toInt()}° ',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 16)),
                          
                                // Container(
                                //   width: 40,
                                // ),
                                Image.asset(
                                  "assets/images/temperature.png",
                                  height: 34,
                                  width: 35,
                                ),
                                Text('Min: ',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 16)),
                                Text(
                                    '${(widget.weather['main']['temp_min']).toInt()}° ',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 16)),
                                Text('Feels like: ',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 16)),
                                Text(
                                    '${(widget.weather['main']['feels_like']).toInt()}°',
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //*********************************rowState***************************************
                  Container(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SmallContainer(
                        iconn: (Icons.water_drop),
                        text1:
                            "${(widget.weather['main']['humidity']).toInt()}%",
                        text2: "Humidity",
                      ),
                      Container(
                        width: 15,
                      ),
                      SmallContainer(
                        iconn: (Icons.air),
                        text1:
                            "${(widget.weather['wind']['speed']).toInt()}m/s",
                        text2: "Wind",
                      ),
                      Container(
                        width: 15,
                      ),
                      SmallContainer(
                        iconn: (Icons.cloudy_snowing),
                        text1: "${(widget.weather['clouds']['all'])}",
                        text2: "Clouds",
                      ),
                    ],
                  ),
                  //********************************dayForecast****************************************

                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xff414475),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
                          " Day Forecast",
                          style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              forecastData == null
                                  ? const Center(
                                      child:
                                          CircularProgressIndicator()) // Loading spinner
                                  : ListView.builder(
                                      shrinkWrap:
                                          true, // Add shrinkWrap to prevent infinite height
                                      physics:
                                          const NeverScrollableScrollPhysics(), // Disable internal scrolling
                                      itemCount:
                                          forecastData!['list']?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final forecastItem =
                                            forecastData!['list'][index];
                                        return _buildForecastItem(forecastItem);
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastItem(Map<String, dynamic> forecastItem) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(forecastItem['dt'] * 1000);
    final formattedDate =
        DateFormat('EEEE, d MMM yyyy, h:mm a').format(dateTime);
    final temp = forecastItem['main']['temp'];
    final description = forecastItem['weather'][0]['description'];
    final icon = forecastItem['weather'][0]['icon'];

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xff393c69),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          width: 45,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.14), // Shadow color
                spreadRadius: 0, // Spread radius
                blurRadius: 2, // Blur radius
                offset: const Offset(0, 0), // Shadow position
              ),
            ],
          ),
          child: Image.network(
            'http://openweathermap.org/img/wn/$icon@2x.png',
          ),
        ),
        title: Text(
          '  $formattedDate',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          '  Temp: $temp°C | $description',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
