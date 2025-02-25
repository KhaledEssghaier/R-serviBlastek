import 'package:flutter/material.dart';


class AdminDashboard extends StatelessWidget {
  // Simulate user query logic


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Future.value([]), // Simulate an empty user list

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text('${user['first_name']} ${user['last_name']}'),
                  subtitle: Text('Email: ${user['email']}'),
                  trailing:
                      Text(user['role'] ?? 'Client'), // Assuming role is stored
                );
              },
            );
          }
        },
      ),
    );
  }
}
