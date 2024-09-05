import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWidget extends StatefulWidget {
  final List<String> items;
  final Function(String) onItemSelected;
  final int initialIndex;

  const CarouselWidget(
      {super.key, required this.items, required this.onItemSelected, required this.initialIndex});

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late int _currentIndex;

  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 32.0,
            autoPlay: false,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              widget.onItemSelected(widget.items[index]);
            },
          ),
          items: widget.items.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: 150.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 5.0),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
