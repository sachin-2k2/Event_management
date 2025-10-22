import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venuemanagement/student/login.dart';
import 'package:venuemanagement/student/registration.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  File? _profileImage;
  Map<String, dynamic>? profile; // ✅ Use Map instead of List
  bool isLoading = true;

  Dio dio = Dio();

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      await post_profile(context);
    }
  }

  // Get profile data
  Future<void> get_profile(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? lid = prefs.getInt('login_id');

      if (lid == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login ID not found')),
        );
        return;
      }

      final response = await dio.get('$baseurl/ProfilesApi/$lid');
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          profile = (response.data as List).isNotEmpty ? response.data[0] : null; // ✅ now it's a single object
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load profile')),
        );
      }
    } catch (e) {
      print('Error fetching profile: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Upload new profile image
  Future<void> post_profile(BuildContext context) async {
    if (_profileImage == null) return;

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? loginid = prefs.getInt('login_id');

      if (loginid == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not logged in')),
        );
        return;
      }

      String fileName = _profileImage!.path.split('/').last;

      FormData formData = FormData.fromMap({
        'Img': await MultipartFile.fromFile(
          _profileImage!.path,
          filename: fileName,
        ),
      });

      final response = await dio.put(
        '$baseurl/ProfilesApi/$loginid',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully')),
        );
        await get_profile(context); // Reload profile data
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed')),
        );
      }
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    get_profile(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : profile == null
              ? Center(
                  child: Text(
                    'No profile data found.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/venue1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 100),
                        Text(
                          'PROFILE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Venue Management App',
                          style: TextStyle(
                            color: const Color.fromARGB(206, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 60),
                        Container(
                          width: 330,
                          height: 230,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 15),
                              GestureDetector(
                                onTap: _pickImage,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: _profileImage != null
                                      ? FileImage(_profileImage!)
                                      : (profile!['Img'] != null
                                          ? NetworkImage(
                                              '$baseurl${profile!['Img']}')
                                          : null) as ImageProvider?,
                                  child: _profileImage == null &&
                                          (profile!['Img'] == null)
                                      ? Icon(Icons.person, size: 60)
                                      : null,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                profile!['Name'] ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          width: 330,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black26,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  'Personal Details:',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(height: 30),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        'Email:',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        profile!['Email'] ?? '',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        'Phone No:',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        profile!['phone'].toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        'Address:',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        profile!['Place'] ?? 'Not Provided',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
    );
  }
}
