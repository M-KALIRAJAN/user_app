import 'package:nadi_user_app/core/constants/app_consts.dart';
import 'package:nadi_user_app/models/ServiceOverview_Model.dart';
import 'package:nadi_user_app/services/home_view_service.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';

class DonutChartExample extends StatefulWidget {
  const DonutChartExample({super.key});

  @override
  State<DonutChartExample> createState() => _DonutChartExampleState();
}

class _DonutChartExampleState extends State<DonutChartExample> {
  final HomeViewService _homeViewService = HomeViewService();
    
    ServiceoverviewModel? serviceoverview;

  @override
  void initState() {
    super.initState();
    getServiceOverview();
  }

  Future<void> getServiceOverview() async {
  final response = await _homeViewService.serviceoverview();
  setState(() {
    serviceoverview = response;
  });
    debugPrint("UI LOG → Completed: ${response.serviceCompletedCount}");
    debugPrint("UI LOG → Pending: ${response.servicePendingCount}");
    debugPrint("UI LOG → Progress: ${response.serviceProgressCount}");
  }

  @override
  Widget build(BuildContext context) {
Map<String, double> buildServiceDataMap() {
  return {
    "Completed": serviceoverview!.serviceCompletedCount.toDouble(),
    "In Progress": serviceoverview!.serviceProgressCount.toDouble(),
    "Pending": serviceoverview!.servicePendingCount.toDouble(),
  };
}
final List<Color> serviceColors = [
  AppColors.btn_primery,  
  AppColors.gold_coin,  
  Colors.grey,   
];

  if (serviceoverview == null) {
    return const SizedBox(
      height: 100,
      width: 120,
      child: Center(child: CircularProgressIndicator()),
    );
  }
  final serviceDataMap = buildServiceDataMap();
    return SizedBox(
      height: 100,
      width: 120,
      child: PieChart(
        dataMap: serviceDataMap,
        chartRadius: 80,
        chartType: ChartType.ring,
        ringStrokeWidth: 22,
        colorList:serviceColors,
        legendOptions: const LegendOptions(showLegends: false),
        chartValuesOptions:
            const ChartValuesOptions(showChartValues: false),
      ),
    );
  }
}

