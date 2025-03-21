import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'tutorial_screen.dart';
import 'main_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings'); 
  await Hive.openBox('plants'); 
  await Hive.openBox('bookmarks'); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: _getInitialScreen(),
    );
  }

  Widget _getInitialScreen() {
    final settingsBox = Hive.box('settings');
    final tutorialShown = settingsBox.get('tutorialShown', defaultValue: false);

    return tutorialShown ? MainScreen() : TutorialScreen();
  }
}
