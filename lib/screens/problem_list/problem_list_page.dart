import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart'; // Import the intl package

class ProblemListPage extends StatefulWidget {
  const ProblemListPage({super.key});

  @override
  State<ProblemListPage> createState() => _ProblemListPageState();
}

class _ProblemListPageState extends State<ProblemListPage> {
  var problems;
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

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
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date of the calendar
      firstDate: DateTime(2000), // Start date of the calendar
      lastDate: DateTime(2100), // End date of the calendar
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('MMMM d, yyyy').format(pickedDate);
      });
    }
  }

  List<_ProblemData> _getChartData() {
    final dateFormat = DateFormat('MMMM d, yyyy');

    return problems["problemList"].map<_ProblemData>((problem) {
      final date = dateFormat.parse(problem["date"]);
      return _ProblemData(date, problem["name"]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          title: const Text("Problem List"),
          bottom: const TabBar(
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(
                text: "Problem List",
                icon: Icon(Icons.list),
              ),
              Tab(
                text: "Insert",
                icon: Icon(Icons.create),
              ),
              Tab(
                text: "Chart",
                icon: Icon(Icons.insert_chart),
              ),
            ],
          ),
        ),
        drawer: const CustomMenu(),
        body: problems == null
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  // Problem list tab
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              title:
                                  Text(problems["problemList"][index]["name"]),
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
                  // Insert tab content goes here
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _problemController,
                            decoration: const InputDecoration(
                              labelText: "Problem Title",
                              icon: Icon(Icons.create),
                            ),
                          ),
                          TextField(
                            controller: _dateController,
                            decoration: const InputDecoration(
                              labelText: "Date",
                              icon: Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () => _selectDate(context),
                          ),
                          TextField(
                            controller: _statusController,
                            decoration: const InputDecoration(
                              labelText: "Status",
                              icon: Icon(Icons.info),
                            ),
                          ),
                          TextField(
                            controller: _notesController,
                            decoration: const InputDecoration(
                              labelText: "Notes",
                              icon: Icon(Icons.note),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                problems["problemList"].add({
                                  "name": _problemController.text,
                                  "date": _dateController.text,
                                  "status": _statusController.text,
                                  "notes": _notesController.text,
                                });
                                _problemController.clear();
                                _dateController.clear();
                                _statusController.clear();
                                _notesController.clear();
                              });
                            },
                            child: const Text("Save"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Graph tab content
                  Center(
                    child: SfCartesianChart(
                      primaryXAxis: DateTimeAxis(
                        dateFormat: DateFormat.yMd(),
                        title: const AxisTitle(text: 'Date'),
                        isVisible: true,
                      ),
                      primaryYAxis: const CategoryAxis(
                        title: AxisTitle(text: 'Problem Title'),
                        isVisible: false,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        ScatterSeries<_ProblemData, DateTime>(
                          dataSource: _getChartData(),
                          xValueMapper: (_ProblemData data, _) => data.date,
                          yValueMapper: (_ProblemData data, _) =>
                              data.title.length,
                          dataLabelMapper: (_ProblemData data, _) => data.title,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            width: 10,
                            height: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        floatingActionButton: const CustomFabHome(),
      ),
    );
  }
}

class _ProblemData {
  _ProblemData(this.date, this.title);
  final DateTime date;
  final String title;
}
