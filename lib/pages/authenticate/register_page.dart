import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String? email;
  late String? password;
  late String? username;
  late bool showLoading = false;

  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Daftar',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.primaryFontColor),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    titleText: 'Username',
                    hintText: 'Masukkan username',
                    icon: Icons.person_2_outlined,
                    isPassword: false,
                    onChanged: (value) => username = value,
                  ),
                  CustomTextField(
                    titleText: 'Email',
                    hintText: 'Masukkan email',
                    icon: Icons.email_outlined,
                    isPassword: false,
                    onChanged: (value) => email = value,
                  ),
                  CustomTextField(
                    titleText: 'Password',
                    hintText: 'Masukkan password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    onChanged: (value) => password = value,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    color: ColorConstants.mainColor,
                    text: 'Daftar',
                    onPressed: () => _register(context),
                  ),
                  const SizedBox(height: 20),
                  CustomTextSpan(
                      firstText: 'Sudah punya akun? ',
                      secondText: 'Masuk',
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

  bool _validateUsername(String? username) {
    return username != null && username.isNotEmpty;
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

  Future<void> _register(BuildContext context) async {
    final registerUser =
        LoginUser(email: email, password: password, username: username);

    if (!_validateEmail(registerUser.email)) {
      _showToast('Email tidak valid.');
      return;
    }

    if (!_validatePassword(registerUser.password)) {
      _showToast('Password tidak valid.');
      return;
    }

    if (!_validateUsername(registerUser.username)) {
      _showToast('Username tidak valid.');
      return;
    }

    setState(() {
      showLoading = true;
    });

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: registerUser.email!,
        password: registerUser.password!,
      );

      if (userCredential.user != null) {
        // Simpan data pengguna ke Realtime Database
        await _saveUserData(userCredential.user!.uid, registerUser);

        _showToast('Pendaftaran berhasil!');
        Navigator.pushNamed(context, 'welcome_page');
      } else {
        _showToast('Gagal melakukan pendaftaran.');
      }
    } catch (e) {
      _showToast('Terjadi kesalahan saat pendaftaran.');
      Logger('Error:').info(e);
    }

    setState(() {
      showLoading = false;
    });
  }

  Future<void> _saveUserData(String userId, LoginUser registerUser) async {
    final userRef = _database.reference().child('users').child(userId);

    final userData = {
      'email': registerUser.email,
      'username': registerUser.username,
      // Tambahan data pengguna lainnya
    };

    await userRef.set(userData);
  }
}
