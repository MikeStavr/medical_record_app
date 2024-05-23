// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  var medication;

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/medication.json")
        .then((value) {
      setState(() {
        medication = json.decode(value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Medication"),
      drawer: const CustomMenu(),
      body: medication == null
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("${medication["medication"][index]["name"]}"),
                    subtitle: Text(
                        "Date: ${medication["medication"][index]["date"]}"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => {
                      showExtraInfoDialog(context, index),
                    },
                  ),
                );
              },
              itemCount: medication["medication"].length ?? 0,
            ),
      floatingActionButton: const CustomFabHome(),
    );
  }

  Future<void> showExtraInfoDialog(BuildContext context, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              "Extra Information for ${medication["medication"][index]["name"]}"),
          content: Column(
            children: [
              Text("Type: ${medication["medication"][index]["type"]}"),
              Text("Date: ${medication["medication"][index]["date"]}"),
              Text("Dose: ${medication["medication"][index]["dose"]}"),
              Text(
                  "Instructions: ${medication["medication"][index]["instructions"]}"),
              Text(
                  "Instructions: ${medication["medication"][index]["prescriber"]}"),
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
