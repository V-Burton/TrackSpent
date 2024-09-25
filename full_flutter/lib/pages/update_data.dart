import 'package:flutter/material.dart';
import 'piechart.dart';
import 'expense_list.dart';
import 'package:provider/provider.dart';
import 'package:full_flutter/pages/spent.dart';

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

  @override
  Widget build(BuildContext context){
    final data = widget.positive
        ? Provider.of<SpentModel>(context).getIncomeDataByDate(widget.month, widget.year)
        : Provider.of<SpentModel>(context).getOutcomeDataByDate(widget.month, widget.year);

    if (data.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return Column(
      children: [
        PieChartWidget(data: data),
        const SizedBox(height: 20),
        Expanded(
          child: ExpenseListWidget(expenses: data),
        ),
      ],
    );
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