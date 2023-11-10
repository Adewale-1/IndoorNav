import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:indoornav/Screens/MapScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:indoornav/Screens/CameraScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Allows container transitioning
  final PageController _pageController = PageController();

  Widget _buildInfoButton(String title) {
    return ElevatedButton(
      onPressed: () {
        // Add the action for the button here
      },
      child: Text(title),
    );
  }

  final List<Color> _colors = [
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.amber,
  ];
  final List<String> _feelings = [
    'Bolz Hall',
    'Dreese Lab',
    'Hitchcock Hall',
    'Smith Lab',
  ];
  final List<String> _pictures = [
    'bolz.png',
    'dreeselab.jpg',
    'hitchcock.png',
    'smithlab.png',
  ];

  void _Capture() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('lib/Assets/brutus.jpeg'),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeIn(
                                  duration: const Duration(milliseconds: 900),
                                  delay: const Duration(milliseconds: 250),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width: 200,
                                    height: 20,
                                    // color: Colors.yellow,
                                    child: Text(
                                      'Welcome',
                                      style: GoogleFonts.lexend(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                FadeIn(
                                  duration: const Duration(milliseconds: 1600),
                                  delay: const Duration(milliseconds: 600),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width: 200,
                                    height: 20,
                                    // color: Colors.blue,
                                    child: Text(
                                      'Brutus',
                                      style: GoogleFonts.lexend(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[500],
                        ),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center, // add this line
                    child: Text(
                      "Let's know where you are",
                      style: GoogleFonts.lexend(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // Other card list
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            print("Capture Screen");
                            _Capture();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: _colors[index],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    'lib/Assets/${_pictures[index]}',
                                    fit: BoxFit
                                        .cover, // fill the entire space while maintaining aspect ratio
                                  ),
                                  Center(
                                    // Center widget to center the Text
                                    child: Text(
                                      _feelings[index],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: _colors.length,
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _colors.length,
                    effect: const JumpingDotEffect(
                      radius: 16,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft, // add this line
                    child: Text(
                      "Can't find building above, check below...",
                      style: GoogleFonts.lexend(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Container for bottom List
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[300],
                    ),
                    child: ListView(
                      reverse: true, // To make the list scroll upwards
                      children: <Widget>[
                        _buildInfoButton("Scot Laboratory"),
                        _buildInfoButton("Baker Systems Engineering"),
                        _buildInfoButton("Caldwell Laboratory"),
                        _buildInfoButton("Ohio Union"),
                        _buildInfoButton("Derby Hall"),
                        _buildInfoButton("Eighteenth Avenue Library"),
                        _buildInfoButton("Evans Laboratory"),
                        _buildInfoButton("Hargerty Hall"),
                        _buildInfoButton("Mathematics Tower"),
                        _buildInfoButton("McPherson Chemical Laboratory"),
                        _buildInfoButton("Ohio Stadium"),
                        _buildInfoButton("Page Hall"),
                        // Add more buttons as needed
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
