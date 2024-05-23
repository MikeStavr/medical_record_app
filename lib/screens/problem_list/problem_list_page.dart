import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class ProblemListPage extends StatefulWidget {
  const ProblemListPage({super.key});

  @override
  State<ProblemListPage> createState() => _ProblemListPageState();
}

class _ProblemListPageState extends State<ProblemListPage> {
  var problems;

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/problemList.json")
        .then((value) {
      setState(() {
        problems = json.decode(value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Problem List"),
      drawer: const CustomMenu(),
      body: problems == null
          ? const SizedBox()
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(problems["problemList"][index]["name"]),
                        subtitle: Text(
                            "Date: ${problems["problemList"][index]["date"]}"),
                      ),
                      ListTile(
                        title: Text(
                            "Status: ${problems["problemList"][index]["status"]}"),
                        subtitle: Text(
                            "Comments: ${problems["problemList"][index]["notes"]}"),
                      ),
                    ],
                  ),
                );
              },
              itemCount: problems["problemList"].length ?? 0,
            ),
      floatingActionButton: const CustomFabHome(),
    );
  }
}
