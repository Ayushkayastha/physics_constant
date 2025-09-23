import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'constants_detail_page.dart';
import 'favorites_page.dart';
import 'search_page.dart';

class PhysicsConstantsPage extends StatefulWidget {
  const PhysicsConstantsPage({super.key});

  @override
  State<PhysicsConstantsPage> createState() => _PhysicsConstantsPageState();
}

class _PhysicsConstantsPageState extends State<PhysicsConstantsPage> {
  Map<String, dynamic> constantsData = {};
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response =
    await rootBundle.loadString('assets/constants_data.json');
    final data = json.decode(response);
    setState(() {
      constantsData = data;
    });
  }

  Widget _buildTopicsPage() {
    return ListView(
      children: constantsData.keys.map<Widget>((category) {
        return Column(
          children: [
            ListTile(
              title: Text(
                category,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white70),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ConstantsDetailPage(
                      category: category,
                      constants: List<Map<String, dynamic>>.from(constantsData[category]),
                    ),
                  ),
                );
              },
            ),
            const Divider(color: Colors.white12, height: 1),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (constantsData.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final pages = [
      _buildTopicsPage(),
      const FavoritesPage(),
      SearchPage(constantsData: constantsData),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0D1B2A),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.science), label: "Topics"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        ],
      ),
    );
  }
}
