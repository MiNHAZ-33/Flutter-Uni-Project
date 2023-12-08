import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/profile_screen.dart';
import 'package:project/screen/reset_password.dart';
import 'package:project/screen/sign_up_page.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF202038),
          elevation: 05,
          title: const Text('LogIn Page'),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF252634),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 75.0,
                  ),
                  const SizedBox(
                    child: Text(
                      "Welcome !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Login to continue",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: _buildInputDecoration("Email", Icons.email),
                      validator: _validateEmail),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration(
                      "Password",
                      Icons.lock,
                    ),
                    obscureText: true,
                    validator: _validatePassword,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  forgetPassword(context),
                  const SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF15900)),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: ${error.message}'),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have Account ?",
                        style: TextStyle(
                          color: Color(0xFFF15900),
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: const Text(
                          " SignUp",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }

  InputDecoration _buildInputDecoration(String label, IconData prefixIcon) {
    return InputDecoration(
        fillColor: const Color(0xAA494A59),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x35949494))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        filled: true,
        labelStyle: const TextStyle(color: Color(0xFF949494)),
        labelText: label,
        prefixIcon: Icon(
          prefixIcon,
          color: const Color(0xFF949494),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }

  forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password ?",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordPage(),
          ),
        ),
      ),
    );
  }
}
