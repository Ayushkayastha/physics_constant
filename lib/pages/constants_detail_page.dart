import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/constant_model.dart';
import '../providers/favorites_provider.dart';

class ConstantsDetailPage extends ConsumerWidget {
  final String category;
  final List<Map<String, dynamic>> constants;

  const ConstantsDetailPage({
    super.key,
    required this.category,
    required this.constants,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favNotifier = ref.watch(favoritesProvider.notifier);
    final favoriteState = ref.watch(favoritesProvider);

    final constantsList =
    constants.map((e) => ConstantModel.fromJson(e)).toList();

    return Scaffold(
      appBar: AppBar(
          title: Text(category),
        backgroundColor:const Color(0xFF0D1B2A),
      ),
      body: ListView.builder(
        itemCount: constantsList.length,
        itemBuilder: (context, index) {
          final constant = constantsList[index];
          final isFav =
          favoriteState.any((c) => c.symbol == constant.symbol);

          return Card(
            color: const Color(0xFF1B263B),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(constant.symbol,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              title: Text(constant.name,
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text(constant.value,
                  style: const TextStyle(color: Colors.white70)),
              trailing: IconButton(
                icon: Icon(
                  isFav ? Icons.star : Icons.star_border,
                  color: isFav ? Colors.yellow : Colors.white70,
                ),
                onPressed: () => favNotifier.toggle(constant),
              ),
            ),
          );
        },
      ),
    );
  }
}
