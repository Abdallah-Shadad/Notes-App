import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/constants.dart';
import 'package:notes/widgets/custom_button.dart';
import 'package:notes/widgets/custom_icons.dart';
import 'package:notes/widgets/password_text_field.dart';
import 'package:notes/widgets/custom_text_field.dart';

import 'notes_list_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static const String id = 'SignupPage';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSignUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // تحقق من المستخدم الحالي
      final user = userCredential.user;
      if (user != null) {
        // الانتقال لصفحة الملاحظات بعد التسجيل
        Navigator.pushReplacementNamed(context, NotesListPage.id);
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'email-already-in-use') {
        message = 'This email is already registered.';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak.';
      } else {
        message = e.message ?? 'An error occurred';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header
          Container(
            height: 320,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset('assets/images/notes3.png', width: 150),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Notes ',
                      style: TextStyle(
                        fontFamily: 'PatrickHand',
                        color: kPrimaryColor2,
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'APP',
                      style: TextStyle(
                        fontFamily: 'PatrickHand',
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 42),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  suffixIcon: const Icon(Icons.mail_outlined),
                ),
                const SizedBox(height: 16),
                PasswordTextField(
                  controller: _passwordController,
                  hint: 'Enter your password',
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: _handleSignUp,
                  child: const CustomButton(btnName: 'SIGN UP'),
                ),
                const SizedBox(height: 22),
              ],
            ),
          ),
          Column(
            children: [
              const Text(
                'or',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIcons(iconType: 'apple', size: 31),
                  SizedBox(width: 20),
                  CustomIcons(iconType: 'google', size: 42),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?  ',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
