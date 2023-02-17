import 'package:flutter/material.dart';
import 'package:quran_app/models/adzan_model.dart';
import 'package:quran_app/repositories/base_repo.dart';
import 'package:quran_app/utils/export_utils.dart';

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
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 8.h,
                backgroundColor: AppColors.scafoldBackgroundColor,
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                ],
              ),
              SliverPersistentHeader(
                  pinned: true, delegate: SliverHeaderWaktuAdzanWidget()),
              SliverToBoxAdapter(
                  child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 5.0.h),
                child: Text(
                  "Semua Waktu Adzan di Bulan Februari",
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
                  return ListTile(
                    minVerticalPadding: 15.h,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                                child: Container(
                                    width: 320.w,
                                    padding: EdgeInsets.all(8.0.h),
                                    decoration: BoxDecoration(
                                        color: AppColors.scafoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                AppColors.cardBackgroundColor)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                            child: Text(
                                          "Tanggal : Sabtu, ${snapshot.data![index].tanggal}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        )),
                                        const SizedBox(height: 20.0),
                                        const SizedBox(height: 15.0),
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "Waktu Imsyak : ${snapshot.data![index].imsyak}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            )),
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "Waktu Shubuh : ${snapshot.data![index].shubuh}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            )),
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "Waktu Dhuha : ${snapshot.data![index].dhuha}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            )),
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "Waktu Dzuhur : ${snapshot.data![index].dzuhur}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            )),
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "Waktu Ashr : ${snapshot.data![index].ashr}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            )),
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "Waktu Maghrib : ${snapshot.data![index].magrib}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            )),
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "Waktu Isya : ${snapshot.data![index].isya}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            )),
                                        const SizedBox(height: 20.0),
                                        Center(
                                          child: TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("Back")),
                                        )
                                      ],
                                    )));
                          });
                    },
                    title: Text(
                        "Tanggal : Sabtu, ${snapshot.data![index].tanggal}"),
                    leading: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0.h, horizontal: 17.0.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0.h),
                          color: AppColors.appbarBackgroundColor),
                      child: Text("${index + 1}"),
                    ),
                  );
                },
              ))
            ],
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
