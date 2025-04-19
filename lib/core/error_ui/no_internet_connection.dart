import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../app_managers/assets_managers.dart';

class NoInternetConnection extends StatefulWidget {
  final VoidCallback? onRetry;

  const NoInternetConnection({super.key, this.onRetry});

  @override
  State<NoInternetConnection> createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Image(
            //   width:300,
            //   image: AssetImage(
            //     AssetManager.noConnection,
            //   ),
            //   fit: BoxFit.cover,
            // ),
            const Text(
              'No internet connection',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF42526D),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please check your internet \nconnection',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF4A4A4A),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Gap(12),
            OutlinedButton(
                onPressed: () {
                  widget.onRetry!();
                },
                child: const Text("Retry"))
          ],
        ),
      ),
    );
  }
}
