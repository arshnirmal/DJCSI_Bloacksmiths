import 'package:flutter/material.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  List<String>? items;
  int? select;

  @override
  void initState() {
    super.initState();
    items = <String>[
      'Happy Hour',
      'Loyalty Program',
      'Special Seasonal Drinks',
      'Free Pastry with Drink',
      'Buy One, Get One Free',
      'Coffee Tasting Events',
      'Customizable Drinks ',
      'Student Discount',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(30.0),
            height: MediaQuery.of(context).size.height / 1.7,
            child: Center(
              child: Text(items![index]),
            ),
          );
        },
      ),
    );
  }
}
