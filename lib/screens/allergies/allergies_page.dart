import 'package:flutter/material.dart';
import 'package:medical_record/utils/data/app_info.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class AllergiesPage extends StatelessWidget {
  AllergiesPage({super.key});

  final Map allergies = ApplicationData.allergies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Allergies"),
      drawer: const CustomMenu(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Colors.cyan[100],
              title: Text(allergies[index]["name"],
                  style: const TextStyle(fontSize: 20)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Reaction: ${allergies[index]["reaction"]}",
                      style: const TextStyle(fontSize: 16)),
                  Text("Severity: ${allergies[index]["severity"]}",
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
        itemCount: allergies.length,
      ),
      floatingActionButton: const CustomFabHome(),
    );
  }
}
