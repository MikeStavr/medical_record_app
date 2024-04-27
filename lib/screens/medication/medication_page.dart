import 'package:flutter/material.dart';
import 'package:medical_record/utils/data/app_info.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class MedicationPage extends StatelessWidget {
  MedicationPage({super.key});
  final Map medication = ApplicationData.medication;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Medication"),
      drawer: const CustomMenu(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("${medication[index]["name"]}"),
              subtitle: Text("Date: ${medication[index]["date"]}"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => {
                showExtraInfoDialog(context, index),
              },
            ),
          );
        },
        itemCount: medication.length,
      ),
      floatingActionButton: const CustomFabHome(),
    );
  }

  Future<void> showExtraInfoDialog(BuildContext context, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Extra Information for ${medication[index]["name"]}"),
          content: Column(
            children: [
              Text("Type: ${medication[index]["type"]}"),
              Text("Date: ${medication[index]["date"]}"),
              Text("Dose: ${medication[index]["dose"]}"),
              Text("Instructions: ${medication[index]["instructions"]}"),
              Text("Instructions: ${medication[index]["prescriber"]}"),
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
      },
    );
  }
}
