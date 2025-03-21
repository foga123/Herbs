import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'main_screen.dart';

String getAdjustedImagePath(String path) {
  String adjustedPath = kReleaseMode ? path.replaceFirst('../', '') : path;
  return adjustedPath;
}

class TutorialPage {
  final String title;
  final String description;
  final String imagePath;

  TutorialPage({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Box settingsBox;

  final List<TutorialPage> _pages = [
    TutorialPage(
      title: 'Welcome to HerbalApp',
      description:
          'Discover the healing power of nature with our collection of medicinal plants.',
      imagePath: '../assets/images/aloe_vera.jpg',
    ),
    TutorialPage(
      title: 'Explore Basil',
      description: 'Learn how basil can help with coughs and digestive issues.',
      imagePath: '../assets/images/basil.jpg',
    ),
    TutorialPage(
      title: 'Manage Diabetes with Ampalaya',
      description: 'Ampalaya is a traditional remedy for lowering blood sugar.',
      imagePath: '../assets/images/ampalaya.jpg',
    ),
    TutorialPage(
      title: 'Calm with Chamomile',
      description: 'Chamomile tea promotes relaxation and better sleep.',
      imagePath: '../assets/images/chamomile.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    settingsBox = Hive.box('settings');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      settingsBox.put('tutorialShown', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipTutorial() {
    settingsBox.put('tutorialShown', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      page.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Image.asset(
                      getAdjustedImagePath(page.imagePath),
                      height: 300,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.image_not_supported,
                                size: 100, color: Colors.grey),
                            Text('Image unavailable',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      page.description,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: 40,
            right: 16,
            child: TextButton(
              onPressed: _skipTutorial,
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: WormEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.green,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentPage == 0 ? null : _previousPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(_currentPage == _pages.length - 1
                      ? 'Get Started'
                      : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
