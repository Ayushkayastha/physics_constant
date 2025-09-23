import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorites_provider.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favNotifier = ref.watch(favoritesProvider.notifier);
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
          title: const Text("Favorites"),
        backgroundColor:const Color(0xFF0D1B2A),
      ),
      body: favorites.isEmpty
          ? const Center(
          child: Text("No favorites yet",
              style: TextStyle(color: Colors.white70)))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final constant = favorites[index];
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
                icon: const Icon(Icons.star, color: Colors.yellow),
                onPressed: () => favNotifier.toggle(constant),
              ),
            ),
          );
        },
      ),
    );
  }
}
