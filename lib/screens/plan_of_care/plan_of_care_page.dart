import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class PlanOfCarePage extends StatefulWidget {
  const PlanOfCarePage({super.key});

  @override
  State<PlanOfCarePage> createState() => _PlanOfCarePageState();
}

class _PlanOfCarePageState extends State<PlanOfCarePage> {
  var planOfCare;

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/planofcare.json")
        .then((value) {
      setState(() {
        planOfCare = json.decode(value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Plan of Care"),
      drawer: const CustomMenu(),
      body: planOfCare == null
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                            planOfCare["planOfCare"][index]["activityName"]),
                        subtitle: Text(
                            "Date: ${planOfCare["planOfCare"][index]["date"]}"),
                      ),
                      ListTile(
                        title: Text(
                            "Instructions: ${planOfCare["planOfCare"][index]["instructions"]}"),
                      ),
                    ],
                  ),
                );
              },
              itemCount: planOfCare["planOfCare"].length ?? 0,
            ),
    );
  }
}
