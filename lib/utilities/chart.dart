import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

Widget Pie(BuildContext context,double sales,double purchase) {
  List<PieChartSectionData> paiChartSelectionData = [
    PieChartSectionData(
      color: Colors.green[900],
      value: sales,
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: Colors.orange,
      value: purchase,
      showTitle: false,
      radius: 22,
    ),

  ];
  return SizedBox(
    height: 200,
    child: Stack(
      children: [
        PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 70,
            startDegreeOffset: -90,
            sections: paiChartSelectionData,
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: defaultPadding),
              Text(
                "$sales",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 0.5,
                ),
              ),
              Text("/ ${purchase}g",style: const TextStyle(color: Colors.white),)
            ],
          ),
        ),
      ],
    ),
  );
}


