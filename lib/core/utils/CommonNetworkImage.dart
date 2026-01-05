
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  const CommonNetworkImage({
    super.key,
    required this.imageUrl,
    this.size = 25,
  });

  bool get _isSvg => imageUrl.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child: _isSvg
            ? SvgPicture.network(
                imageUrl,
                width: size,
                height: size,
              )
            : Image.network(
                imageUrl,
              ),
      ),
    );
  }
}
