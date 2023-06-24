import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:parkways/color_constants.dart';
import 'package:parkways/widgets/custom_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? username;

  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final dataSnapshot = await _database.child('users').child(userId).once();

      if (dataSnapshot.snapshot.value != null) {
        final userData = dataSnapshot.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          username = userData['username'];
        });
      }
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, 'login_page', (route) => false);
    } catch (e) {
      Logger('Error:').info(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/parkways_icon_only.png'),
              const SizedBox(height: 24.0),
              Text(
                'Halo $username',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Parkways menghadirkan solusi parkir dengan investment yang rendah dan dilengkapi berbagai fitur berikut.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: CustomButton(
            color: ColorConstants.mainColor,
            text: 'Logout',
            onPressed: () => _logout(),
          ),
        ),
      ),
    );
  }
}
