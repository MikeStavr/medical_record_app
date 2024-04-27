import 'package:flutter/material.dart';
import 'package:medical_record/utils/data/app_info.dart';
import 'package:medical_record/widgets/custom_appbar.dart';
import 'package:medical_record/widgets/custom_menu.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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

            const SizedBox(height: 25),
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
