import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/constant_model.dart';
import '../providers/favorites_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> constantsData;
  const SearchPage({super.key, required this.constantsData});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final favNotifier = ref.watch(favoritesProvider.notifier);
    final favoriteState = ref.watch(favoritesProvider);

    final allConstants = widget.constantsData.values
        .expand((list) => List<Map<String, dynamic>>.from(list))
        .map((e) => ConstantModel.fromJson(e))
        .toList();

    final results = allConstants
        .where((c) =>
    c.name.toLowerCase().contains(query.toLowerCase()) ||
        c.symbol.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search constant...",
                fillColor: Colors.white10,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(
                child: Text("No results",
                    style: TextStyle(color: Colors.white70)))
                : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final constant = results[index];
                final isFav = favoriteState
                    .any((c) => c.symbol == constant.symbol);

                return Card(
                  color: const Color(0xFF1B263B),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
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
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    title: Text(constant.name,
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text(constant.value,
                        style: const TextStyle(color: Colors.white70)),
                    trailing: IconButton(
                      icon: Icon(
                        isFav ? Icons.star : Icons.star_border,
                        color:
                        isFav ? Colors.yellow : Colors.white70,
                      ),
                      onPressed: () =>
                          favNotifier.toggle(constant),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
