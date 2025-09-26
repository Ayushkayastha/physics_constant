import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants_detail_page.dart';
import 'favorites_page.dart';
import 'search_page.dart';
import '../models/constant_model.dart';

class HomePagePage extends StatefulWidget {
  final Map<String, dynamic> constantsData;
  const HomePagePage({super.key, required this.constantsData});

  @override
  State<HomePagePage> createState() => _HomePagePageState();
}

class _HomePagePageState extends State<HomePagePage> {
  int _selectedIndex = 0;

  // Example formulas JSON
  final Map<String, List<Map<String, dynamic>>> formulas = {
    "Newton's Laws": [
      {"name": "First Law", "symbol": "F=0", "value": "Body in motion remains in motion"},
      {"name": "Second Law", "symbol": "F=ma", "value": "Force equals mass × acceleration"},
      {"name": "Third Law", "symbol": "F=-F", "value": "Action = Reaction"},
    ],
    "Work-Energy Theorem": [
      {"name": "Work-Energy", "symbol": "W=ΔK", "value": "Work done = change in kinetic energy"}
    ],
    "E=mc²": [
      {"name": "Mass-Energy Equivalence", "symbol": "E=mc²", "value": "Energy equals mass times speed of light squared"}
    ]
  };

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomeTab(),
      const FavoritesPage(),
      SearchPage(constantsData: widget.constantsData),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0D1B2A),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Saved"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Physics Hub',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _selectedIndex = 2),
                icon: const Icon(Icons.search, color: Colors.white, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Constants Section
          _buildSectionHeader('Constants'),
          const SizedBox(height: 16),
          _buildCategoryCards(widget.constantsData),

          const SizedBox(height: 32),

          // Formulas Section
          _buildSectionHeader('Formulas'),
          const SizedBox(height: 16),
          _buildFormulaCards(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {
            final data = title == 'Constants' ? widget.constantsData : formulas;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ConstantsDetailPage(
                  category: title, // pass the section title
                  constants: data.values
                      .expand((list) => List<Map<String, dynamic>>.from(list))
                      .toList(), // merge all categories into one list
                ),
              ),
            );
          },
          child: const Text(
            'See All',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCards(Map<String, dynamic> data) {
    final categories = data.keys.toList();

    return Column(
      children: categories.take(4).map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildCard(
            icon: Icons.calculate,
            title: category,
            color: Colors.blueAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConstantsDetailPage(
                    category: category,
                    constants: List<Map<String, dynamic>>.from(data[category]),
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }


  Widget _buildFormulaCards() {
    final categories = formulas.keys.toList();

    return Column(
      children: categories.take(4).map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildCard(
            icon: Icons.science,
            title: category,
            color: Colors.greenAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConstantsDetailPage(
                    category: category,
                    constants: List<Map<String, dynamic>>.from(formulas[category]!),
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
  Widget _buildCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1B263B),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

}
