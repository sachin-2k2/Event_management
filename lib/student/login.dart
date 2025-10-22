import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venuemanagement/student/home.dart';
import 'package:venuemanagement/student/registration.dart';

class loginpage extends StatefulWidget {
  loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}
  int? loginid;
class _loginpageState extends State<loginpage> {
  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  final formkey = GlobalKey<FormState>();

  Future<void> login_splash(context) async {
    SharedPreferences log_in = await SharedPreferences.getInstance();
    await log_in.setBool('logged', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
    );
  }

  Dio dio = Dio();

  Future<void> post_login(context) async {
    try {
      final response = await dio.post(
        '$baseurl/LoginAPI/',
        data: {'Username': email.text, 'Password': pass.text},
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        loginid = response.data['login_id'];
        SharedPreferences prefs=await SharedPreferences.getInstance();
        prefs.setInt('login_id', loginid!);
        print(loginid);
        login_splash(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('login succesfull')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('registration failed')));
      }
    } catch (e) {}
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/venue1.png'),

              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(height: 150),
                    Text(
                      'LOG IN TO \n YOUR ACCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      'Venue Management App',
                      style: TextStyle(
                        color: const Color.fromARGB(206, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your Email ';
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        controller: email,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          fillColor: const Color.fromARGB(184, 12, 17, 17),
                          filled: true,
                          label: Text(
                            'Email',
                            style: TextStyle(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 246, 247, 247),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 3,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your Password ';
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        controller: pass,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          fillColor: const Color.fromARGB(184, 12, 17, 17),
                          filled: true,
                          label: Text(
                            'Password',
                            style: TextStyle(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 246, 247, 247),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 3,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          post_login(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 60),
                        backgroundColor: const Color.fromARGB(
                          255,
                          27,
                          150,
                          251,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 140),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont Have You Account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Registration(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 56, 185, 221),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
