import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class DemographicsPage extends StatefulWidget {
  const DemographicsPage({super.key});

  @override
  State<DemographicsPage> createState() => _DemographicsPageState();
}

class _DemographicsPageState extends State<DemographicsPage> {
  Map<String, dynamic>? demographics;

  @override
  void initState() {
    super.initState();
    _loadDemographics();
  }

  Future<void> _loadDemographics() async {
    final String response =
        await rootBundle.loadString('assets/demographics.json');
    final data = await json.decode(response);
    setState(() {
      demographics = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Demographics"),
      drawer: const CustomMenu(),
      body: demographics == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _createRow('Name', demographics!['name']),
                      const Divider(),
                      _createRow('Gender', demographics!['gender']),
                      const Divider(),
                      _createRow(
                          'Marital Status', demographics!['maritalStatus']),
                      const Divider(),
                      _createRow('Religious Affiliation',
                          demographics!['religiousAffiliation']),
                      const Divider(),
                      _createRow('Ethnicity', demographics!['ethnicity']),
                      const Divider(),
                      _createRow(
                          'Language Spoken', demographics!['languageSpoken']),
                      const Divider(),
                      _createRow('Address', demographics!['address']),
                      const Divider(),
                      _createRow('Telephone', demographics!['telephone']),
                      const Divider(),
                      _createRow('Birthday', demographics!['birthday']),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: const CustomFabHome(),
    );
  }

  Widget _createRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
