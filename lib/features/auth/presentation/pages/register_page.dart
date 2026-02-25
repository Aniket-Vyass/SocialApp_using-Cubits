import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_social_app/features/auth/presentation/components/my_button.dart';
import 'package:small_social_app/features/auth/presentation/components/my_textfield.dart';
import 'package:small_social_app/features/auth/presentation/cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;

  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //TextField edting controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPwController = TextEditingController();

  //REGISTER button pressed
  void register() {
    //prepare info
    final String name = nameController.text;
    final String email = emailController.text;
    final String pw = passwordController.text;
    final String confirmPw = confirmPwController.text;

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    //ensure fields aren't empty
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        pw.isNotEmpty &&
        confirmPw.isNotEmpty) {
      //ensure pw and confirmPw match
      if (pw == confirmPw) {
        authCubit.register(email, pw, name);
      }
      //if pw and confirmPw do not match
      else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Passwords do not match!')));
      }
    }
    //fields are empty
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all the fields!')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  //Build UI
  @override
  Widget build(BuildContext context) {
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
                "Let's create an account for you",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 25),

              // name
              MyTextfield(
                controller: nameController,
                hintText: 'Name',
                obscureText: false,
              ),
              const SizedBox(height: 10),

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

              const SizedBox(height: 10),
              //password
              MyTextfield(
                controller: confirmPwController,
                hintText: 'Confirm password',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              //login button
              MyButton(onTap: register, text: 'SIGN UP'),
              const SizedBox(height: 24),

              //auth sign in later with (google, apple)

              //Already have an account  login now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.togglePages,
                    child: Text(
                      'Login now',
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
