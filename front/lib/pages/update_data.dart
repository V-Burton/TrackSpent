import 'package:flutter/material.dart';
import 'package:front/src/rust/api/simple.dart';
import 'piechart.dart';
import 'expense_list.dart';

class UpdateDataWidget extends StatefulWidget {
  final int month;
  final int year;
  final bool positive;

  const UpdateDataWidget({
    super.key, 
    required this.month, 
    required this.year,
    required this.positive
  });

  @override
  _UpdateDataWidgetState createState() => _UpdateDataWidgetState();
}

class _UpdateDataWidgetState extends State<UpdateDataWidget> {
  late Future<Map<String, double>> _getData;

  @override
  void initState(){
    super.initState();
    _fetchData();
  }

@override
void didUpdateWidget(covariant UpdateDataWidget oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (widget.month != oldWidget.month || widget.year != oldWidget.year) {
    _fetchData();
  }
  }
  
  void _fetchData() {
    setState(() {
      _getData = widget.positive ? getIncomeDataByDate(month: widget.month, year: widget.year) : getOutcomeDataByDate(month: widget.month, year: widget.year);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: _getData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Map<String, double> data = snapshot.data!;
            return Column(
              children: [
                PieChartWidget(data: data),
                const SizedBox(height: 20),
                Expanded(
                  child: ExpenseListWidget(expenses: data),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        });
  }
}

int monthToInt(String month) {
  switch (month) {
    case "January":
      return 1;
    case "February":
      return 2;
    case "March":
      return 3;
    case "April":
      return 4;
    case "May":
      return 5;
    case "June":
      return 6;
    case "July":
      return 7;
    case "August":
      return 8;
    case "September":
      return 9;
    case "October":
      return 10;
    case "November":
      return 11;
    case "December":
      return 12;
    default:
      return 0;
  }
}

int monthToIndex(int month) {
  return month - 1; // Index des mois commençant à 0
}

int yearToIndex(int year) {
  return year == 2023 ? 0 : 1; // Index des années, ajustez selon vos besoins
}