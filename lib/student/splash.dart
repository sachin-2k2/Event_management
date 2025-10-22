import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venuemanagement/student/home.dart';
import 'package:venuemanagement/student/login.dart';

class splash_page extends StatefulWidget {
  const splash_page({super.key});

  @override
  State<splash_page> createState() => _splash_pasgeState();
}

class _splash_pasgeState extends State<splash_page> {
  Future<void> check_login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool is_loged = pref.getBool('logged') ?? false;
    await Future.delayed(Duration(seconds: 1));
    if (is_loged) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => loginpage()),
      );
    }
  }

  @override
  void initState() {
    check_login();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: const Color.fromARGB(255, 251, 251, 251),
              radius: 100,
              backgroundImage: AssetImage('assets/images/venue1.png'),
            ),
          ],
        ),
      ),
    );
  }
}
