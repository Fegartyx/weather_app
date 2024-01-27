import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/provider/weather_providers.dart';
import 'package:weather_app/services/LocationServices.dart';
import 'package:weather_app/view/saved_location_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationServices locationServices = LocationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locationServices.dispose();
  }

  Future getData() async {
    // await precacheImage(imageProvider, context);
    // return imageProvider;
    // await locationServices.getUserLocation();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final weather = ref.watch(weatherProvider);
          return weather.when(
            data: (data) {
              return PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final value = data[index];
                  return Container(
                    // padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      // image: DecorationImage(
                      //   image: snapshot.data as ImageProvider,
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 30),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 69,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        ref.watch(dayMonth(DateTime.parse(
                                            value.current.lastUpdated))),
                                        style: const TextStyle(fontSize: 40),
                                      ),
                                      Text(
                                        "Updated as of ${ref.watch(epochTime(value.current.lastUpdateEpoch))}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 30),
                                      Image.network(
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        'https:${value.current.condition.icon}',
                                        height: 95,
                                      ),
                                      Text(
                                        value.current.condition.text,
                                        style: const TextStyle(fontSize: 40),
                                      ),
                                      Text(
                                        "${value.current.tempC.toInt()}\u00b0C",
                                        style: const TextStyle(fontSize: 86),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 62),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.water_drop_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        const Text("Humidity"),
                                        Text("${value.current.humidity}%"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.wind_power_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        const Text("Wind"),
                                        Text(
                                            "${value.current.windKph.toInt()} km/h"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.thermostat_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        const Text("Feels Like"),
                                        Text(
                                            "${value.current.feelsLikeC}\u00b0"),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.grey.withOpacity(0.5),
                                          Colors.grey.withOpacity(0.2),
                                          // const Color(0xFF535353).withOpacity(0.5),
                                          // const Color(0xFF535353).withOpacity(0.2),
                                        ],
                                        stops: const [
                                          0.0,
                                          1.0,
                                        ]),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ...value.forecast.forecastDay.map(
                                        (e) => Column(
                                          children: [
                                            Text(ref.watch(monthDay(e.date))),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Image.network(
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                              'https:${e.day.dayCondition.icon}',
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Text("${e.day.avgtempC}\u00b0"),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Text("${e.day.maxwindKph.toInt()}"),
                                            const Text("km/h"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 36),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 30),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  size: 32,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    value.location.name,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                CircleAvatar(
                                  // backgroundColor: color,
                                  backgroundColor: Colors.grey,
                                  child: GestureDetector(
                                    onTap: () {
                                      // scale();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const SavedLocationPage();
                                          },
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.view_list,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (e, s) {
              return const Center(
                child: Text("Error"),
              );
            },
          );
        },
      ),
    );
  }
}
