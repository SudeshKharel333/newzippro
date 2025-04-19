import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';

class OnLoading extends StatefulWidget {
  const OnLoading({super.key});

  @override
  State<OnLoading> createState() => _OnLoadingState();
}

class _OnLoadingState extends State<OnLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  SpinKitThreeBounce(
            //   color: Colors.grey[300],
            //   size: 50,
            // ),
            const Gap(12),
            Text(
              'Loading data...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
