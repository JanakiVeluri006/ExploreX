import 'package:flutter/material.dart';

import '../../services/auth/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = "";
  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "Please fill all fields.";
      });
      return;
    }
    if (password.length < 6) {
      setState(() {
        errorMessage = "Password must contain at least 6 characters.";
      });
      return;
    }
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    final user = await AuthService.registerUser(email: email, password: password);

    setState(() {
      isLoading = false;
    });

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successful 🎉")),
      );

      Navigator.pop(context);

    } else {
      setState(() {
        errorMessage = "Registration failed. Try another email.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          ),
        ),

        child: Center(
         child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 15, offset: Offset(0, 6))
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.flight_takeoff, size: 70, color: Color(0xFF2563EB)),

                  const SizedBox(height: 16),

                  const Text(
                    "Create Your Journey 🌍",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Start collecting your travel memories with ExploreX",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey,fontSize: 14)),

                  const SizedBox(height: 30),

                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration:InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                    ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: isLoading? null: register,
                      style:
                          ElevatedButton.styleFrom(
                            backgroundColor:const Color(0xFF2563EB),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color:Colors.white)
                          : const Text(
                              "Register", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:Colors.white),
                            ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}