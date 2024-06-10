// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:covid_tracker/Services/Utilities/fetch_services.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FetchServices fetchServices = FetchServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  // searchController.text = value;
                });
              },
              decoration: InputDecoration(
                  hintText: 'Search Country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FutureBuilder(
                  future: fetchServices.fetchCountry(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (searchController.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          active: snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],
                                          test: snapshot.data![index]['tests'])));
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 70,
                                        width: 60,
                                        image: NetworkImage(snapshot.data![index]
                                            ['countryInfo']['flag']),
                                      ),
                                      title:
                                          Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                    ),
                                  )
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          active: snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],
                                          test: snapshot.data![index]['tests'])));
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 70,
                                        width: 60,
                                        image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                      ),
                                      title:
                                      Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                      ['cases']
                                          .toString()),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    } else {
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, snapshot) {
                            return Shimmer.fromColors(
                                child: ListTile(
                                  leading: Container(
                                      height: 70,
                                      width: 60,
                                      color: Colors.white),
                                  title: Container(
                                      height: 10,
                                      width: 90,
                                      color: Colors.white),
                                  subtitle: Container(
                                      height: 10,
                                      width: 90,
                                      color: Colors.white),
                                ),
                                baseColor: Colors.grey.shade900,
                                highlightColor: Colors.grey.shade100);
                          });
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
