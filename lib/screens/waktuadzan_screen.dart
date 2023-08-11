import 'package:flutter/material.dart';
import 'package:quran_app/models/adzan_model.dart';
import 'package:quran_app/utils/export_utils.dart';
import 'package:quran_app/widgets/notificationalert_widgets.dart';

import '../repositories/export_repo.dart';

class WaktuAdzanScreen extends StatelessWidget {
  const WaktuAdzanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<AdzanModel>>(
      future: QuranSurah().getWaktuAdzan(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          String timeNow = DateFormat('MMMM', 'id_ID').format(DateTime.now());

          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 8.h,
                  backgroundColor: AppColors.scafoldBackgroundColor,
                  actions: [
                    IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/searchSurah'),
                        icon: const Icon(Icons.search)),
                  ],
                ),
                SliverPersistentHeader(
                    pinned: true, delegate: SliverHeaderWaktuAdzanWidget()),
                SliverToBoxAdapter(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 5.0.h),
                  child: Text(
                    "Semua Waktu Adzan di Bulan $timeNow",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                )),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: snapshot.data!.length,
                  (context, index) {
                    String timeAdzan =
                        DateFormat('y-MM-dd').format(DateTime.now());
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ListTile(
                        minVerticalPadding: 15.h,
                        onTap: () => NotificationAlertsWidget(
                                title:
                                    "Tanggal : ${snapshot.data?[index].tanggal}")
                            .showNotificationAlertsAdzanWidget(
                                context,
                                "Waktu Imsyak : ${snapshot.data?[index].imsyak}",
                                "Waktu Shubuh : ${snapshot.data?[index].shubuh}",
                                "Waktu Dhuha : ${snapshot.data?[index].dhuha}",
                                "Waktu Dzuhur : ${snapshot.data?[index].dzuhur}",
                                "Waktu Ashr : ${snapshot.data?[index].ashr}",
                                "Waktu Maghrib : ${snapshot.data?[index].magrib}",
                                "Waktu Isya ${snapshot.data?[index].isya}"),
                        title:
                            Text("Tanggal : ${snapshot.data![index].tanggal}"),
                        tileColor: snapshot.data![index].tanggal == timeAdzan
                            ? Colors.white
                            : AppColors.scafoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        horizontalTitleGap: 3.0,
                        leading: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0.h, horizontal: 17.0.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0.h),
                              color: AppColors.appbarBackgroundColor),
                          child: Text("${index + 1}"),
                        ),
                      ),
                    );
                  },
                ))
              ],
            ),
          );
        } else {
          return const Text("Theres Something Wrong");
        }
      },
    ));
  }
}

class SliverHeaderWaktuAdzanWidget extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtent,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      margin: const EdgeInsets.all(20.0),
      padding: EdgeInsets.all(10.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LineIcons.calendarTimes, color: Colors.green, size: 30.0.h),
          SizedBox(width: 10.0.w),
          Text(
            "Waktu Adzan",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 100.h;

  @override
  double get minExtent => 90.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
