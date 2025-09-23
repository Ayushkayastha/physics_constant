import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/constant_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'favorites_provider.g.dart';

@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  static const _boxName = 'favorites';

  @override
  List<ConstantModel> build() {
    return _loadFavorites();
  }

  List<ConstantModel> _loadFavorites() {
    final box = Hive.box(_boxName);
    final stored = box.values.toList();
    return stored
        .map((e) => ConstantModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  void toggle(ConstantModel constant) {
    final box = Hive.box(_boxName);
    final current = state;

    if (current.any((c) => c.symbol == constant.symbol)) {
      final key = box.keys.firstWhere(
              (k) => Map<String, dynamic>.from(box.get(k))['symbol'] ==
              constant.symbol);
      box.delete(key);
      state = current.where((c) => c.symbol != constant.symbol).toList();
    } else {
      box.add(constant.toJson());
      state = [...current, constant];
    }
  }

  bool isFavorite(ConstantModel constant) {
    return state.any((c) => c.symbol == constant.symbol);
  }
}
