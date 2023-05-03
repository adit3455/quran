import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/blocs/export_blocs.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/services/audioplay_service.dart';
import 'package:quran_app/utils/export_utils.dart';
import 'package:quran_app/widgets/export_widgets.dart';

import '../repositories/export_repo.dart';

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
                                      "${snapshot.data!.tempatTurun!.replaceFirst(snapshot.data!.tempatTurun![0], snapshot.data!.tempatTurun![0].toUpperCase())}, ${snapshot.data!.arti}, ${snapshot.data!.jumlahAyat} Ayat",
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
              BlocProvider(
                create: (context) => AudioSurahBloc(AudioPlayerService(),
                    AudioPlayer(), snapshot.data!.audio.toString())
                  ..add(Start()),
                child: BlocConsumer<AudioSurahBloc, AudioSurahState>(
                  listener: (context, state) {
                    if (state is AudioSurahError) {}
                  },
                  builder: (context, state) {
                    if (state is AudioSurahLoading) {
                      return const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (state is AudioSurahCompleted) {
                      return ButtonAudioController(
                          onPressed: () {
                            context.read<AudioSurahBloc>().add(Play());
                          },
                          positionStream: Duration.zero,
                          durationStream: state.duration);
                    } else if (state is AudioSurahPlayed) {
                      return ButtonAudioController(
                          isFalse: false,
                          onSeek: (value) =>
                              context.read<AudioSurahBloc>().add(OnSeek(value)),
                          onPressed: () =>
                              context.read<AudioSurahBloc>().add(Paused()),
                          positionStream: state.positionStream,
                          durationStream: state.durationStream);
                    } else if (state is AudioSurahPaused) {
                      return ButtonAudioController(
                          onPressed: () =>
                              context.read<AudioSurahBloc>().add(Resumed()),
                          positionStream: state.positionStream,
                          durationStream: state.durationStream);
                    }
                    return const SliverToBoxAdapter(
                        child: Text("Theres Something Wrong"));
                  },
                ),
              ),
              BlocBuilder<TextSizeAlquranBloc, TextSizeAlquranState>(
                builder: (context, state) {
                  final valueState = (state as TextSizeAlquran);

                  return SliverList(
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
                                  child: Text(
                                      "${snapshot.data!.ayat![index].ar}",
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: valueState
                                                          .selectedValue ==
                                                      'kecil'
                                                  ? valueState.value
                                                  : valueState.selectedValue ==
                                                          'normal'
                                                      ? valueState.value
                                                      : valueState.value)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context.read<BookmarksBloc>().add(
                                          AddBookmarks(
                                              ayat:
                                                  snapshot.data!.ayat![index]));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              duration:
                                                  const Duration(seconds: 1),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              padding: EdgeInsets.all(5.h),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 5.w),
                                              elevation: 2,
                                              showCloseIcon: true,
                                              backgroundColor:
                                                  AppColors.cardBackgroundColor,
                                              content: Text(
                                                  "Menambahkan ke Bookmark",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium)));
                                    },
                                    icon: const Icon(
                                      Icons.bookmark_add_outlined,
                                      color: AppColors.cardBackgroundColor,
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(10.0),
                                    width: 290.w,
                                    child: Text(
                                        "${snapshot.data!.ayat![index].tr}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: valueState
                                                            .selectedValue ==
                                                        'kecil'
                                                    ? valueState.value
                                                    : valueState.selectedValue ==
                                                            'normal'
                                                        ? valueState.value
                                                        : valueState.value))),
                              ],
                            ),
                            Container(
                                padding: const EdgeInsets.all(3.0),
                                width: 290.w,
                                child: Text(
                                    "${snapshot.data!.ayat![index].idn}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: valueState
                                                        .selectedValue ==
                                                    'kecil'
                                                ? valueState.value
                                                : valueState.selectedValue ==
                                                        'normal'
                                                    ? valueState.value
                                                    : valueState.value))),
                            SizedBox(height: 5.0.h),
                            const Divider(
                                thickness: 1,
                                color: AppColors.cardBackgroundColor)
                          ],
                        ),
                      );
                    },
                  ));
                },
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
