import 'package:flutter/material.dart';

class ToolDetailPage extends StatelessWidget {
  final String toolName;

  const ToolDetailPage({super.key, required this.toolName});

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (toolName) {
      case "Thermal Conductivity":
        content = const ThermalConductivityPage();
        break;
      case "Coefficient of Elasticity":
        content = const ElasticityPage();
        break;
      case "Coefficient of Friction":
        content = const FrictionPage();
        break;
      default:
        content = const Center(child: Text("Tool not implemented yet"));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: Text(toolName),
        backgroundColor: const Color(0xFF0D1B2A),
      ),
      body: content,
    );
  }
}

// ---------------- Shared Styled Input Field ----------------
Widget buildInputField({
  required TextEditingController controller,
  required String label,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF1B263B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

// ---------------- Shared Styled Button ----------------
Widget buildCalcButton({required String text, required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
}

// ---------------- Tool Pages ----------------

// Thermal Conductivity Calculator
class ThermalConductivityPage extends StatefulWidget {
  const ThermalConductivityPage({super.key});

  @override
  State<ThermalConductivityPage> createState() =>
      _ThermalConductivityPageState();
}

class _ThermalConductivityPageState extends State<ThermalConductivityPage> {
  final heatCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();
  final areaCtrl = TextEditingController();
  final tempDiffCtrl = TextEditingController();
  double? result;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          buildInputField(controller: heatCtrl, label: "Heat Transfer (Q)"),
          buildInputField(controller: lengthCtrl, label: "Length (L)"),
          buildInputField(controller: areaCtrl, label: "Area (A)"),
          buildInputField(controller: tempDiffCtrl, label: "Temperature Difference (ΔT)"),
          const SizedBox(height: 20),
          buildCalcButton(
            text: "Calculate Thermal Conductivity",
            onPressed: () {
              final Q = double.tryParse(heatCtrl.text) ?? 0;
              final L = double.tryParse(lengthCtrl.text) ?? 1;
              final A = double.tryParse(areaCtrl.text) ?? 1;
              final dT = double.tryParse(tempDiffCtrl.text) ?? 1;

              setState(() {
                result = (Q * L) / (A * dT);
              });
            },
          ),
          if (result != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Thermal Conductivity = ${result!.toStringAsFixed(3)} W/mK",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Elasticity Calculator (Stress / Strain)
class ElasticityPage extends StatefulWidget {
  const ElasticityPage({super.key});

  @override
  State<ElasticityPage> createState() => _ElasticityPageState();
}

class _ElasticityPageState extends State<ElasticityPage> {
  final stressCtrl = TextEditingController();
  final strainCtrl = TextEditingController();
  double? result;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          buildInputField(controller: stressCtrl, label: "Stress (σ)"),
          buildInputField(controller: strainCtrl, label: "Strain (ε)"),
          const SizedBox(height: 20),
          buildCalcButton(
            text: "Calculate Elasticity (E)",
            onPressed: () {
              final stress = double.tryParse(stressCtrl.text) ?? 0;
              final strain = double.tryParse(strainCtrl.text) ?? 1;

              setState(() {
                result = stress / strain;
              });
            },
          ),
          if (result != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Elastic Modulus = ${result!.toStringAsFixed(3)} Pa",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Friction Calculator (Frictional Force / Normal Force)
class FrictionPage extends StatefulWidget {
  const FrictionPage({super.key});

  @override
  State<FrictionPage> createState() => _FrictionPageState();
}

class _FrictionPageState extends State<FrictionPage> {
  final frictionForceCtrl = TextEditingController();
  final normalForceCtrl = TextEditingController();
  double? result;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          buildInputField(controller: frictionForceCtrl, label: "Frictional Force (F)"),
          buildInputField(controller: normalForceCtrl, label: "Normal Force (N)"),
          const SizedBox(height: 20),
          buildCalcButton(
            text: "Calculate Coefficient of Friction (μ)",
            onPressed: () {
              final F = double.tryParse(frictionForceCtrl.text) ?? 0;
              final N = double.tryParse(normalForceCtrl.text) ?? 1;

              setState(() {
                result = F / N;
              });
            },
          ),
          if (result != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Coefficient of Friction = ${result!.toStringAsFixed(3)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
