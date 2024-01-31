import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/provider/country_providers.dart';
import 'package:weather_app/view/saved_location_page.dart';

import '../helper/Debouncer.dart';
import '../provider/weather_providers.dart';

class SearchViewLocation extends StatefulWidget {
  const SearchViewLocation({Key? key}) : super(key: key);

  @override
  State<SearchViewLocation> createState() => _SearchViewLocationState();
}

class _SearchViewLocationState extends State<SearchViewLocation> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    ListController listController = ListController();
    final _deboucer = Debouncer(milliseconds: 800);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
        child: Consumer(
          builder: (context, ref, child) {
            debugPrint('Consumer');
            final search = ref.watch(searchCountryProviders);
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 24),
                  margin: const EdgeInsets.only(top: 32, left: 8, right: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          controller: searchController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          onChanged: (data) {
                            _deboucer.run(() {
                              ref
                                  .read(searchCountryProviders.notifier)
                                  .searchCountry(data);
                            });
                          },
                        ),
                      ),
                      const Icon(Icons.mic, color: Colors.white),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final countries =
                            ref.watch(countryProviders((search, 0)));
                        return searchController.text.isEmpty
                            ? const Center(
                                child: Text("Input to Search Country"),
                              )
                            : countries.when(
                                data: (country) {
                                  return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 8),
                                            child: Text(
                                              country.data[index].name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                      itemCount: country.data.length);
                                },
                                error: (error, stackTrace) => Center(
                                  child: Text("Error $error $stackTrace"),
                                ),
                                loading: () {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
