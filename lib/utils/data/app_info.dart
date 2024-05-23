import 'dart:convert';

import 'package:flutter/services.dart';

class ApplicationData {
  static Future<Map> loadFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    final list = json.decode(jsonString) as Map;
    return list;
  }

  static List<String> sections = [
    'Allergies',
    'Immunization',
    'Medication',
    'Problem List',
    'Procedures',
    'Demographics',
    'Plan of Care',
  ];
}
