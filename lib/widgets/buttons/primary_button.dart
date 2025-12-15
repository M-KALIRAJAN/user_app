import 'package:flutter/material.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double height;
  final double borderRadius;
  final double width;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.textColor = Colors.white,
    this.height = 60,
    required this.width,
    this.borderRadius = 14,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: InkSplash.splashFactory, // smaller ripple
          splashColor: Colors.white.withOpacity(0.25), // ripple color
        ),
        child: ElevatedButton(
          clipBehavior: Clip.antiAlias, // IMPORTANT → full ripple clip
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: icon == null
              ? Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: AppFontSizes.medium,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon!,
                    const SizedBox(width: 20),
                    Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
