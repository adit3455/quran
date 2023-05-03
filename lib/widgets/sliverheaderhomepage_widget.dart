import 'package:flutter/material.dart';
import 'package:quran_app/screens/export_screens.dart';
import 'package:quran_app/utils/export_utils.dart';

class SliverHeaderHomePageWidget extends StatelessWidget {
  const SliverHeaderHomePageWidget({
    super.key,
    required this.maxExtent,
  });

  final double maxExtent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxExtent,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Wrap(spacing: 25.w, children: [
          Material(
            borderRadius: BorderRadius.circular(20.0.w),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0.w),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllSurahScreen(),
                    ));
              },
              child: Column(
                children: [
                  Icon(
                    LineIcons.quran,
                    color: Colors.green,
                    size: 35.0.h,
                  ),
                  const Text("Al-Qur'an")
                ],
              ),
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(20.0.w),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0.w),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AllDoaScreen()));
              },
              child: Column(
                children: [
                  Icon(
                    LineIcons.prayingHands,
                    color: Colors.green,
                    size: 35.0.h,
                  ),
                  const Text("Do'a")
                ],
              ),
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(20.0.w),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0.w),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WaktuAdzanScreen()));
              },
              child: Column(
                children: [
                  Icon(
                    LineIcons.calendarTimes,
                    color: Colors.green,
                    size: 35.0.h,
                  ),
                  const Text("Waktu Adzan")
                ],
              ),
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(20.0.w),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0.w),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DziarahScreen()));
              },
              child: Column(
                children: [
                  Icon(
                    LineIcons.pray,
                    color: Colors.green,
                    size: 35.0.h,
                  ),
                  const Text("Dziarah")
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class SliverHeaderHomePage extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SliverHeaderHomePageWidget(maxExtent: maxExtent);
  }

  @override
  double get maxExtent => 100.h;

  @override
  double get minExtent => 80.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
