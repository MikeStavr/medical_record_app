import 'package:flutter/material.dart';
import 'package:medical_record/utils/data/app_info.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class ProblemListPage extends StatelessWidget {
  const ProblemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map problems = ApplicationData.problemList;
    return Scaffold(
      appBar: const CustomAppbar(title: "Problem List"),
      drawer: const CustomMenu(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(problems[index]["name"]),
                  subtitle: Text("Date: ${problems[index]["date"]}"),
                ),
                ListTile(
                  title: Text("Status: ${problems[index]["status"]}"),
                  subtitle: Text("Comments: ${problems[index]["notes"]}"),
                ),
              ],
            ),
          );
        },
        itemCount: problems.length,
      ),
      floatingActionButton: const CustomFabHome(),
    );
  }
}
