import 'package:flutter/material.dart';

import 'user_profile_page.dart'; // Import the UserProfilePage

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Future<bool> _isGuest() async {
    // Simulate guest check logic
    return true; // Assume user is a guest for simulation

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isGuest(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Guest Account'),
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
          appBar: AppBar(
            title: Text('Account'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
                // Assuming the email is stored in a variable or retrieved from user session
                String email = 'user@example.com'; // Replace with actual user email
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfilePage(email: email),
                  ),
                );
              },
              child: Text('View Profile'),
            ),
          ),
        );
      },
    );
  }
}
