import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_fab_home.dart';
import 'package:medical_record/widgets/custom_menu.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart'; // Import the intl package

class PlanOfCarePage extends StatefulWidget {
  const PlanOfCarePage({super.key});

  @override
  State<PlanOfCarePage> createState() => _PlanOfCarePageState();
}

class _PlanOfCarePageState extends State<PlanOfCarePage> {
  List<dynamic>? planOfCare;

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/planofcare.json")
        .then((value) {
      setState(() {
        planOfCare = json.decode(value.toString())["planOfCare"];
      });
    });
  }

  List<_PlanOfCareData> _getChartData() {
    if (planOfCare == null) {
      return [];
    }

    final dateFormat = DateFormat('MMMM d, yyyy');

    return planOfCare!.map((plan) {
      final date = dateFormat.parse(plan["date"]);
      return _PlanOfCareData(date, plan["activityName"]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          title: const Text("Plan of Care"),
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            tabs: [
              Tab(
                text: "Plan of Care list",
                icon: Icon(Icons.list),
              ),
              Tab(
                text: "Chart",
                icon: Icon(Icons.insert_chart),
              ),
            ],
          ),
        ),
        drawer: const CustomMenu(),
        body: planOfCare == null
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(planOfCare![index]["activityName"]),
                              subtitle:
                                  Text("Date: ${planOfCare![index]["date"]}"),
                            ),
                            ListTile(
                              title: Text(
                                  "Instructions: ${planOfCare![index]["instructions"]}"),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: planOfCare!.length ?? 0,
                  ),
                  // Chart tab content
                  Center(
                    child: SfCartesianChart(
                      primaryXAxis: DateTimeAxis(
                        dateFormat: DateFormat.yMd(),
                        title: const AxisTitle(text: 'Date'),
                      ),
                      primaryYAxis: const CategoryAxis(
                        title: AxisTitle(text: 'Activity Name'),
                        isVisible: false,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        ScatterSeries<_PlanOfCareData, DateTime>(
                          dataSource: _getChartData(),
                          xValueMapper: (_PlanOfCareData data, _) => data.date,
                          yValueMapper: (_PlanOfCareData data, _) =>
                              data.activityName.length,
                          dataLabelMapper: (_PlanOfCareData data, _) =>
                              data.activityName,
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

class _PlanOfCareData {
  _PlanOfCareData(this.date, this.activityName);
  final DateTime date;
  final String activityName;
}
