import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/helper/Debouncer.dart';
import 'package:weather_app/provider/saved_location_provider.dart';
import 'package:weather_app/view/home_page.dart';
import 'package:weather_app/view/search_view_location.dart';

import '../provider/country_providers.dart';
import '../provider/weather_providers.dart';

class SavedLocationPage extends ConsumerStatefulWidget {
  const SavedLocationPage({super.key});

  @override
  ConsumerState<SavedLocationPage> createState() => _SavedLocationPageState();
}

class _SavedLocationPageState extends ConsumerState<SavedLocationPage> {
  @override
  Widget build(BuildContext context) {
    final weather = ref.watch(weatherProvider);
    final location = ref.watch(savedLocationProviders);
    debugPrint('rebuild saved location page');
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF391A49),
              Color(0xFF301D5C),
              Color(0xFF262171),
              Color(0xFF301D5C),
              Color(0xFF391A49),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Saved Location",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SearchViewLocation(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 32,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            const Text(
              'Lokasi Favorit',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(
              height: 12,
            ),
            weather.when(
              data: (data) => ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey.withOpacity(0.5),
                            Colors.grey.withOpacity(0.2),
                          ],
                          stops: const [
                            0.0,
                            1.0,
                          ]),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        ref.read(weatherProvider.notifier).replaceWeather(data);
                        Debouncer(milliseconds: 800).run(() {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        });
                      },
                      onLongPress: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.location.name,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  data.current.condition.text,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                Text(
                                  "Humidity ${data.current.humidity}%",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Wind ${data.current.windKph.toInt()} km/h",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
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
                                  'https:${data.current.condition.icon}',
                                  height: 50,
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "${data.current.tempC.toInt()}\u00b0C",
                                  style: const TextStyle(fontSize: 48),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              error: (error, stackTrace) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(error.toString())));
                });
                return const Center(
                  child: Text("Error"),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Lokasi Lain',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            location.when(
              data: (data) => Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Material(
                        type: MaterialType.transparency,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.grey.withOpacity(0.5),
                                  Colors.grey.withOpacity(0.2),
                                ],
                                stops: const [
                                  0.0,
                                  1.0,
                                ]),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: () {
                              ref
                                  .read(weatherProvider.notifier)
                                  .replaceWeather(data[index]);
                              Debouncer(milliseconds: 800).run(() {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (route) => false,
                                );
                              });
                            },
                            onLongPress: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].location.name,
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        data[index].current.condition.text,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      Text(
                                        "Humidity ${data[index].current.humidity}%",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Wind ${data[index].current.windKph} km/h",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
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
                                        'https:${data[index].current.condition.icon}',
                                        height: 50,
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "${data[index].current.tempC.toInt()}\u00b0C",
                                        style: const TextStyle(fontSize: 48),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              error: (error, stackTrace) {
                debugPrint('Error Saved Location: $error');
                return const SizedBox();
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
