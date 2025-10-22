import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:venuemanagement/student/login.dart';

class Registration extends StatefulWidget {
  Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

final baseurl = 'http://192.168.1.36:5000';

class _RegistrationState extends State<Registration> {
  Dio dio = Dio();

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController admission = TextEditingController();

  TextEditingController reg = TextEditingController();

  TextEditingController addres = TextEditingController();

  TextEditingController pass = TextEditingController();

  TextEditingController phone = TextEditingController();
  final formkey = GlobalKey<FormState>();

  List<dynamic> departments = [];

  String? selectedDepartment;
  int? depid;

  Future<void> post_reg(context) async {
    try {
      final response = await dio.post(
        '$baseurl/Student_API/',
        data: {
          'Name': name.text,
          'Place': addres.text,
          'Email': email.text,
          'phone': phone.text,
          'Username': email.text,
          'DEPARTMENTID': depid,
          'Password': pass.text,
        },
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => loginpage()),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('registration succesfull')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('registration failed')));
      }
    } catch (e) {}
  }

  Future<void> get_department() async {
    try {
      final result = await dio.get('$baseurl/DepartmentApi/');
      print(result.data);
      if (result.statusCode == 200 || result.statusCode == 201) {
        setState(() {
          departments = result.data;
          depid = departments[0]['id'];
        });
        print('department fetched');
      } else {
        print('failed to fetch');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_department();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(240, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8,
            right: 30,
            left: 30,
            bottom: 8,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    'CREATE YOUR ACCOUNT',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Venue Management App',
                    style: TextStyle(color: const Color.fromARGB(167, 0, 0, 0)),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your name ';
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 250, 251, 251),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),

                      label: Text('Name'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Email ';
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      fillColor: const Color.fromARGB(255, 250, 251, 251),
                      filled: true,
                      label: Text('Email'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Phone number ';
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 250, 251, 251),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),

                      label: Text('Phone'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // ✅ Must be int
                  DropdownButtonFormField<String>(
                    value: selectedDepartment,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select your Department ';
                      }
                    },
                    items: departments.map<DropdownMenuItem<String>>((dept) {
                      return DropdownMenuItem<String>(
                        value: dept['Department'], // ✅ display name
                        child: Text(dept['Department']),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedDepartment = value;

                        // Find the department object with matching name
                        final selected = departments.firstWhere(
                          (dept) => dept['Department'] == value,
                          orElse: () => null,
                        );

                        depid = selected != null ? selected['id'] : null;
                        print(
                          'Selected Department: $selectedDepartment, ID: $depid',
                        );
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      fillColor: const Color.fromARGB(255, 250, 251, 251),
                      filled: true,
                      label: Text('Department'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  TextFormField(
                    controller: admission,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Admission number';
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      fillColor: const Color.fromARGB(255, 250, 251, 251),
                      filled: true,
                      label: Text('Admission No'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: reg,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Regisytration number ';
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      fillColor: const Color.fromARGB(255, 250, 251, 251),
                      filled: true,
                      label: Text('Register No'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: addres,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Addrress ';
                      }
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),

                      fillColor: const Color.fromARGB(255, 250, 251, 251),
                      filled: true,
                      label: Text('Address'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: pass,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Password';
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      fillColor: const Color.fromARGB(255, 250, 251, 251),
                      filled: true,
                      label: Text('Password'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        post_reg(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 60),
                      backgroundColor: const Color.fromARGB(255, 128, 191, 243),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'REGISTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
