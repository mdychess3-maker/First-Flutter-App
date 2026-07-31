import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final CrossAxisAlignment alignment;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : AppColors.lightInk;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: AppTextStyles.subHeading(AppColors.gold),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 6),
        Text(
          title,
          style: AppTextStyles.heading(ink),
        ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideY(
              begin: 0.3,
              end: 0,
            ),
      ],
    );
  }
}
