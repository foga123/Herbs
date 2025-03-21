import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'bookmark_screen.dart';
import 'how_to_use_screen.dart';
import 'ailments_screen.dart';
import 'about_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    BookmarkScreen(),
    HowToUseScreen(),
    AilmentsScreen(),
    AboutScreen(),
  ];

  final List<String> _titles = [
    'HerbalApp',
    'Bookmarks',
    'How to Use',
    'Ailments',
    'About',
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  // void _navigateToAbout(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => AboutScreen()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Colors.green,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Bookmarks'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'How to Use'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), label: 'Ailments'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'About'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
