import 'package:flutter/material.dart';
import 'package:notes/Screens/signup_page.dart';
import 'package:notes/constants.dart';
import 'package:notes/widgets/custom_button.dart';
import 'package:notes/widgets/custom_icons.dart';
import 'package:notes/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  void _handleLogin(BuildContext context) {
    // For now, just navigate to notes list
    // Later you can add actual authentication logic here
    Navigator.pushReplacementNamed(context, 'NotesListPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
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
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                const CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  suffixIcon: Icon(Icons.mail_outlined),
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  suffixIcon: Icon(Icons.lock_outlined),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => _handleLogin(context),
                  child: const CustomButton(btnName: 'LOGIN'),
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
                  CustomIcons(
                    iconType: 'apple',
                    size: 31,
                    // onTap: _signInWithApple,
                  ),
                  SizedBox(width: 20),
                  CustomIcons(
                    iconType: 'google',
                    size: 42,
                    // onTap: _signInWithGoogle,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?  ',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupPage.id);
                    },
                    child: const Text(
                      'Sign up',
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
