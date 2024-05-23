import 'package:flutter/material.dart';
import 'package:medical_record/screens/plan_of_care/plan_of_care_page.dart';
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
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/splash': (context) => const SplashScreen(),
        '/allergies': (context) => const AllergiesPage(),
        '/immunizations': (context) => const ImmunizationsPage(),
        '/medication': (context) => const MedicationPage(),
        '/problem_list': (context) => const ProblemListPage(),
        '/procedures': (context) => const ProceduresPage(),
        '/demographics': (context) => const DemographicsPage(),
        '/plan_of_care': (context) => const PlanOfCarePage(),
      },
    );
  }
}
