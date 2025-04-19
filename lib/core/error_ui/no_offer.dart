import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../app_managers/assets_managers.dart';

class NoOffer extends StatefulWidget {
  final VoidCallback? onRetry;

  const NoOffer({super.key, this.onRetry});

  @override
  State<NoOffer> createState() => _NoOfferState();
}

class _NoOfferState extends State<NoOffer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Image(
            //   width:200,
            //   image: AssetImage(
            //     AssetManager.noOffer,
            //   ),
            //   fit: BoxFit.cover,
            // ),
            const Gap(12),
            const Text(
              'No current offer available',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF42526D),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please visit again to know if offer is available or not. ',
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
