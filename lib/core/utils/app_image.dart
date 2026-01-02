import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nadi_user_app/core/network/dio_client.dart';

/// Build service icon from either Base URL or Asset URL
Widget buildServiceIcon({
  required String? serviceLogo,
  double size = 25,
  bool isAsset = false, //  determines which URL to use
}) {
  if (serviceLogo == null || serviceLogo.isEmpty) {
    return Icon(Icons.image, size: size);
  }

  // Choose URL based on `isAsset`
  final imageUrl = isAsset
      ? "${ImageAssetUrl.baseUrl}$serviceLogo"
      : "${ImageBaseUrl.baseUrl}/$serviceLogo";

  return SizedBox(
    width: size,
    height: size,
    child: serviceLogo.toLowerCase().endsWith(".svg")
        ? SvgPicture.network(
            imageUrl,
            fit: BoxFit.contain,
            placeholderBuilder: (_) => Icon(Icons.image, size: size),
          )
        : CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => Icon(Icons.image, size: size),
            errorWidget: (_, __, ___) => Icon(Icons.broken_image, size: size),
          ),
  );
}
