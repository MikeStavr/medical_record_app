import 'package:flutter/material.dart';
import 'package:medical_record/utils/data/app_info.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class ProceduresPage extends StatelessWidget {
  const ProceduresPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map procedures = ApplicationData.procedures;
    return Scaffold(
      appBar: const CustomAppbar(title: "Procedures"),
      drawer: const CustomMenu(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(procedures[index]["name"]),
                  subtitle: Text("Date: ${procedures[index]["date"]}"),
                ),
                ListTile(
                  title: Text("Status: ${procedures[index]["provider"]}"),
                  subtitle: Text("Comments: ${procedures[index]["location"]}"),
                ),
              ],
            ),
          );
        },
        itemCount: procedures.length,
      ),
      floatingActionButton: const CustomFabHome(),
    );
  }
}
