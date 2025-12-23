import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nadi_user_app/core/constants/app_consts.dart';
import 'package:nadi_user_app/core/network/dio_client.dart';
import 'package:nadi_user_app/core/utils/logger.dart';
import 'package:nadi_user_app/services/logs_service.dart';

class RecentActivity extends StatefulWidget {
  const RecentActivity({super.key});

  @override
  State<RecentActivity> createState() => _RecentActivityState();
}

class _RecentActivityState extends State<RecentActivity> {
  LogsService _logsservice = LogsService();
  List<dynamic> logs = [];
  Timer? timer;
  @override
  void initState() {
    super.initState();
    LogsData();
    timer = Timer.periodic(Duration(seconds: 10), (_) {
      LogsData();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> LogsData() async {
    try {
      final response = await _logsservice.UserLogs();
      if (!mounted) return;
      setState(() {
        logs = response ?? [];
      });
      AppLogger.success("LogsData ${logs}");
    } catch (e) {
      AppLogger.error("LogsData $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return Center(child: Text("No recent activity"));
    }
    return ListView.builder(
      itemCount: logs.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        final log = logs[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Avatar
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.btn_primery,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            "${ImageBaseUrl.baseUrl}/${log['logo'] ?? ''}",
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) =>
                            const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Text section (FIXED)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          log['log'] ?? "",
                          style: const TextStyle(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          log['time'] ?? "",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  /// Status chip
                  Container(
                    height: 22,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.btn_primery,
                    ),
                    child: Center(
                      child: Text(
                        log['status'] ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Divider(color: AppColors.borderGrey, height: 1),
            ],
          ),
        );
      },
    );
  }
}
