import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class OutcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                        sections: _buildPieChartSections(),
                        centerSpaceRadius: 60,
                      ),
                    ),
                  ),
                  // Total Amount Text
                  Text(
                    '1263,08€',
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
                children: [
                  _buildBreakdownItem('SAVE', '280,00€'),
                  _buildBreakdownItem('Charge', '783,00€'),
                  _buildBreakdownItem('Other', '100,00€'),
                  _buildBreakdownItem('Food', '100,00€'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build Pie Chart Sections
  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: 280,
        title: 'Save',
        radius: 40,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 783,
        title: 'Charge',
        radius: 40,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: 100,
        title: 'Other',
        radius: 40,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 100,
        title: 'Food',
        radius: 40,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ];
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
}
