import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mannai_user_app/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final getBlockProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final service = ref.read(authServiceProvider);

  // Ensure Hive box is open
  if (!Hive.isBoxOpen("blockbox")) await Hive.openBox("blockbox");
  final box = Hive.box("blockbox");

  final hiveData = box.get("block_lists");
  final hiveUpdatedAt = box.get("block_updatedAt");

  // Call API
  final apiData = await service.selectblock();

  if (apiData.isEmpty) {
    if (hiveData == null) return [];
    return List<Map<String, dynamic>>.from(
        (hiveData as List).map((e) => Map<String, dynamic>.from(e)));
  }

  // Calculate latest updatedAt
  DateTime latest = DateTime.fromMillisecondsSinceEpoch(0);
  for (final road in apiData) {
    final roadUpdated = DateTime.parse(road["updatedAt"]);
    if (roadUpdated.isAfter(latest)) latest = roadUpdated;
    for (final block in (road["blocks"] as List)) {
      final blockUpdated = DateTime.parse(block["updatedAt"]);
      if (blockUpdated.isAfter(latest)) latest = blockUpdated;
    }
  }

  final apiUpdatedAt = latest.toIso8601String();

  if (hiveData == null || hiveData.isEmpty || hiveUpdatedAt != apiUpdatedAt) {
    await box.put("block_lists", apiData);
    await box.put("block_updatedAt", apiUpdatedAt);
  }

  return apiData;
});
