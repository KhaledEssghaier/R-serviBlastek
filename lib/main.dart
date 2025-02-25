import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'account_page.dart';
import 'create_account_page.dart';
import 'default_page.dart';
import 'admin_login_page.dart';
import 'admin_dashboard.dart';
import 'user_profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultPage(),
      routes: {
        '/account': (context) => AccountPage(),
        '/create_account': (context) => CreateAccountPage(),
        '/admin_login': (context) => AdminLoginPage(),
        '/admin_dashboard': (context) => AdminDashboard(),
        '/user_profile': (context) =>
            UserProfilePage(email: 'user@example.com'), // Placeholder for email
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ReservationScreen(),
    UserProfilePage(email: 'user@example.com'), // Placeholder for email
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/welcaompage.jpg'),
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
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 70, 175),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Réservi Blastek',
                            style: TextStyle(
                              fontSize: 40,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentIndex = -1; // Indicate profile view
                                });
                              },
                              child: Image.asset(
                                'assets/user.png',
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // This section will be removed when profile is active
                if (_currentIndex != -1) ...[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Image.asset('assets/search.png'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Search',
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],

                SizedBox(
                  height: MediaQuery.of(context).size.height - 240,
                  child: _screens[_currentIndex],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _currentIndex == -1
          ? Container(
              color: const Color.fromARGB(255, 0, 70, 175),
              child: Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              color: const Color.fromARGB(255, 0, 70, 175),
              child: BottomNavigationBar(
                backgroundColor: const Color.fromARGB(255, 0, 70, 175),
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/home.png')),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/event.png')),
                    label: 'Reservation',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/user.png')),
                    label: 'Profile',
                  ),
                ],
              ),
            ),

    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Screen.'),
    );
  }
}

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Reservation Screen'),
    );
  }
}

</create_file>
