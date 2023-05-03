import 'package:flutter/material.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/repositories/export_repo.dart';
import 'package:quran_app/utils/export_utils.dart';

class YasinScreen extends StatelessWidget {
  const YasinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<YasinModel>>(
      future: QuranSurah().getYasin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            "Terjadi kesalahan. coba beberapa saat lagi..",
            style: Theme.of(context).textTheme.bodyLarge,
          ));
        } else if (snapshot.connectionState == ConnectionState.done) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 5.h,
                backgroundColor: AppColors.appbarBackgroundColor,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                pinned: true,
                actions: [
                  IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/bookmarks'),
                      icon: const Icon(Icons.bookmark, color: Colors.white)),
                  IconButton(
                      onPressed: () => Navigator.pushNamed(context, '/setting'),
                      icon: const Icon(Icons.settings, color: Colors.white)),
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                    color: AppColors.appbarBackgroundColor,
                    height: 140.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 5.h,
                          left: 20.w,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Yasin",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(color: Colors.white)),
                                const SizedBox(height: 5.0),
                                Container(
                                  padding: const EdgeInsets.all(3.0),
                                  width: 315.w,
                                  child: Text(
                                      "Surat Yasin adalah surat ke-36 dalam Al-Qur'an, 83 ayat, diturunkan di Mekkah.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: Colors.white)),
                                ),
                              ]),
                        ),
                        Positioned(
                          top: 100.h,
                          child: Container(
                            height: 40.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30.0)),
                                color: AppColors.scafoldBackgroundColor),
                          ),
                        ),
                      ],
                    )),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                childCount: snapshot.data?.length,
                (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(10.0.h)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0.w, horizontal: 10.h),
                                child: Text("${index + 1}")),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(3.0.h),
                              width: 285.w,
                              child: Text(snapshot.data![index].ayat,
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 43.0.w),
                            Container(
                                padding: const EdgeInsets.all(10.0),
                                width: 290.w,
                                child: Text(snapshot.data![index].latin,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium)),
                          ],
                        ),
                        Container(
                            padding: const EdgeInsets.all(3.0),
                            width: 290.w,
                            child: Text(snapshot.data![index].arti,
                                style: Theme.of(context).textTheme.bodyMedium)),
                        SizedBox(height: 5.0.h),
                        const Divider(
                            thickness: 1, color: AppColors.cardBackgroundColor)
                      ],
                    ),
                  );
                },
              ))
            ],
          );
        }
        return const Center(child: Text("Theres Something Wrong"));
      },
    ));
  }
}
