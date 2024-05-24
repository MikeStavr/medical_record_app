import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart'; // Import the intl package

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  List<dynamic>? medication;
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _prescriberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/medication.json")
        .then((value) {
      setState(() {
        medication = json.decode(value.toString())["medication"];
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

  List<_MedicationData> _getChartData() {
    if (medication == null) {
      return [];
    }

    final dateFormat = DateFormat('MMMM d, yyyy');

    return medication!.map((med) {
      final date = dateFormat.parse(med["date"]);
      return _MedicationData(date, med["name"]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          title: const Text("Medication"),
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            tabs: [
              Tab(icon: Icon(Icons.medical_information), text: "Medication"),
              Tab(
                icon: Icon(Icons.person_pin_circle_outlined),
                text: "Insert",
              ),
              Tab(icon: Icon(Icons.insert_chart), text: "Chart"),
            ],
          ),
        ),
        drawer: const CustomMenu(),
        body: medication == null
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  // Medication list tab
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text("${medication![index]["name"]}"),
                          subtitle: Text("Date: ${medication![index]["date"]}"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () => {
                            showExtraInfoDialog(context, index),
                          },
                        ),
                      );
                    },
                    itemCount: medication!.length,
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
                            controller: _medicationController,
                            decoration: const InputDecoration(
                              labelText: "Medication Name",
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
                            controller: _typeController,
                            decoration: const InputDecoration(
                              labelText: "Type",
                              icon: Icon(Icons.info),
                            ),
                          ),
                          TextField(
                            controller: _doseController,
                            decoration: const InputDecoration(
                              labelText: "Dose",
                              icon: Icon(Icons.info),
                            ),
                          ),
                          TextField(
                            controller: _instructionsController,
                            decoration: const InputDecoration(
                              labelText: "Instructions",
                              icon: Icon(Icons.note),
                            ),
                          ),
                          TextField(
                            controller: _prescriberController,
                            decoration: const InputDecoration(
                              labelText: "Prescriber",
                              icon: Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                medication!.add({
                                  "name": _medicationController.text,
                                  "date": _dateController.text,
                                  "type": _typeController.text,
                                  "dose": _doseController.text,
                                  "instructions": _instructionsController.text,
                                  "prescriber": _prescriberController.text,
                                });
                                _medicationController.clear();
                                _dateController.clear();
                                _typeController.clear();
                                _doseController.clear();
                                _instructionsController.clear();
                                _prescriberController.clear();
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
                        title: AxisTitle(text: 'Medication Name'),
                        isVisible: false,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        ScatterSeries<_MedicationData, DateTime>(
                          dataSource: _getChartData(),
                          xValueMapper: (_MedicationData data, _) => data.date,
                          yValueMapper: (_MedicationData data, _) =>
                              data.name.length,
                          dataLabelMapper: (_MedicationData data, _) =>
                              data.name,
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

  Future<void> showExtraInfoDialog(BuildContext context, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Extra Information for ${medication![index]["name"]}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Type: ${medication![index]["type"]}"),
              Text("Date: ${medication![index]["date"]}"),
              Text("Dose: ${medication![index]["dose"]}"),
              Text("Instructions: ${medication![index]["instructions"]}"),
              Text("Prescriber: ${medication![index]["prescriber"]}"),
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
      },
    );
  }
}

class _MedicationData {
  _MedicationData(this.date, this.name);
  final DateTime date;
  final String name;
}
