// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pl_project/screens/home_screen.dart';
import 'package:pl_project/services/auth_service.dart';
import 'package:pl_project/widgets/login_screen_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF1F2937),
        title: const Text(
          'Log In',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 24),

                  UserNameField(controller: usernameController),
                  const SizedBox(height: 16),

                  PhoneNumberField(controller: phoneController),
                  const SizedBox(height: 28),

                  LogInButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Logging in...")),
                      );

                      final response = await AuthService.login(
                        username: usernameController.text
                            .trim(), // ✅ pass the username
                        phone: phoneController.text.trim(), // ✅ pass the phone
                      );

                      if (response["user"] != null) {
                        // ✅ backend now returns 'user'
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Successful")),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => HomeScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              response["message"] ?? "Login failed",
                            ),
                          ),
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 20),
                  const DontHaveAnAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
