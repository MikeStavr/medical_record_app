import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart'; // Import the intl package

class ProceduresPage extends StatefulWidget {
  const ProceduresPage({super.key});

  @override
  State<ProceduresPage> createState() => _ProceduresPageState();
}

class _ProceduresPageState extends State<ProceduresPage> {
  List<dynamic>? procedures;
  final TextEditingController _procedureController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _providerController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Load the JSON File before the widget is built.
    DefaultAssetBundle.of(context)
        .loadString("assets/procedures.json")
        .then((value) {
      setState(() {
        procedures = json.decode(value.toString())["procedures"];
      });
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  // Once the calendar is clicked, pop up a dialog to select the date.
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

  List<_ProcedureData> _getChartData() {
    if (procedures == null) {
      return [];
    }

    final dateFormat = DateFormat('MMMM d, yyyy');

    return procedures!.map((procedure) {
      final date = dateFormat.parse(procedure["date"]);
      return _ProcedureData(date, procedure["name"]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          title: const Text("Procedures"),
          bottom: const TabBar(
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(icon: Icon(Icons.medical_information), text: "Procedures"),
              Tab(
                icon: Icon(Icons.create),
                text: "Insert",
              ),
              Tab(icon: Icon(Icons.insert_chart), text: "Chart"),
            ],
          ),
        ),
        drawer: const CustomMenu(),
        body: procedures == null
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  // Procedures tab
                  ListView.builder(
                    itemBuilder: (context, index) {
                      var procedure = procedures![index];
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(procedure["name"]),
                              subtitle: Text("Date: ${procedure["date"]}"),
                            ),
                            ListTile(
                              title: Text("Provider: ${procedure["provider"]}"),
                              subtitle:
                                  Text("Location: ${procedure["location"]}"),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: procedures!.length,
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
                            controller: _procedureController,
                            decoration: const InputDecoration(
                              labelText: "Procedure Title",
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
                            controller: _providerController,
                            decoration: const InputDecoration(
                              labelText: "Provider",
                              icon: Icon(Icons.person),
                            ),
                          ),
                          TextField(
                            controller: _locationController,
                            decoration: const InputDecoration(
                              labelText: "Location",
                              icon: Icon(Icons.location_city),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (_procedureController.text.isEmpty ||
                                    _dateController.text.isEmpty ||
                                    _providerController.text.isEmpty ||
                                    _locationController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                          SizedBox(width: 8),
                                          Text("Please fill out all fields.")
                                        ],
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                procedures!.add({
                                  "name": _procedureController.text,
                                  "date": _dateController.text,
                                  "provider": _providerController.text,
                                  "location": _locationController.text,
                                });
                                _procedureController.clear();
                                _dateController.clear();
                                _providerController.clear();
                                _locationController.clear();
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
                      ),
                      primaryYAxis: const CategoryAxis(
                        title: AxisTitle(text: 'Procedure Title'),
                        isVisible: false, // Hide the y-axis
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        ScatterSeries<_ProcedureData, DateTime>(
                          dataSource: _getChartData(),
                          xValueMapper: (_ProcedureData data, _) => data.date,
                          yValueMapper: (_ProcedureData data, _) =>
                              data.title.length,
                          dataLabelMapper: (_ProcedureData data, _) =>
                              data.title,
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

class _ProcedureData {
  _ProcedureData(this.date, this.title);
  final DateTime date;
  final String title;
}
