// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class AllergiesPage extends StatefulWidget {
  const AllergiesPage({super.key});

  @override
  State<AllergiesPage> createState() => _AllergiesPageState();
}

class _AllergiesPageState extends State<AllergiesPage> {
  var allergies;

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/allergies.json")
        .then((value) {
      setState(() {
        allergies = json.decode(value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Allergies"),
      drawer: const CustomMenu(),
      body: allergies == null
          ? const SizedBox()
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.cyan[100],
                    title: Text(allergies["allergies"][index]["allergyName"],
                        style: const TextStyle(fontSize: 20)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Reaction: ${allergies["allergies"][index]["reaction"]}",
                            style: const TextStyle(fontSize: 16)),
                        Text(
                            "Severity: ${allergies["allergies"][index]["severity"]}",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              },
              itemCount: allergies["allergies"].length ?? 0,
            ),
      floatingActionButton: const CustomFabHome(),
    );
  }
}
