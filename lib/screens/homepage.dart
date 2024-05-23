import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_record/utils/data/app_info.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<String> futureAdvice;

  Future<String> getAdvice() {
    return http.get(Uri.parse('https://api.adviceslip.com/advice')).then(
      (response) {
        if (response.statusCode == 200) {
          return jsonDecode(response.body)['slip']['advice'];
        } else {
          throw Exception('Failed to load advice');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    futureAdvice = getAdvice();
  }

  @override
  Widget build(BuildContext context) {
    List<String> sections = ApplicationData.sections;

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppbar(title: "Homepage"),
        drawer: const CustomMenu(),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    color: const Color.fromARGB(255, 77, 216, 235),
                    child: const Row(
                      children: [
                        Icon(Icons.person, size: 50, color: Colors.white),
                        Text(
                          'Welcome, Mrs. Elen Ross, \nto your medical record!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),
            Row(
              children: [
                FutureBuilder(
                  future: futureAdvice,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 77, 216, 235),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            snapshot.data!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Expanded(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 77, 216, 235),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                )
              ],
            ),
            // Grid for different sections of the app.
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const Icon(
                        Icons.medical_information_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            ApplicationData.sections[index],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      tileColor: const Color.fromARGB(255, 77, 216, 235),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onTap: () {
                        switch (sections[index]) {
                          case 'Allergies':
                            Navigator.pushNamed(context, '/allergies');
                            break;
                          case 'Immunization':
                            Navigator.pushNamed(context, '/immunizations');
                            break;
                          case 'Medication':
                            Navigator.pushNamed(context, '/medication');
                            break;
                          case 'Problem List':
                            Navigator.pushNamed(context, '/problem_list');
                            break;
                          case 'Procedures':
                            Navigator.pushNamed(context, '/procedures');
                            break;
                          case 'Demographics':
                            Navigator.pushNamed(context, '/demographics');
                            break;
                          case 'Plan of Care':
                            Navigator.pushNamed(context, '/plan_of_care');
                        }
                      },
                    ),
                  );
                },
                itemCount: ApplicationData.sections.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
