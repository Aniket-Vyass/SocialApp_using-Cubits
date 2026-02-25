/*


On this page user can login with their:
  -email
  -pw

--------------------------------------------------------------------------

Once the user successfully logs in, they will be directed to homepage

if user dosen't have an acc then we can go to register page to create one.

*/

import 'package:flutter/material.dart';
import 'package:small_social_app/features/auth/presentation/components/my_button.dart';
import 'package:small_social_app/features/auth/presentation/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;

  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TextField edting controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //Build UI
  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return Scaffold(
      //BODY
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.lock_open,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 25),
              //name of the app
              Text(
                'Build, Launch & Monetize',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 25),

              // email
              MyTextfield(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              //password
              MyTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: false,
              ),

              //forgot pw
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              //login button
              MyButton(onTap: () {}, text: 'LOGIN'),
              const SizedBox(height: 25),

              //auth sign in later with (google, apple)

              //don't have an account  register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.togglePages,
                    child: Text(
                      'Register now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
