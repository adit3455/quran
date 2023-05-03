import 'package:flutter/material.dart';
import 'package:quran_app/models/export_models.dart';
import 'package:quran_app/screens/export_screens.dart';

class AppNavigationConfig {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (context) => const HomePage());
      case '/alldoa':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/alldoa'),
            builder: (context) => const AllDoaScreen());
      case '/allfeed':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/allfeed'),
            builder: (context) => const AllFeedScreen());
      case '/allsurah':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/allsurah'),
            builder: (context) => const AllSurahScreen());
      case '/bookmarks':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/bookmarks'),
            builder: (context) => const BookmarksScreen());
      case '/dziarah':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/dziarah'),
            builder: (context) => const DziarahScreen());
      case '/feedDetail':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/feedDetail'),
            builder: (context) =>
                FeedDetailScreen(articles: settings.arguments as Articles));
      case '/qiblah':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/qiblah'),
            builder: (context) => const QiblahScreen());
      case '/searchSurah':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/searchSurah'),
            builder: (context) => SearchQuranScreen());
      case '/surahDetail':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/surahDetail'),
            builder: (context) =>
                SurahDetailScreen(index: settings.arguments as int));
      case '/waktuAdzan':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/waktuAdzan'),
            builder: (context) => const WaktuAdzanScreen());
      case '/yasin':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/yasin'),
            builder: (context) => const YasinScreen());
      case '/setting':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/setting'),
            builder: (context) => const SettingScreen());

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(title: const Text("Error Screen")),
              body: const Center(child: Text("Theres Something Wrong")),
            ));
  }
}
