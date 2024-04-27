import 'package:flutter/material.dart';
import './screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Record App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/': (context) => const Homepage(),
        '/splash': (context) => const SplashScreen(),
        '/allergies': (context) => AllergiesPage(),
        '/immunizations': (context) => ImmunizationsPage(),
        '/medication': (context) => MedicationPage(),
        '/problem_list': (context) => const ProblemListPage(),
        '/procedures': (context) => const ProceduresPage(),
        '/demographics': (context) => const DemographicsPage(),
      },
    );
  }
}