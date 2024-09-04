import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> data;

  const PieChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalAmount = data.values.fold(0.0, (sum, value) => sum + value);
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
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
          Text(
            totalAmount.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  //Helper method to build PieChart
  List<PieChartSectionData> _buildPieChartSections(Map<String, double> data) {
    return data.entries.map((entry) {
      return PieChartSectionData(
        color: Colors.primaries[
            data.entries.toList().indexOf(entry) % Colors.primaries.length],
        value: entry.value,
        title: entry.key,
        radius: 40,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      );
    }).toList();
  }
}
