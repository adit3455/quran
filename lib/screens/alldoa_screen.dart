import 'package:flutter/material.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/utils/export_utils.dart';
import 'package:quran_app/widgets/notificationalert_widgets.dart';

import '../repositories/export_repo.dart';

class AllDoaScreen extends StatelessWidget {
  const AllDoaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<DoaModel>>(
      future: QuranSurah().getDoa(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 8.h,
                  backgroundColor: AppColors.scafoldBackgroundColor,
                  actions: [
                    IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/bookmarks'),
                        icon: const Icon(Icons.bookmark)),
                    IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/searchSurah'),
                        icon: const Icon(Icons.search)),
                  ],
                ),
                SliverPersistentHeader(
                    pinned: true, delegate: SliverHeaderAllDoaWidget()),
                SliverToBoxAdapter(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 5.0.h),
                  child: Text(
                    "Semua Do'a",
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
                        // doa ayat latin artinya
                        NotificationAlertsWidget(
                                title: "${snapshot.data?[index].doa}",
                                subTitle: "${snapshot.data?[index].ayat}",
                                content: "${snapshot.data?[index].latin}",
                                underContent:
                                    "${snapshot.data?[index].artinya}")
                            .showNotificationAlertsDoaWidget(context);
                      },
                      title: Text("${snapshot.data![index].doa}"),
                      leading: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0.h, horizontal: 17.0.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.h),
                            color: AppColors.appbarBackgroundColor),
                        child: Text("${snapshot.data![index].id}"),
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

class SliverHeaderAllDoaWidget extends SliverPersistentHeaderDelegate {
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
          Icon(LineIcons.prayingHands, color: Colors.green, size: 30.0.h),
          SizedBox(width: 10.0.w),
          Text(
            "Do'a",
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
