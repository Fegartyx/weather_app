import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SavedLocationPage extends StatefulWidget {
  const SavedLocationPage({super.key});

  @override
  _SavedLocationPageState createState() => _SavedLocationPageState();
}

class _SavedLocationPageState extends State<SavedLocationPage> {
  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 32,
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New York",
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Sunny",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              Text(
                                "Humidity 52%",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Wind 15 km/h",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/sunny_cloud.svg",
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              const Text(
                                "33\u00b0C",
                                style: TextStyle(fontSize: 48),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
