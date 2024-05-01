import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

List<String> genders = <String>[
  "Male",
  "Female",
  "Do not want to declare",
];

class _RegisterPageState extends State<RegisterPage> {
  DateTime? selectedDate = DateTime.now();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2024),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  String genderSelected = genders.first;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  bool allThree = false;

  void handleControllers() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are required"),
        ),
      );
      return;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email"),
        ),
      );
      return;
    }
    if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password must be at least 8 characters"),
        ),
      );
      return;
    }
    if (double.tryParse(weightController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Weight must be a number"),
        ),
      );
      return;
    }
    allThree = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.6,
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: "Name",
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: CustomTextField(
                      label: "Surname",
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => {_pickDate(context)},
                    icon: const Icon(Icons.calendar_month),
                    iconSize: 32,
                  ),
                  Text(
                    selectedDate.toString().split(" ")[0],
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
              DropdownButton(
                value: genderSelected,
                icon: const Icon(Icons.arrow_downward),
                onChanged: (String? selected) => {
                  setState(
                    () {
                      genderSelected = selected!;
                    },
                  ),
                },
                items: genders.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
              ),
              CustomTextField(
                label: "Weight",
                controller: weightController,
              ),
              const SizedBox(height: 5),
              const CustomTextField(label: "Username"),
              const SizedBox(height: 5),
              CustomTextField(
                label: "Password",
                controller: passwordController,
              ),
              const SizedBox(height: 5),
              CustomTextField(
                label: "Email",
                controller: emailController,
              ),
              ElevatedButton(
                onPressed: () {
                  handleControllers();
                  if (allThree) {
                    Navigator.pushNamed(context, '/login');
                  }
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
