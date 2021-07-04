import 'dart:convert';

import 'package:covidapp/countriesrecord.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'modals/countrieslistmodal.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  List<CountriesListModal> countriesList = [];
  Future<CountriesListModal?> getCountryList() async {
    var response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        for (Map i in data) {
          countriesList.add(CountriesListModal.fromJson(i));
        }
      });
    }
  }

  void initState() {
    super.initState();
    getCountryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: countriesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountriesStatsScreen(
                                  name: countriesList[index]
                                      .country!
                                      .toString())));
                    },
                    child: Column(children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Image(
                                height: 40,
                                width: 40,
                                image: NetworkImage(countriesList[index]
                                    .countryInfo!
                                    .flag
                                    .toString())),
                          ),
                          SizedBox(width: 15),
                          Text(countriesList[index].country!.toString()),
                        ],
                      ),
                      Divider(thickness: 1.0)
                    ]),
                  );
                }),
          )
        ],
      ),
    );
  }
}
