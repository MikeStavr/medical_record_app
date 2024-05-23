import 'package:flutter/material.dart';

class CustomMenu extends StatelessWidget {
  const CustomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.medical_services_sharp,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'Medical Record',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.sunny),
            title: const Text('Allergies'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/allergies');
            },
          ),
          ListTile(
            leading: const Icon(Icons.medical_services_sharp),
            title: const Text('Immunizations'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/immunizations');
            },
          ),
          ListTile(
            leading: const Icon(Icons.medication),
            title: const Text('Medication'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/medication');
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Problem List'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/problem_list');
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_hospital),
            title: const Text('Procedures'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/procedures');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Demographics'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/demographics');
            },
          ),
          ListTile(
            leading: const Icon(Icons.medical_services_sharp),
            title: const Text('Plan of Care'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/plan_of_care');
            },
          ),
        ],
      ),
    );
  }
}
