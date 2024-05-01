import 'package:flutter/material.dart';
import 'package:medical_record/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void validateCredentials() {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email and password are required"),
          ),
        );
        return;
      } else if (emailController.text == "jsmith" &&
          passwordController.text == "phrpassword") {
        Navigator.pushNamed(context, '/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid email or password"),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login to your account",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: Column(
                children: [
                  CustomTextField(
                    controller: emailController,
                    label: "Email",
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    label: "Password",
                  ),
                  ElevatedButton(
                    onPressed: () {
                      validateCredentials();
                    },
                    child: const Text("Login"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
