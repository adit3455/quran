import 'package:flutter/material.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/utils/export_utils.dart';

import '../blocs/export_blocs.dart';
import '../repositories/export_repo.dart';
import '../widgets/export_widgets.dart';
import 'export_screens.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // String timeNow = DateFormat('kk:mm', 'id_ID').format(DateTime.now());
    // String timeAdzan = DateFormat('y-MM-dd').format(DateTime.now());
    // final timeNowWithoutSymbol = timeNow.replaceAll(':', '');
    // final timeNowparsing = int.parse(timeNowWithoutSymbol);

    return Scaffold(
        body: FutureBuilder<FeedModel>(
      future: QuranSurah().getFeed(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 0.h,
                toolbarHeight: 0.h,
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 225.h,
                  width: double.infinity,
                  color: AppColors.appbarBackgroundColor,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 100.h,
                        width: double.infinity,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 18.0.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Assalamu'alaikum, Sahabat",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontSize: 22.0,
                                                color: Colors.white),
                                      ),
                                      Text(
                                        DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                            .format(DateTime.now()),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, '/setting'),
                                    icon: const Icon(Icons.settings)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18.w,
                        top: 100.h,
                        child: Container(
                          width: 325.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppColors.cardBackgroundColor),
                          child: Padding(
                            padding: EdgeInsets.all(10.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BlocBuilder<AdzanTimeBloc, AdzanTimeState>(
                                  builder: (context, state) {
                                    // print(timeNowparsing);
                                    // print(timeNow);
                                    // context.read<AdzanTimeBloc>().add(
                                    //     GetAdzanTime(
                                    //         timeNowparsing, timeAdzan));
                                    if (state is AdzanTimeLoading) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    if (state is AdzanTimeStarted) {
                                      String strDigits(int n) =>
                                          n.toString().padLeft(2, '0');

                                      final hours = strDigits(state
                                          .adzanTime.inHours
                                          .remainder(24));
                                      final minutes = strDigits(state
                                          .adzanTime.inMinutes
                                          .remainder(60));
                                      final seconds = strDigits(state
                                          .adzanTime.inSeconds
                                          .remainder(60));

                                      final hourLock = strDigits(state
                                          .adzanTimeLock.inHours
                                          .remainder(24));
                                      final minuteLock = strDigits(state
                                          .adzanTimeLock.inMinutes
                                          .remainder(60));

                                      return Padding(
                                        padding: EdgeInsets.only(top: 15.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${state.adzanName} $hourLock:$minuteLock WIB",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                            ),
                                            Text(
                                              "$hours:$minutes:$seconds Menjelang Adzan",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    if (state is AdzanTimeChanged) {
                                      String strDigits(int n) =>
                                          n.toString().padLeft(2, '0');

                                      final hours = strDigits(state
                                          .adzanTime.inHours
                                          .remainder(24));
                                      final minutes = strDigits(state
                                          .adzanTime.inMinutes
                                          .remainder(60));
                                      final seconds = strDigits(state
                                          .adzanTime.inSeconds
                                          .remainder(60));

                                      final hourLock = strDigits(state
                                          .adzanTimeLock.inHours
                                          .remainder(24));
                                      final minuteLock = strDigits(state
                                          .adzanTimeLock.inMinutes
                                          .remainder(60));

                                      return Padding(
                                        padding: EdgeInsets.only(top: 15.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${state.adzanName} $hourLock:$minuteLock WIB",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                            ),
                                            Text(
                                              "$hours:$minutes:$seconds Menjelang Adzan",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    return Text(
                                      "Theres Something Wrong",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.white),
                                    );
                                  },
                                ),
                                InkWell(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/qiblah'),
                                  child: CircleAvatar(
                                    maxRadius: 30.h,
                                    backgroundImage: const NetworkImage(
                                        "https://riaupos.co/thumb/2867-13950133625_d490cfefe3_z.jpg"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 205.h,
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
              SliverPersistentHeader(
                delegate: SliverHeaderHomePage(),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Feed Untukmu"),
                          TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/allfeed'),
                              child: const Text("Lihat Semua"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 7,
                  (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedDetailScreen(
                                      articles: snapshot.data!.articles![index],
                                    )));
                      },
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 5.0.h),
                        child: Text(
                          "${snapshot.data!.articles![index].title}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      subtitle: Text(
                          "${snapshot.data!.articles![index].publishedAt}",
                          style: Theme.of(context).textTheme.bodyMedium),
                      trailing: Image.network(
                          fit: BoxFit.cover,
                          width: 120.w,
                          "${snapshot.data!.articles![index].urlToImage}"),
                    );
                  },
                ),
              )
            ],
          );
        } else {
          return const Text("Theres Something Wrong");
        }
      },
    ));
  }
}
