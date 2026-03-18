import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:small_social_app/features/auth/data/firebase_auth_repo.dart';
import 'package:small_social_app/features/auth/presentation/components/loading.dart';
import 'package:small_social_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:small_social_app/features/auth/presentation/cubits/auth_states.dart';
import 'package:small_social_app/features/auth/presentation/pages/auth_page.dart';
import 'package:small_social_app/features/home/presentation/pages/home_page.dart';
import 'package:small_social_app/themes/darkmode.dart';
import 'package:small_social_app/themes/lightmode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final firebaseAuthRepo = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is Unauthenticated) return const AuthPage();
            if (state is Authenticated)
              return const HomePage();
            else
              return LoadingScreen();
          },
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
//organic maps, zelo, briar, pocket ai