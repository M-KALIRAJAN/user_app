import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nadi_user_app/core/constants/app_consts.dart';
import 'package:nadi_user_app/core/network/dio_client.dart';
import 'package:nadi_user_app/providers/serviceProvider.dart';
import 'package:nadi_user_app/routing/app_router.dart';

import 'package:nadi_user_app/widgets/app_back.dart';

class Allservice extends ConsumerStatefulWidget {
  const Allservice({super.key});

  @override
  ConsumerState<Allservice> createState() => _AllserviceState();
}

class _AllserviceState extends ConsumerState<Allservice> {
  @override
  Widget build(BuildContext context) {
    final services = ref.watch(serviceListProvider);
    return Scaffold(
      backgroundColor: AppColors.background_clr,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppCircleIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () => context.pop(),
                  ),
                  const Text(
                    "Service",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  Text(""),
                ],
              ),
            ),
            Divider(),
            SizedBox(height: 15),
            // GRID SECTION
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  itemCount: services.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final service = services[index];
                    final String name = service['name'] ?? '';
                    final String serviceId = service['_id'] ?? "";
                    final String? Image = service['serviceImage'];

                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        context.push(
                          RouteNames.sendservicerequest,
                          extra: {
                            'title': name,
                            "imagePath":
                                "${ImageBaseUrl.baseUrl}/${service['serviceImage']}",
                                'serviceId': serviceId,
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: "${ImageBaseUrl.baseUrl}/$Image",
                                height: 80,
                                width: 140,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(height: 10),
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
