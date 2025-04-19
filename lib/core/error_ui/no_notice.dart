import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../app_managers/assets_managers.dart';

class NoNotice extends StatefulWidget {
  final VoidCallback? onRetry;

  const NoNotice({super.key, this.onRetry});

  @override
  State<NoNotice> createState() => _NoNoticeState();
}

class _NoNoticeState extends State<NoNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Image(
            //   width:200,
            //   // image: AssetImage(
            //   //   // AssetManager.noNotice,
            //   // ),
            //   fit: BoxFit.cover,
            // ),
            const Gap(22),
            const Text(
              ' No Notice ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF42526D),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please visit again to know if notice is available ',
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
