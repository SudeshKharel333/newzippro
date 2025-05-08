import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newzippro/constants/config.dart';
import '/screen/auth/auth_helper.dart';
import '/screen/auth/editprofile/editprofile_view.dart';
import '/screen/auth/login/login_view.dart';
import 'package:http/http.dart' as http;

// Model class
class Profile {
  final int userId;
  final String fullName;
  final String email;
  final String phone;

  Profile({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userId: json['user_id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

// Fetch profile function
Future<Profile> fetchProfile() async {
  final int userId = GetStorage().read('userId');
  final response = await http.get(
    Uri.parse('${AppConfig.baseUrl}/api/users/$userId'),
  );

  if (response.statusCode == 200) {
    return Profile.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load profile details');
  }
}

Future<void> deleteUser() async {
  final int userId = GetStorage().read('userId');
  final response = await http.delete(
    Uri.parse('${AppConfig.baseUrl}/api/deleteUser/$userId'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final String message = responseData['message'];
    print('Success: $message');
  } else {
    throw Exception(
        'Failed to delete user. Status code: ${response.statusCode}');
  }
}

// ProfilePage Widget
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Profile> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: FutureBuilder<Profile>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No profile found.'));
          }

          final profile = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Replace with real URL or asset
                ),
                const SizedBox(height: 20),

                // Full Name
                Text(
                  profile.fullName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Email
                Text(
                  profile.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                // Phone Card
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: Text(profile.phone),
                  ),
                ),

                // Edit Profile Button
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add action here
                    Get.offAllNamed('/editProfile');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Edit Profile"),
                ),

                const SizedBox(height: 10),

                // Logout Button
                ElevatedButton(
                  onPressed: () async {
                    await AuthHelper.setLoginStatus(false);

                    Get.offAllNamed('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Logout"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await AuthHelper.setLoginStatus(false);
                    deleteUser();
                    Get.offAllNamed('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Delete account"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
