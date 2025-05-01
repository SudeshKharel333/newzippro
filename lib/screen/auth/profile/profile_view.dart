import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '/screen/auth/auth_helper.dart';
import '/screen/auth/editprofile/editprofile_view.dart';
import '/screen/auth/login/login_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://example.com/profile_pic.jpg'), // Replace with actual URL or Asset
            ),
            const SizedBox(height: 20),

            // User Name
            const Text(
              'John Doe', // User's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // User Email
            const Text(
              'johndoe@example.com', // User's email
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // Additional Details Section
            Expanded(
              child: ListView(
                children: [
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                      subtitle: Text('+123 456 7890'), // User's phone number
                    ),
                  ),
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text('Address'),
                      subtitle:
                          Text('123 Main St, City, Country'), // User's address
                    ),
                  ),
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.cake),
                      title: Text('Birthday'),
                      subtitle: Text('January 1, 1990'), // User's birthday
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // Add action here
                      Get.offAllNamed('/editProfile');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Background color
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text("Edit Profile"),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      // Set login status to true
                      await AuthHelper.setLoginStatus(false);

                      Get.offAllNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Background color
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text("Logout"),
                  ),

                  // Add more details here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
