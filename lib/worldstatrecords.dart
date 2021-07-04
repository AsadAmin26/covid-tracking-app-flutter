import 'dart:convert';
import 'package:covidapp/records.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'countrieslist.dart';
import 'modals/worldstatsdata.dart';

class WorldStatRecords extends StatefulWidget {
  @override
  _WorldStatRecordsState createState() => _WorldStatRecordsState();
}

class _WorldStatRecordsState extends State<WorldStatRecords> {
  Future<WorldRecordsModal?> getWorldRecord() async {
    var response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    var data = json.decode(response.body);
    //print(data);
    if (response.statusCode == 200) {
      return WorldRecordsModal.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('World Covid Statistics',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                backgroundColor: Colors.red)),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: FutureBuilder<WorldRecordsModal?>(
              future: getWorldRecord(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return CircularProgressIndicator();
                else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Column(children: [
                      MyRecords(
                          title: 'Total Cases',
                          value: snapshot.data!.cases.toString()),
                      MyRecords(
                          title: 'Active Cases',
                          value: snapshot.data!.active.toString()),
                      MyRecords(
                          title: 'Today Cases',
                          value: snapshot.data!.todayCases.toString()),
                      MyRecords(
                          title: 'Total Recovered',
                          value: snapshot.data!.recovered.toString()),
                      MyRecords(
                          title: 'Today Recovered',
                          value: snapshot.data!.todayRecovered.toString()),
                      MyRecords(
                          title: 'Total Deaths',
                          value: snapshot.data!.deaths.toString()),
                      MyRecords(
                          title: 'Today Deaths',
                          value: snapshot.data!.todayDeaths.toString()),
                    ])),
                  );
                }
              }),
        ),
        SizedBox(height: 30),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CountriesList()));
          },
          child: Container(
            height: 40,
            width: 150,
            color: Colors.red,
            child: Center(child: Text('Countries Tracker')),
          ),
        ),
      ],
    ));
  }
}
