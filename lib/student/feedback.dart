import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:venuemanagement/student/login.dart';

import 'package:venuemanagement/student/registration.dart';

class Feedbackpage extends StatefulWidget {
  const Feedbackpage({super.key});

  @override
  State<Feedbackpage> createState() => _FeedbackpageState();
}

class _FeedbackpageState extends State<Feedbackpage> {
  Dio dio = Dio();
  TextEditingController feedback = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> post_feedback(context) async {
    try {
      final response = await dio.post(
        '$baseurl/FeedbackApi/$loginid',
        data: {'Feedback': feedback.text, 'Rating': _rating},
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' Feedback Submitted Successfully')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('failed')));
      }
    } catch (e) {
      print(e);
    }
  }

  double _rating = 3;

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
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(height: 110),
                  Text(
                    'EVENTS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Venue Management App',
                    style: TextStyle(
                      color: const Color.fromARGB(206, 255, 255, 255),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 88,
                    width: 350,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(131, 26, 33, 36),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(right: 50.0),
                            child: Text(
                              "How Would You Rate Us?",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0),
                            child: Row(
                              children: [
                                Text(
                                  'Rate your experience:',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(131, 26, 33, 36),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: RatingBar.builder(
                        initialRating: _rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 40,
                        itemPadding: EdgeInsetsGeometry.symmetric(
                          horizontal: 2,
                        ),
                        itemBuilder: (context, index) =>
                            Icon(Icons.star, color: Colors.yellow),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Container(
                    height: 410,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(131, 26, 33, 36),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              children: [
                                Text(
                                  'Feedback :',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: feedback,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your feedback';
                                }
                              },
                              maxLines: 5,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),

                                fillColor: const Color.fromARGB(
                                  52,
                                  203,
                                  207,
                                  207,
                                ),
                                filled: true,
                                label: Text(
                                  'Feedback...',
                                  style: TextStyle(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                post_feedback(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(220, 50),
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
                              'SUBMIT FEEDBACK',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          Text(
                            'Thanks For Helping Us Improve!',
                            style: TextStyle(
                              color: const Color.fromARGB(218, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
