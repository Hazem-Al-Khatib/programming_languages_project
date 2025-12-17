// ignore_for_file: deprecated_member_use, use_build_context_synchronously, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pl_project/screens/login_screen.dart';
import 'package:pl_project/services/auth_service.dart';
import 'package:pl_project/widgets/signup_screen_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  File? idImage;
  File? personalImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF1F2937),
        title: const Text(
          "Sign Up",
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
                    "Create Account",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Name fields
                  FirstNameField(controller: firstNameController),
                  const SizedBox(height: 16),
                  LastNameField(controller: lastNameController),
                  const SizedBox(height: 16),

                  // Phone
                  PhoneNumberField(controller: phoneController),
                  const SizedBox(height: 16),

                  // Birth date
                  BirthDateField(controller: birthDateController),
                  const SizedBox(height: 16),

                  // ID and personal images
                  IDImageField(
                    label: "Upload ID Image",
                    onImagePicked: (file) => idImage = file,
                  ),
                  const SizedBox(height: 16),
                  PersonalImageField(
                    label: "Upload Personal Image",
                    onImagePicked: (file) => personalImage = file,
                  ),
                  const SizedBox(height: 28),

                  // Sign up button
                  SignUpButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      if (idImage == null || personalImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please upload ID and personal images",
                            ),
                          ),
                        );
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Signing up...")),
                      );

                      final response = await AuthService.signup(
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        phone: phoneController.text.trim(),
                        birthDate: birthDateController.text.trim(),
                        idImage: idImage!,
                        personalImage: personalImage!,
                      );

                      if (response["success"] == true) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              response["message"] ?? "Signup failed",
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  const AlreadyHaveAnAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
