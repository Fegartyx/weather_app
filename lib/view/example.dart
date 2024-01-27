
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/view/saved_location_page.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  double scaleFactor = 1;
  bool isVisible = true;
  Color color = Colors.transparent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int width = (MediaQuery.of(context).size.width *
            MediaQuery.of(context).devicePixelRatio)
        .round();
    int height = (MediaQuery.of(context).size.height *
            MediaQuery.of(context).devicePixelRatio)
        .round();
    ImageProvider imageProvider =
        NetworkImage("https://source.unsplash.com/${width}x$height/?NewYork");

    Future getData() async {
      // await precacheImage(imageProvider, context);
      // return imageProvider;
      return true;
    }

    void scale() async {
      setState(() {
        isVisible = false;
        color = const Color(0xFF391A49);
      });
      for (var i = 0; i <= 100; i++) {
        await Future.delayed(const Duration(milliseconds: 1));
        setState(() {
          scaleFactor += 0.5;
        });
      }
      //
      Navigator.of(context).push(_createRoute()).then((value) async => {
            for (var i = 0; i <= 100; i++)
              {
                await Future.delayed(const Duration(milliseconds: 1)),
                setState(() {
                  scaleFactor -= 0.5;
                })
              },
            setState(() {
              color = Colors.transparent;
              isVisible = true;
            })
          });
    }

    return Scaffold(
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    // padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      // color: Colors.grey,
                      image: DecorationImage(
                        image: snapshot.data as ImageProvider,
                        fit: BoxFit.fill,
                      ),
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
                                      const Text(
                                        "June 10",
                                        style: TextStyle(fontSize: 40),
                                      ),
                                      const Text(
                                        "Updated as of 10:14 PM GMT-4",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 30),
                                      SvgPicture.asset(
                                        "assets/clear_day.svg",
                                        height: 95,
                                      ),
                                      const Text(
                                        "Sunny",
                                        style: TextStyle(fontSize: 40),
                                      ),
                                      const Text(
                                        "33 \u2103",
                                        style: TextStyle(fontSize: 86),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 62),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.water_drop_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        Text("Humidity"),
                                        Text("52%"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.wind_power_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        Text("Wind"),
                                        Text("15 Km/h"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.thermostat_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        Text("Feels Like"),
                                        Text("24\u00b0"),
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
                                      Column(
                                        children: [
                                          const Text("Wed 16"),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          SvgPicture.asset(
                                            "assets/sunny_cloud.svg",
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          const Text("22\u00b0"),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          const Text("1-5"),
                                          const Text("km/h"),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text("Thu 17"),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          SvgPicture.asset(
                                            "assets/sunny_cloud.svg",
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          const Text("25\u00b0"),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          const Text("1-5"),
                                          const Text("km/h"),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text("Fri 18"),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          SvgPicture.asset(
                                            "assets/sunny_cloud.svg",
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          const Text("23\u00b0"),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          const Text("1-5"),
                                          const Text("km/h"),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text("Sat 19"),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          SvgPicture.asset(
                                            "assets/cloud_little_rain.svg",
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          const Text("25\u00b0"),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          const Text("1-5"),
                                          const Text("km/h"),
                                        ],
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
                                const Expanded(
                                  child: Text(
                                    "New York",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Transform.scale(
                                  scale: scaleFactor,
                                  child: CircleAvatar(
                                    backgroundColor: color,
                                    child: Visibility(
                                      visible: isVisible,
                                      child: GestureDetector(
                                        onTap: () {
                                          scale();
                                        },
                                        child: const Icon(
                                          Icons.view_list,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
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
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Route<Object?> _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SavedLocationPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.fastOutSlowIn;

        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return ScaleTransition(
          scale: curvedAnimation,
          child: child,
        );
      },
    );
  }
}
