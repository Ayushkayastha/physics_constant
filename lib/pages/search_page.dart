import 'package:flutter/material.dart';
import '../models/constant_model.dart';

class SearchPage extends StatefulWidget {
  final Map<String, dynamic> constantsData;
  const SearchPage({super.key, required this.constantsData});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: Column(
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
                  return Card(
                    color: const Color(0xFF1B263B),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    child: ListTile(
                      title: Text(constant.name,
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text(constant.value,
                          style: const TextStyle(color: Colors.white70)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
