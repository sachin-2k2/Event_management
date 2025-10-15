import 'package:flutter/material.dart';
import 'package:venuemanagement/student/events.dart';
import 'package:venuemanagement/student/feedback.dart';
import 'package:venuemanagement/student/login.dart';
import 'package:venuemanagement/student/notification.dart';
import 'package:venuemanagement/student/profile%20.dart';
import 'package:venuemanagement/student/venues.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

void logout(context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Logout'),
      content: Text(
        'Are you sure want to Logout ',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: const Color.fromARGB(255, 12, 12, 12)),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => loginpage()),
            );
          },
          child: Text('Logout', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

class _HomepageState extends State<Homepage> {
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 15),
                      child: InkWell(
                        onTap: () {
                          logout(context);
                        },
                        child: Card(
                          color: Colors.black12,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  249,
                                  248,
                                  248,
                                ),
                                child: Icon(
                                  Icons.logout_outlined,
                                  size: 16,
                                  color: const Color.fromARGB(255, 3, 3, 3),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Log Out',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 90),
                Text(
                  'HOME',
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
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: const Color.fromARGB(71, 0, 0, 0),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Text(
                          'UPCOMING EVENT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      leading: Icon(Icons.event_seat, color: Colors.white),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Anual Tech Conference',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'DEC 15,2024',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Eventpage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 95,
                            width: 95,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                223,
                                24,
                                24,
                                24,
                              ), // semi-transparent black
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    155,
                                    71,
                                    69,
                                    69,
                                    // ignore: deprecated_member_use
                                  ).withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.calendar_month,
                                  color: Color.fromARGB(220, 255, 255, 255),
                                  size: 32,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'EVENTS',
                                  style: TextStyle(
                                    color: Color.fromARGB(220, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Venuespage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 95,
                            width: 95,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                223,
                                24,
                                24,
                                24,
                              ), // semi-transparent black
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    255,
                                    4,
                                    4,
                                    4,
                                    // ignore: deprecated_member_use
                                  ).withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.business,
                                  color: Color.fromARGB(220, 255, 255, 255),
                                  size: 32,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'VENUES',
                                  style: TextStyle(
                                    color: Color.fromARGB(220, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Feedbackpage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 95,
                            width: 95,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                223,
                                24,
                                24,
                                24,
                              ), // semi-transparent black
                              borderRadius: BorderRadius.circular(
                                10,
                              ), // rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    255,
                                    23,
                                    22,
                                    22,
                                    // ignore: deprecated_member_use
                                  ).withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.star_half,
                                  color: Color.fromARGB(220, 252, 230, 28),
                                  size: 32,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'FEEDBACK',
                                  style: TextStyle(
                                    color: Color.fromARGB(220, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
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
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profilepage(),
                            ),
                          );
                        },
                        child: Container(
                          height: 90,
                          width: 160,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              160,
                              0,
                              0,
                              0,
                            ), // semi-transparent black
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // rounded corners
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    252,
                                    253,
                                    254,
                                  ), // border color
                                  shape: BoxShape.circle,
                                ),

                                child: CircleAvatar(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    248,
                                    246,
                                    246,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: const Color.fromARGB(
                                      255,
                                      21,
                                      20,
                                      20,
                                    ),
                                    size: 32,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'PROFILE',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Notificationpage(),
                            ),
                          );
                        },
                        child: Container(
                          height: 90,
                          width: 180,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              160,
                              0,
                              0,
                              0,
                            ), // semi-transparent black
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // rounded corners
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    252,
                                    253,
                                    254,
                                  ), // border color
                                  shape: BoxShape.circle,
                                ),

                                child: CircleAvatar(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    248,
                                    246,
                                    246,
                                  ),
                                  child: Icon(
                                    Icons.notifications_active,
                                    color: const Color.fromARGB(
                                      255,
                                      21,
                                      20,
                                      20,
                                    ),
                                    size: 32,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'NOTIFICATION',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
