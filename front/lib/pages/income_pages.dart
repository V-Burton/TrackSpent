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