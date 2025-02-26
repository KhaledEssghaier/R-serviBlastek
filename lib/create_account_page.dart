import 'package:flutter/material.dart';
import 'dart:ui'; // Import for BackdropFilter
import 'package:crypto/crypto.dart'; // Import for hashing
import 'dart:convert'; // Import for utf8 encoding
import 'user_profile_page.dart'; // Import the UserProfilePage

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  bool isSeller = false; // Toggle between client and seller
  bool _passwordVisible = false; // Toggle for password visibility

  bool _isEmailValid(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[A-Z]'));
  }

  Future<void> _createAccount(BuildContext context) async {
    if (!_isEmailValid(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid email address.')));
      return;
    }

    if (!_isPasswordValid(_passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password must be at least 8 characters long, contain at least one number and one uppercase letter.')));
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match.')));
      return;
    }

    // Hash the password before storing it
    String hashedPassword = sha256.convert(utf8.encode(_passwordController.text)).toString();

    // Simulate account creation logic
    try {
      // Here you would typically send the data to your backend or save it locally
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account created successfully!')));
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage(email: _emailController.text)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error creating account: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 70, 175),
                Color.fromARGB(255, 0, 150, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            leading: IconButton(
              icon: Image.asset('assets/back.png'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Create Account', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/welcampage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Create Account', style: TextStyle(fontSize: 24, color: Colors.white)),
                  SizedBox(height: 20),
                  TextField(controller: _firstNameController, decoration: InputDecoration(labelText: 'First Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1)), filled: true, fillColor: Colors.white)),
                  SizedBox(height: 10),
                  TextField(controller: _lastNameController, decoration: InputDecoration(labelText: 'Last Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1)), filled: true, fillColor: Colors.white)),
                  SizedBox(height: 10),
                  TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1)), filled: true, fillColor: Colors.white)),
                  SizedBox(height: 10),
                  TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1)), filled: true, fillColor: Colors.white), obscureText: !_passwordVisible),
                  IconButton(icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey), onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  }),
                  SizedBox(height: 10),
                  TextField(controller: _confirmPasswordController, decoration: InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1)), filled: true, fillColor: Colors.white), obscureText: !_passwordVisible),
                  SizedBox(height: 20),
                  SwitchListTile(title: Text(isSeller ? 'Switch to Client' : 'Switch to Seller', style: TextStyle(color: Colors.white)), value: isSeller, onChanged: (value) {
                    setState(() {
                      isSeller = value;
                    });
                  }),
                  if (isSeller) ...[
                    TextField(controller: _phoneNumberController, decoration: InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1)), filled: true, fillColor: Colors.white)),
                    SizedBox(height: 10),
                    TextField(controller: _addressController, decoration: InputDecoration(labelText: 'Address', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1)), filled: true, fillColor: Colors.white)),
                    SizedBox(height: 10),
                    TextField(controller: _cityController, decoration: InputDecoration(labelText: 'City', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1)), filled: true, fillColor: Colors.white)),
                    SizedBox(height: 10),
                    TextField(controller: _postalCodeController, decoration: InputDecoration(labelText: 'Postal Code', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1)), filled: true, fillColor: Colors.white)),
                    SizedBox(height: 20),
                  ],
                  ElevatedButton(onPressed: () => _createAccount(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),)), child: Text('Sign Up', style: TextStyle(color: Colors.blue))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
