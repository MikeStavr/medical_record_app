import 'package:flutter/material.dart';
import 'package:medical_record/utils/data/app_info.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class ImmunizationsPage extends StatelessWidget {
  ImmunizationsPage({super.key});

  final Map immunizations = ApplicationData.immunizations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Immunizations"),
      drawer: const CustomMenu(),
      body: ListView.builder(
        itemCount: immunizations.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(immunizations[index]["name"]),
              subtitle: Text(immunizations[index]["date"]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => {
                showExtraInfoDialog(context, index),
              },
            ),
          );
        },
      ),
      floatingActionButton: const CustomFabHome(),
    );
  }

  Future<void> showExtraInfoDialog(BuildContext context, int index) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text("Extra Information for ${immunizations[index]["name"]}"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Type: ${immunizations[index]["type"]}"),
                Text("Date: ${immunizations[index]["date"]}"),
                Text("Quantity: ${immunizations[index]["quantity"]}"),
                Text("Instructions: ${immunizations[index]["instructions"]}"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        });
  }
}
