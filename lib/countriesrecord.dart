import 'dart:convert';
import 'package:covidapp/records.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modals/countriesrecord.dart';

class CountriesStatsScreen extends StatefulWidget {
  final String name;
  CountriesStatsScreen({required this.name});
  @override
  _CountriesStatsScreenState createState() => _CountriesStatsScreenState();
}

class _CountriesStatsScreenState extends State<CountriesStatsScreen> {
  Future<CountriesRecordModal?> getCountriesRecord() async {
    var response = await http.get(
        Uri.parse('https://disease.sh/v3/covid-19/countries/' + widget.name));
    var data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return CountriesRecordModal.fromJson(data);
    } else {
      return CountriesRecordModal.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.name + 'Statistics',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    backgroundColor: Colors.red,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FutureBuilder<CountriesRecordModal?>(
                    future: getCountriesRecord(),
                    builder: (context, snapshot) {
                      print(snapshot);

                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            child: Column(
                              children: [
                                MyRecords(
                                    title: 'Total Cases',
                                    value: snapshot.data!.cases.toString()),
                                MyRecords(
                                    title: 'Active Cases',
                                    value: snapshot.data!.active.toString()),
                                MyRecords(
                                    title: 'Today Cases',
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                MyRecords(
                                    title: 'Total Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                MyRecords(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                MyRecords(
                                    title: 'Total Deaths',
                                    value: snapshot.data!.deaths.toString()),
                                MyRecords(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString())
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
