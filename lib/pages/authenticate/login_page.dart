import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logging/logging.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:parkways/color_constants.dart';
import 'package:parkways/widgets/custom_button.dart';
import 'package:parkways/widgets/custom_text_field.dart';
import 'package:parkways/widgets/custom_text_span.dart';

import '../../model/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String? email;
  late String? password;
  late bool showLoading = false;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/parkways_logo.png'),
                  const SizedBox(height: 10),
                  Text(
                    'Masuk',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.primaryFontColor),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    titleText: 'Email',
                    hintText: 'Masukkan email',
                    icon: Icons.person,
                    isPassword: false,
                    onChanged: (value) => email = value,
                  ),
                  CustomTextField(
                    titleText: 'Password',
                    hintText: 'Masukkan password',
                    icon: Icons.lock,
                    isPassword: true,
                    onChanged: (value) => password = value,
                  ),
                  Text(
                    'Lupa password?',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.mainColor),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    color: ColorConstants.mainColor,
                    text: 'Masuk',
                    onPressed: () => _login(context),
                  ),
                  const SizedBox(height: 20),
                  CustomTextSpan(
                      firstText: 'Belum punya akun? ',
                      secondText: 'Daftar',
                      onTap: () {
                        Navigator.pushNamed(context, 'register_page');
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _validateEmail(String? email) {
    return email != null && email.isNotEmpty;
  }

  bool _validatePassword(String? password) {
    return password != null && password.isNotEmpty;
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: ColorConstants.mainColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> _login(BuildContext context) async {
    final loginUser = LoginUser(email: email, password: password);

    if (loginUser.email == null || loginUser.email!.isEmpty) {
      _showToast('Email tidak boleh kosong.');
      return;
    }

    if (loginUser.password == null || loginUser.password!.isEmpty) {
      _showToast('Password tidak boleh kosong.');
      return;
    }

    setState(() {
      showLoading = true;
    });

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: loginUser.email!,
        password: loginUser.password!,
      );

      if (userCredential.user != null) {
        Navigator.pushNamed(context, 'welcome_page');
      } else {
        _showToast('Email atau password salah');
      }
    } catch (e) {
      _showToast('Terjadi kesalahan saat login.');
      Logger('Error:').info(e);
    }

    setState(() {
      showLoading = false;
    });
  }
}
