import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:front/src/rust/api/simple.dart';
import 'dart:math';

class OutcomePage extends StatefulWidget {
  const OutcomePage({Key? key}) : super(key: key);
  @override
  State<OutcomePage> createState() => _OutcomePageState();
}

class _OutcomePageState extends State<OutcomePage> {
  late Future<Map<String, double>> _getOutcomeData;

  @override
  void initState() {
    super.initState();
    _getOutcomeData = loadGetOutcomeData();
  }

  Future<Map<String, double>> loadGetOutcomeData() async {
    return await getOutcomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, double>>(
          future:
              _getOutcomeData, // Appel à la fonction Rust pour récupérer les données
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              final data = snapshot.data!;
              final totalAmount =
                  data.values.fold(0.0, (sum, value) => sum + value);
              return Column(
                children: [
                  // Circular Chart with Total Amount
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Circular Pie Chart
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: _buildPieChartSections(data),
                              centerSpaceRadius: 60,
                            ),
                          ),
                        ),
                        // Total Amount Text
                        Text(
                          '${totalAmount.toStringAsFixed(2)}€',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),

                  // Breakdown List
                  Expanded(
                    child: ListView(
                      children: data.entries.map((entry) {
                        return _buildBreakdownItem(
                            entry.key, '${entry.value.toStringAsFixed(2)}€');
                      }).toList(),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // Helper method to build Pie Chart Sections
  List<PieChartSectionData> _buildPieChartSections(Map<String, double> data) {
    return data.entries.map((entry) {
      return PieChartSectionData(
        color: _getRandomColor(),
        value: entry.value,
        title: entry.key,
        radius: 40,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      );
    }).toList();
  }

  // Helper method to build Breakdown List Items
  Widget _buildBreakdownItem(String category, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$category :',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            amount,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Color _getRandomColor() {
    final Random random = Random();
    // Génère une couleur aléatoire
    return Color.fromARGB(
      255, // Alpha, valeur fixe pour une opacité maximale
      random.nextInt(256), // Rouge (0-255)
      random.nextInt(256), // Vert (0-255)
      random.nextInt(256), // Bleu (0-255)
    );
  }
}
