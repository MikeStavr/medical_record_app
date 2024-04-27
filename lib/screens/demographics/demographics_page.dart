import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class DemographicsPage extends StatelessWidget {
  const DemographicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Demographics"),
      drawer: const CustomMenu(),
      body: Table(
        border: TableBorder.all(),
        children: const [
          TableRow(
            children: [
              Text('Name'),
              Text('Elen Ross'),
            ],
          ),
          TableRow(
            children: [
              Text('Gender'),
              Text('Female'),
            ],
          ),
          TableRow(
            children: [
              Text('Marital Status'),
              Text('Married'),
            ],
          ),
          TableRow(
            children: [
              Text('Religious Affiliation'),
              Text('Christian'),
            ],
          ),
          TableRow(
            children: [
              Text('Ethnicity'),
              Text('Asian'),
            ],
          ),
          TableRow(
            children: [
              Text('Language Spoken'),
              Text('English'),
            ],
          ),
          TableRow(
            children: [
              Text('Address'),
              Text('17 Daws Road, Portland, OR 97006'),
            ],
          ),
          TableRow(
            children: [
              Text('Telephone'),
              Text('415-555-1229'),
            ],
          ),
          TableRow(
            children: [
              Text('Birthday'),
              Text('March 7, 1960'),
            ],
          ),
        ],
      ),
      floatingActionButton: const CustomFabHome(),
    );
  }
}
