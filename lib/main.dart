import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkways/color_constants.dart';
import 'package:parkways/pages/authenticate/login_page.dart';
import 'package:parkways/pages/authenticate/register_page.dart';
import 'package:parkways/pages/onboarding_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parkways/pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ThemeData().colorScheme.copyWith(primary: ColorConstants.mainColor),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        future: _checkUserLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              return const WelcomePage();
            } else {
              return const OnboardingPage();
            }
          }
        },
      ),
      initialRoute: 'onboarding_page',
      routes: {
        'onboarding_page': (context) => const OnboardingPage(),
        'login_page': (context) => const LoginPage(),
        'register_page': (context) => const RegisterPage(),
        'welcome_page': (context) => const WelcomePage(),
      },
    );
  }

  Future<User?> _checkUserLoggedIn() async {
    return FirebaseAuth.instance.authStateChanges().first;
  }
}
