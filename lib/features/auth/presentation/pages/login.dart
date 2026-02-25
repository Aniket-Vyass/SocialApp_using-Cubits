/*


On this page user can login with their:
  -email
  -pw

--------------------------------------------------------------------------

Once the user successfully logs in, they will be directed to homepage

if user dosen't have an acc then we can go to register page to create one.

*/

import 'package:flutter/material.dart';
import 'package:small_social_app/features/auth/presentation/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
      //APP BAR
      appBar: AppBar(title: Text('Login'), centerTitle: true),

      //BODY
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.lock_open,
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),

            //name of the app
            Text(
              'B U I L D  L A U N C H  M O N E T I Z E',
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

            //password
            MyTextfield(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            //forgot pw
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            //login button
            ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text('Login'),
              ),
            ),
            const SizedBox(height: 25),

            //auth sign in later with (google, apple)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/google.png', height: 32),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            //don't have an account  register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Register Here',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

// /*

// On this page user can login with their:
//   -email
//   -pw

// --------------------------------------------------------------------------

// Once the user successfully logs in, they will be directed to homepage

// if user dosen't have an acc then we can go to register page to create one.

// */

// import 'package:flutter/material.dart';
// import 'package:small_social_app/features/auth/presentation/components/my_textfield.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   //TextField edting controllers
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   //Build UI
//   @override
//   Widget build(BuildContext context) {
//     //SCAFFOLD
//     return Scaffold(
//       //APP BAR
//       appBar: AppBar(title: Text('Login'), centerTitle: true),

//       //BODY
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             //logo
//             Icon(
//               Icons.lock_open,
//               size: 72,
//               color: Theme.of(context).colorScheme.primary,
//             ),

//             //name of the app
//             Text(
//               'B U I L D  L A U N C H  M O N E T I Z E',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Theme.of(context).colorScheme.inversePrimary,
//               ),
//             ),
//             const SizedBox(height: 25),

//             // email
//             MyTextfield(
//               controller: emailController,
//               hintText: 'Email',
//               obscureText: false,
//             ),

//             //password

//             //forgot pw

//             //login button

//             //auth sign in later with (google, apple)

//             //don't have an account  register now
//           ],
//         ),
//       ),
//     );
//   }
// }
