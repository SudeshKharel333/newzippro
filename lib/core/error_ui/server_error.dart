import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../app_managers/assets_managers.dart';
// import 'package:dyneum/core/app_managers/assets_managers.dart';

class ServerError extends StatefulWidget {
  final VoidCallback? onRetry;

  const ServerError({super.key, this.onRetry});

  @override
  State<ServerError> createState() => _ServerErrorState();
}

class _ServerErrorState extends State<ServerError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Image(
            //   width: 300,
            //   image: AssetImage(
            //     AssetManager.serverError,
            //   ),
            //   fit: BoxFit.cover,
            // ),
            const Text(
              'Oops!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF42526D),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Something went wrong\nplease try again',
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
