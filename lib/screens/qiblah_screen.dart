import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/utils/export_utils.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';

class QiblahScreen extends StatelessWidget {
  const QiblahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/bookmarks'),
              icon: const Icon(Icons.bookmark, color: Colors.white)),
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/setting'),
              icon: const Icon(Icons.settings, color: Colors.white)),
        ],
      ),
      body: Center(
          child: SmoothCompass(
        height: 250.h,
        width: 280.w,
        isQiblahCompass: true,
        compassBuilder: (context, snapshot, child) {
          return SizedBox(
            height: 280.h,
            width: 280.w,
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 800),
              turns: snapshot?.data?.turns ?? 0,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SvgPicture.asset(
                        'assets/svg/compass.svg',
                        fit: BoxFit.cover,
                      )),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedRotation(
                        duration: const Duration(milliseconds: 500),
                        turns: (snapshot?.data?.qiblahOffset ?? 0) / 360,
                        //Place your qiblah needle here
                        child: SvgPicture.asset(
                          'assets/svg/needle.svg',
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
