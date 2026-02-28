/*


On this page user can login with their:
  -email
  -pw

--------------------------------------------------------------------------

Once the user successfully logs in, they will be directed to homepage

if user dosen't have an acc then we can go to register page to create one.

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_social_app/features/auth/presentation/components/google_sign_in.dart';
import 'package:small_social_app/features/auth/presentation/components/my_button.dart';
import 'package:small_social_app/features/auth/presentation/components/my_textfield.dart';
import 'package:small_social_app/features/auth/presentation/cubits/auth_cubit.dart';

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

  //Auth Cubit
  late final authCubit = context.read<AuthCubit>();

  //login button pressed
  void login() {
    //prepare email and password
    String email = emailController.text;
    String password = passwordController.text;

    //ensure if the fields are filled
    if (email.isNotEmpty && password.isNotEmpty) {
      //login!
      authCubit.login(email, password);
    } //if fields are not filled
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both email % password!")),
      );
    }
  }

  //Forgot password box
  void openForgotPasswordBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Forgot Password'),
        content: MyTextfield(
          hintText: 'Enter Email here',
          obscureText: false,
          controller: emailController,
        ),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),

          //reset button
          TextButton(
            onPressed: () async {
              String message = await authCubit.forgotPassword(
                emailController.text,
              );

              if (message == 'Password reset email sent! Check your inbox!') {
                Navigator.pop(context);
                emailController.dispose();
              }
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }

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
                obscureText: true,
              ),

              //forgot pw
              GestureDetector(
                onTap: () => openForgotPasswordBox(),
                child: Row(
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
              ),
              const SizedBox(height: 25),

              //login button
              MyButton(onTap: login, text: 'LOGIN'),
              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).colorScheme.tertiary,
                    ), // Divider
                  ), // Expanded
                  Text("Or sign in with"),
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).colorScheme.tertiary,
                    ), // Divider
                  ), // Expanded
                ],
              ), // Row

              const SizedBox(height: 25),

              //auth sign in with google
              MyGoogleSignInButton(onTap: () {}),

              const SizedBox(height: 25),

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
