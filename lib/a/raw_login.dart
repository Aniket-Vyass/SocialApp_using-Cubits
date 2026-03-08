import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(controller: emailController),
                SizedBox(height: 10),
                TextField(controller: passwordController),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await firebaseAuth.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            e.message ?? 'Login Failed! Enter Correct details',
                          ),
                        ),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: isLoading
                      ? ScaffoldMessenger(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const Text('Login'),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),

                    ////TextButton(
                    //onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) {

                    //     },
                    //   ),
                    //);
                    //},
                    //child: Text("Register"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
