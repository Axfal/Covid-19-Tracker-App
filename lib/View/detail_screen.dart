import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  String name;
  DetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .06),
                child: Card(
                    child: Column(children: [
                      SizedBox(height: MediaQuery.of(context).size.height *.06,),
                  ReuseableRow(
                      title: 'Cases', value: widget.totalCases.toDouble()),
                  ReuseableRow(
                      title: 'Recovered',
                      value: widget.totalRecovered.toDouble()),
                  ReuseableRow(
                      title: 'Deaths', value: widget.totalDeaths.toDouble()),
                  ReuseableRow(
                      title: 'Critical', value: widget.critical.toDouble()),
                  ReuseableRow(
                      title: 'today Recovered',
                      value: widget.todayRecovered.toDouble()),
                  ReuseableRow(title: 'Test', value: widget.test.toDouble()),
                ])),
              ),
              CircleAvatar(
                radius: 50,
                child:Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover, // Add the fit property
                    ),
                  ),
                  // Other widget properties...
                ),

              ),
            ],
          )
        ],
      ),
    );
  }
}
