// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class ProceduresPage extends StatefulWidget {
  const ProceduresPage({super.key});

  @override
  State<ProceduresPage> createState() => _ProceduresPageState();
}

class _ProceduresPageState extends State<ProceduresPage> {
  var procedures;

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/procedures.json")
        .then((value) {
      setState(() {
        procedures = json.decode(value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Procedures"),
      drawer: const CustomMenu(),
      body: procedures == null
          ? const SizedBox()
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(procedures["procedures"][index]["name"]),
                        subtitle: Text(
                            "Date: ${procedures["procedures"][index]["date"]}"),
                      ),
                      ListTile(
                        title: Text(
                            "Status: ${procedures["procedures"][index]["provider"]}"),
                        subtitle: Text(
                            "Comments: ${procedures["procedures"][index]["location"]}"),
                      ),
                    ],
                  ),
                );
              },
              itemCount: procedures["procedures"].length ?? 0,
            ),
      floatingActionButton: const CustomFabHome(),
    );
  }
}
