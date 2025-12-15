import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';

class DonutChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 120,
      child: PieChart(
        dataMap: {"Red": 40, "Green": 30, "Grey": 30},
        chartRadius: 80,
        chartType: ChartType.ring,
        ringStrokeWidth: 22,
        colorList: [Colors.red, Color(0xFF0A615A), Colors.grey],
        legendOptions: LegendOptions(showLegends: false),
        chartValuesOptions: ChartValuesOptions(showChartValues: false),
      ),
    );
  }
}
