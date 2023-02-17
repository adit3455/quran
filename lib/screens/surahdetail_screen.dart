import 'package:flutter/material.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/repositories/base_repo.dart';
import 'package:quran_app/utils/export_utils.dart';

class SurahDetailScreen extends StatelessWidget {
  final int index;
  const SurahDetailScreen({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<QuranSurahDetailModel>(
      future: QuranSurah().getDetailSurah(index: index),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data?.arti);
          print(index);
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
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark, color: Colors.white)),
                  IconButton(
                      onPressed: () {},
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
                              Text("${snapshot.data!.namaLatin}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(color: Colors.white)),
                              const SizedBox(height: 5.0),
                              Container(
                                padding: const EdgeInsets.all(3.0),
                                width: 315.w,
                                child: Text(
                                    "${snapshot.data!.tempatTurun}, ${snapshot.data!.arti}, ${snapshot.data!.jumlahAyat} Ayat",
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
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                childCount: snapshot.data!.ayat!.length,
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
                                child: Text(
                                    "${snapshot.data!.ayat![index].nomor}")),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(3.0.h),
                              width: 285.w,
                              child: Text("${snapshot.data!.ayat![index].ar}",
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.bookmark_outline,
                                  color: AppColors.cardBackgroundColor,
                                )),
                            Container(
                                padding: const EdgeInsets.all(10.0),
                                width: 290.w,
                                child: Text("${snapshot.data!.ayat![index].tr}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium)),
                          ],
                        ),
                        Container(
                            padding: const EdgeInsets.all(3.0),
                            width: 290.w,
                            child: Text("${snapshot.data!.ayat![index].idn}",
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
        } else {
          return const Text("Theres Something Wrong");
        }
      },
    ));
  }
}
