import 'package:flutter/material.dart';
import 'create_account_page.dart'; // Importing the CreateAccountPage
import 'main.dart'; // Importing MyHomePage

import 'account_page.dart'; // Importing the AccountPage

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcaompage.jpg'), // Corrected image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 40,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 150), // Space above inputs and buttons
                Text(
                  'Login', // Added label for login
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20), // Space between label and email input
                Container(
                  width: 250, // Set a specific width for the input box
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: const Color.fromARGB(
                          62, 255, 255, 255), // Set background color to white
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 10.0), // Adjust padding for smaller input
                    ),
                  ),
                ),
                SizedBox(height: 20), // Space between email and password
                Container(
                  width: 250, // Set a specific width for the input box
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: const Color.fromARGB(
                          62, 255, 255, 255), // Set background color to white
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 10.0), // Adjust padding for smaller input
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 20), // Space between password and login button
                ElevatedButton(
                  onPressed: () async {
                    // Handle login action
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please enter email and password')),
                      );
                    } else if (!_isValidEmail(email)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Please enter a valid email address')),
                      );
                      return;
                    } else {
                      // Debug print statement
                      print('Login button pressed with email: $email');

                      // Add actual login logic here
                      // Simulate user login logic
                      if (email == 'test@example.com' &&
                          password == 'password') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountPage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid email or password')),
                        );
                      }


                    }
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 20), // Space between buttons
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateAccountPage()),
                    );
                  },
                  child: Text("I don't have an account"),
                ),
                SizedBox(height: 20), // Space between buttons
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Text("Continue as Guest"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
