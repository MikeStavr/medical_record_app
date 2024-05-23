// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class ImmunizationsPage extends StatefulWidget {
  const ImmunizationsPage({super.key});

  @override
  State<ImmunizationsPage> createState() => _ImmunizationsPageState();
}

class _ImmunizationsPageState extends State<ImmunizationsPage> {
  var immunizations;

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/immunizations.json")
        .then((value) {
      setState(() {
        immunizations = json.decode(value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Immunizations"),
      drawer: const CustomMenu(),
      body: immunizations == null
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: immunizations["immunizations"].length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(immunizations["immunizations"][index]["name"]),
                    subtitle:
                        Text(immunizations["immunizations"][index]["date"]),
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
            title: Text(
                "Extra Information for ${immunizations["immunizations"][index]["name"]}"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Type: ${immunizations["immunizations"][index]["type"]}"),
                Text("Date: ${immunizations["immunizations"][index]["date"]}"),
                Text(
                    "Quantity: ${immunizations["immunizations"][index]["quantity"]}"),
                Text(
                    "Instructions: ${immunizations["immunizations"][index]["instructions"]}"),
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
