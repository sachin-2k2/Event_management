import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:venuemanagement/student/events.dart';
import 'package:venuemanagement/student/registration.dart';

class Notificationpage extends StatefulWidget {
  const Notificationpage({super.key});

  @override
  State<Notificationpage> createState() => _NotificationpageState();
}

Dio dio = Dio();
List<dynamic> notification = [];

class _NotificationpageState extends State<Notificationpage> {
  Future<void> get_notification(context) async {
    try {
      final response = await dio.get('$baseurl/NotificationApi/', );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          notification = response.data;
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        // SnackBar(content: Text(' ')),
        // );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('failed')));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_notification(context);
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
          child: Column(
            children: [
              SizedBox(height: 60),
              Text(
                'NOTIFICATION',
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
              Expanded(
                child: ListView.builder(
                  itemCount: notification.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.black26,
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10.0,
                              top: 10,
                            ),
                            child: Text(
                              'Notification',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification[index]['Notification'],
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 20),
                              Text(
                                notification[index]['Date'],
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
