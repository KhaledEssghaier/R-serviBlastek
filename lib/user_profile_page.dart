import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String email; // Email to fetch user data

  UserProfilePage({required this.email});

  bool _isGuest() {
    return email.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    if (_isGuest()) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Guest Profile'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You are currently using the app as a guest.'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create_account');
                },
                child: Text('Create Account'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text('Continue as Guest'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchUserProfile(email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No user data found.'));
          }

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Center the profile image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/user.png'), // Placeholder image
                ),
                SizedBox(height: 20),
                Text('First Name: ${user['first_name']}', style: TextStyle(fontSize: 18)),
                Text('Last Name: ${user['last_name']}', style: TextStyle(fontSize: 18)),
                Text('Email: ${user['email']}', style: TextStyle(fontSize: 18)),
                // Add more fields as necessary
              ],
            ),
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchUserProfile(String email) async {
    // Simulate fetching user profile data
    return {
      'first_name': 'John',
      'last_name': 'Doe',
      'email': email,
    };
  }
}
