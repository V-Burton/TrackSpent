import 'package:flutter/material.dart';
import 'package:front/src/rust/api/simple.dart';
import 'piechart.dart';
import 'carousel.dart';
import 'expense_list.dart';

class OutcomePage extends StatefulWidget {
  const OutcomePage({Key? key}) : super(key: key);

  @override
  _OutcomePageState createState() => _OutcomePageState();
}

class _OutcomePageState extends State<OutcomePage> {
  late Future<Map<String, double>> _getOutcomeData;
  String selectedMonth =
      DateTime.now().month.toString(); // Mois sélectionné par défaut
  String selectedYear = DateTime.now().year.toString(); // Année sélectionnée par défaut

  @override
  void initState() {
    super.initState();
    _getOutcomeData = loadGetOutcomeData();
  }


  Future<Map<String, double>> loadGetOutcomeData() async {
    return getOutcomeDataByDate(monthStr: selectedMonth, yearStr: selectedYear);
  }

  void _updateOutcomeData() {
    setState(() {
      _getOutcomeData = loadGetOutcomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Map<String, double>>(
            future: _getOutcomeData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                Map<String, double> outcomeData = snapshot.data!;
                return _buildOutcomeChart(outcomeData);
              } else {
                return const Center(child: Text('No data available'));
              }
            }));
  }

  Widget _buildOutcomeChart(Map<String, double> outcomeData) {
    return Scaffold(
        body: Column(
      children: [
        PieChartWidget(data: outcomeData),
        const SizedBox(height: 20),
        CarouselWidget(
            items:
                "January February March April May June July August September October November December"
                    .split(" "),
            onItemSelected: (selected) {
              setState(() {
                selectedMonth = selected;
              }
            );
          }
        ),
        CarouselWidget(
          items: "2023 2024".split(" "),
          onItemSelected: (selected) {
            setState(() {
              selectedYear = selected;
            });
          },
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ExpenseListWidget(expenses: outcomeData),
        )
      ],
    ));
  }
}
