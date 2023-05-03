import 'package:flutter/material.dart';
import 'package:quran_app/utils/export_utils.dart';

import '../models/export_models.dart';

class DziarahScreen extends StatelessWidget {
  const DziarahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<DziarahModel> dziarah =
        listDziarah.map((data) => DziarahModel.fromJson(data)).toList();
    return Scaffold(
      body: CustomScrollView(
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
                  onPressed: () => Navigator.pushNamed(context, '/bookmarks'),
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
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                padding: const EdgeInsets.all(5.0),
                                child: const Icon(
                                  LineIcons.pray,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text("Dziarah",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(color: Colors.white)),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          Container(
                            width: 320.w,
                            padding: EdgeInsets.all(3.0.h),
                            child: Text("Tata Cara Membaca Do'a Ziarah Kubur",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
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
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30.0)),
                          color: AppColors.scafoldBackgroundColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: dziarah.length,
            (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 13.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Text("${index + 1}")),
                          SizedBox(width: 20.0.w),
                          Text(
                            dziarah[index].judul,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.all(3.0),
                              width: 320.w,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: dziarah[index]
                                      .ayat
                                      .map(
                                        (data) => Text(data,
                                            textAlign: TextAlign.end,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                      )
                                      .toList())),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(3.0),
                            width: 320.w,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: dziarah[index]
                                    .latin
                                    .map(
                                      (data) => Text(data,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    )
                                    .toList()),
                          ),
                        ],
                      ),
                    ]),
              );
            },
          )),
          SliverToBoxAdapter(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cardBackgroundColor),
                  onPressed: () => Navigator.pushNamed(context, '/yasin'),
                  child: const Text(
                    "Baca Yasin?",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
