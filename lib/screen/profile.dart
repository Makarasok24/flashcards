import 'dart:io';
import 'package:flashcards/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flashcards/widget/icon_button.dart'; // Assuming custom widget

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  final _imagePicker = ImagePicker();
  String _username = "Makara Sok";
  String _email = "makarasok.it@gmail.com";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      _saveProfileImage(pickedFile.path);
    }
  }

  // Load saved profile info from SharedPreferences
  _getProfileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? _username;
      _email = prefs.getString('email') ?? _email;
      String? profilePath = prefs.getString('profilePath');
      if (profilePath != null) {
        _profileImage = File(profilePath);
      }
    });
  }

  _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _nameController.text);
    prefs.setString('email', _emailController.text);

    setState(() {
      _username = _nameController.text;
      _email = _emailController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profile saved success'),
        backgroundColor: Colors.green.shade200,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Save profile path
  _saveProfileImage(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profilePath', path);
  }

  @override
  void initState() {
    super.initState();
    _getProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          const Center(
            child: Text(
              "My Profile",
              style: TextStyle(fontSize: 25),
            ),
          ),
          const SizedBox(height: 20),
          // Display profile image if available, otherwise show placeholder
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 3, color: Colors.blue.shade300),
              borderRadius: BorderRadius.circular(50),
            ),
            child: _profileImage == null
                ? const Center(
                    child: Text(
                      "あ", // Placeholder character
                      style: TextStyle(fontSize: 40),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      _profileImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          // Button to pick image from gallery
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _pickImageFromGallery,
            color: Colors.blue.shade300,
          ),
          const SizedBox(height: 20),
          // Manage profile button
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Iconbutton(
              iconButtonName: "Manage Profile",
              category: Category.edit,
              onTap: () {
                _nameController.text = _username;
                _emailController.text = _email;
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Edit Profile'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                          ),
                          TextField(
                            controller: _emailController,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                          ),
                        ],
                      ),
                      actions: [
                        Column(
                          children: [
                            Button(
                              nameButton: "Cancel",
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(height: 10),
                            Button(
                              nameButton: "Save",
                              onTap: () {
                                _saveProfile();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              color: Colors.blue.shade300,
              textColor: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                //color: Colors.blue.shade300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade300,
                ),
                child: const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _username,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                //color: Colors.blue.shade300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade300,
                ),
                child: const Icon(
                  Icons.email_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _email,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          )
        ],
      ),
    );
  }
}
