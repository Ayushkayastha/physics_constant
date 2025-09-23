import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const _favoritesBox = 'favorites';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_favoritesBox);
  }
}
