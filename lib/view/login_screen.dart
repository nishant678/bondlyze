import 'package:bondlyze/view/widget/custom_button.dart';
import 'package:bondlyze/view/widget/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final emailController = TextEditingController();
    final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: "Enter Your Email",
                        prefixIcon: Icons.email,
                        controller: emailController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: "Enter Your Password",
                        prefixIcon: Icons.lock,
                        obscureText: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 20),
                      
                        CustomButton(
                          text: "Log In",
                          onPressed: () {
                             
                          },
                        ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Don't have an account? Sign Up"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8A2BE2), Color(0xFFFF2E7E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(140)),
      ),
      alignment: const Alignment(0, 0.4),
      child: Text(
        'Log In',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}