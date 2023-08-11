import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app/config/export_configs.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/repositories/export_repo.dart';
import 'package:quran_app/services/localstoragerepo.dart';
import 'package:quran_app/services/notification_service.dart';
import 'blocs/export_blocs.dart';
import 'utils/export_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(AyatAdapter());

  await initializeDateFormatting('id_ID').then((value) => runApp(ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => BookmarksBloc(
                        localStorageRepository: LocalStorageRepository())
                      ..add(StartBookmarks())),
                BlocProvider(create: (context) => TextSizeAlquranBloc()),
                BlocProvider(
                    create: (context) => AdzanTimeBloc(
                        adzanConfig: AdzanConfig(),
                        notificationService: NotificationService(),
                        quranSurah: QuranSurah())
                      ..add(const InitAdzanTime())),
                BlocProvider(create: (context) => NotificationChangerBloc()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeUtils.lightTheme,
                onGenerateRoute: AppNavigationConfig.onGenerateRoute,
                initialRoute: '/',
              ));
        },
      )));
}
