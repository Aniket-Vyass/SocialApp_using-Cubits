import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:small_social_app/features/auth/data/firebase_auth_repo.dart';
import 'package:small_social_app/features/auth/presentation/components/loading.dart';
import 'package:small_social_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:small_social_app/features/auth/presentation/cubits/auth_states.dart';
import 'package:small_social_app/features/auth/presentation/pages/auth_page.dart';
import 'package:small_social_app/features/home/presentation/cubit/profile_cubit.dart';
import 'package:small_social_app/features/home/presentation/pages/home_page.dart';
import 'package:small_social_app/features/home/presentation/profile/data/firebase_profile_repo.dart';
import 'package:small_social_app/features/home/presentation/profile/domain/repo/profile_repo.dart';
import 'package:small_social_app/themes/darkmode.dart';
import 'package:small_social_app/themes/lightmode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // auth repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  //profile repo
  final profileRepo = FirebaseProfileRepo();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //providing the cubits to the app
      providers: [
        //auth cubit
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),

        //profile cubit
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(profileRepo: profileRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: lightMode,
        darkTheme: darkMode,
        /*

        BLOC CONSUMER -Auth

        */
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            print(state);
            //unauthenticated
            if (state is Unauthenticated) {
              return const AuthPage();
            }

            //authenticated
            if (state is Authenticated) {
              return const HomePage();
            }
            // loading..
            else {
              return LoadingScreen();
            }
          },
          //listen for state changes
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
