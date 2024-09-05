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
  int selectedMonth = DateTime.now().month; // Mois sélectionné par défaut
  int selectedYear = DateTime.now().year; // Année sélectionnée par défaut

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // Carrousel pour les années
        CarouselWidget(
          items: "2023 2024".split(" "),
          initialIndex: yearToIndex(selectedYear), // Initialise à l'année actuelle
          onItemSelected: (selected) {
            setState(() {
              selectedYear = int.parse(selected);
            });
          },
        ),
        // Carrousel pour les mois
        CarouselWidget(
          items: "January February March April May June July August September October November December"
              .split(" "),
          initialIndex: monthToIndex(selectedMonth), // Initialise à la sélection du mois actuel
          onItemSelected: (selected) {
            setState(() {
              selectedMonth = monthToInt(selected);
            });
          },
        ),
        const SizedBox(height: 20),
        // Charge uniquement les données dynamiques (pie chart + liste de dépenses)
        Expanded(
          child: OutcomeDataWidget(
            month: selectedMonth,
            year: selectedYear,
          ),
        ),
      ],
    ));
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
}

class OutcomeDataWidget extends StatefulWidget {
  final int month;
  final int year;

  const OutcomeDataWidget({super.key, required this.month, required this.year });

  @override
  _OutcomeDataWidgetState createState() => _OutcomeDataWidgetState();
}

class _OutcomeDataWidgetState extends State<OutcomeDataWidget> {
  late Future<Map<String, double>> _getOutcomeData;

  @override
  void initState(){
    super.initState();
    _fetchOutcomeData();
  }

@override
void didUpdateWidget(covariant OutcomeDataWidget oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (widget.month != oldWidget.month || widget.year != oldWidget.year) {
    _fetchOutcomeData();
  }
  }
  
  void _fetchOutcomeData() {
    setState(() {
      _getOutcomeData = getOutcomeDataByDate(month: widget.month, year: widget.year);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: _getOutcomeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Map<String, double> outcomeData = snapshot.data!;
            return Column(
              children: [
                PieChartWidget(data: outcomeData),
                const SizedBox(height: 20),
                Expanded(
                  child: ExpenseListWidget(expenses: outcomeData),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        });
  }
}
