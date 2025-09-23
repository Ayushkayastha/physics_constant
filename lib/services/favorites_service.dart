import 'package:hive_flutter/hive_flutter.dart';
import '../models/constant_model.dart';

class FavoritesService {
  static const String boxName = "favorites";

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Box get _box => Hive.box(boxName);

  static List<ConstantModel> getFavorites() {
    final List stored = _box.values.toList();
    return stored.map((e) => ConstantModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  static void toggleFavorite(ConstantModel constant) {
    final existing = getFavorites();
    if (existing.any((c) => c.symbol == constant.symbol)) {
      // remove
      final key = _box.keys.firstWhere((k) =>
      Map<String, dynamic>.from(_box.get(k))['symbol'] == constant.symbol);
      _box.delete(key);
    } else {
      // add
      _box.add(constant.toJson());
    }
  }

  static bool isFavorite(ConstantModel constant) {
    return getFavorites().any((c) => c.symbol == constant.symbol);
  }
}
