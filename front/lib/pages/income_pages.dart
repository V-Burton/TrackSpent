import 'package:flutter/material.dart';
import 'carousel.dart';
import 'update_data.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
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
          child: UpdateDataWidget(
            month: selectedMonth,
            year: selectedYear,
            positive: true,
          ),
        ),
      ],
    ));
  }
}