import 'package:flutter/material.dart';
//import '/screen/admin/admin_logic.dart';
import '/screen/auth/login/login_view.dart';
import '/screen/auth/register/register_view.dart';
import '/screen/shop_home/shop_home_view.dart';
//import '/screen/auth/register/register_view.dart';

import '../core/app_managers/assets_managers.dart';
//import 'admin/admin_view.dart';
//import '../screen/shop_home/shop_home_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with
        TickerProviderStateMixin //Provides a Ticker for animations.In Flutter, a Ticker is a utility that generates a stream of time ticks or frames. It is used to drive animations by providing a regular update callback, typically on each frame of the animation.
{
  // Changed from SingleTickerProviderStateMixin to TickerProviderStateMixin
  late AnimationController _imageController;
  late AnimationController _textController; // Controllers to manage animations.
  late Animation<double>
      _rotationAnimation; //Definitions for rotation, translation, and text appearance animations.
  late Animation<double> _translationAnimation;
  late Animation<double> _textAnimation; // For text letter animation
  late List<String> _textList; // List to hold letters of the text

  @override
  void initState() {
    super.initState();

//Manages image animation (2 seconds duration).
    _imageController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Rotation animation: full circle rotation
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(_imageController);

    // Translation animation: from left (-1.0) to center (0.0)
    _translationAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeInOut,
    ));

    // Start the image animation
    _imageController.forward().then((_) {
      // Once the image animation completes, start the text animation
      _startTextAnimation();
    });

    // Create the second animation controller for the text
    _textController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Text letter-by-letter animation
    _textList =
        'Easy  Shopping'.split(''); // Split text into individual letters
    _textAnimation = Tween<double>(
      begin: 0,
      end: _textList.length.toDouble(),
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    _textController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const LoginPage()) // Replace with your actual homepage widget
            );
      }
    });
  }

  void _startTextAnimation() {
    //Begins the text animation once the image animation is complete.
    _textController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
//Gets screen width to adjust translation.
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated image
            AnimatedBuilder(
              //Rebuilds UI based on animation values.
              animation: _imageController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_translationAnimation.value * screenWidth, 0),
                  child: Transform.rotate(
                    // Rotates the image.
                    angle: _rotationAnimation.value,
                    child: SizedBox(
                      //Defines the size of the image.
                      width: 100,
                      height: 100,
                      child: Image.asset(AssetManager.Zippro),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20), // Space between image and text
            // Animated text
            AnimatedBuilder(
              // Shows letters one by one based on animation value.
              animation: _textController,
              builder: (context, child) {
                final visibleLetterCount = _textAnimation.value.toInt();
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    _textList.length,
                    (index) {
                      if (index < visibleLetterCount) {
                        return Text(
                          _textList[index],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return SizedBox.shrink(); // Hide remaining letters
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //Cleans up animation controllers when no longer needed to prevent memory leaks.
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }
}
