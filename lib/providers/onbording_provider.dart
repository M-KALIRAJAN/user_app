import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mannai_user_app/services/onbording_service.dart';

final onbordingServiceProvider = Provider((ref) {
  return OnbordingService();
});

final aboutContentProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.read(onbordingServiceProvider);
  final box = Hive.box("aboutBox");

  //  Read Hive content & saved updatedAt
  final hiveData = box.get("about_content")?.cast<String>();
  final hiveUpdatedAt = box.get("about_updatedAt");

  //  Call API
  final data = await service.fetchAbout();

  if (data != null &&
      data["data"] != null &&
      data["data"]["content"] is List &&
      data["data"]["updatedAt"] != null) {
    
    final apiContent = List<String>.from(data["data"]["content"]);
    final apiUpdatedAt = data["data"]["updatedAt"];

    //  Update Hive only if content is new
    if (hiveData == null ||
        hiveData.isEmpty ||
        hiveUpdatedAt != apiUpdatedAt) {
      box.put("about_content", apiContent);
      box.put("about_updatedAt", apiUpdatedAt);
      return apiContent;
    } else {
      // Hive data is up-to-date
      return hiveData;
    }
  }

  // API failed → return Hive if exists, else empty
  return hiveData ?? [];
});
