// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:covid_tracker/Models/StatesModel.dart';
import 'package:covid_tracker/Services/Utilities/fetch_services.dart';
import 'package:covid_tracker/View/countriesList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class States extends StatefulWidget {
  const States({super.key});

  @override
  State<States> createState() => _StatesState();
}

class _StatesState extends State<States> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    FetchServices fetchServices = FetchServices();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
                future: fetchServices.fetchRecord(),
                builder: (context, AsyncSnapshot<StatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SpinKitFadingCircle(
                            controller: _controller,
                            size: 50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          dataMap: {
                            'Hospitalized':
                                double.parse(snapshot.data!.cases.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Deaths': double.parse(
                              (snapshot.data!.deaths!.toString()),
                            )
                          },
                          colorList: [
                            Color(0xff4285F4),
                            Colors.green.shade500,
                            Colors.redAccent
                          ],
                          animationDuration: Duration(milliseconds: 1500),
                          chartRadius: MediaQuery.of(context).size.height / 4.5,
                          chartType: ChartType.ring,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseableRow(
                                    title: 'Cases',
                                    value: double.parse(
                                        snapshot.data!.cases.toString())),
                                ReuseableRow(
                                    title: 'Recovered',
                                    value: double.parse(
                                        snapshot.data!.recovered.toString())),
                                ReuseableRow(
                                    title: 'Deaths',
                                    value: double.parse(
                                        snapshot.data!.deaths.toString())),
                                ReuseableRow(
                                    title: 'Critical',
                                    value: double.parse(
                                        snapshot.data!.critical.toString())),
                                ReuseableRow(
                                    title: 'Today Recovered',
                                    value: double.parse(
                                        snapshot.data!.todayRecovered.toString())),
                                ReuseableRow(
                                    title: 'Tests',
                                    value: double.parse(
                                        snapshot.data!.tests.toString())),


                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountriesList()));
                          },
                          child: Container(
                            height: 50,
                            width: 300,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Track Country',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                })
          ],
        ),
      ),
    ));
  }
}

class ReuseableRow extends StatelessWidget {
  String title;
  double value;

  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 9),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value.toString())],
          ),

        ],
      ),
    );
  }
}
