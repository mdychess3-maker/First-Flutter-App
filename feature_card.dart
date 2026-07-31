import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../data/models/feature_item.dart';

class FeatureCard extends StatelessWidget {
  final FeatureItem feature;

  const FeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : AppColors.lightInk;
    final dim = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(feature.icon, color: AppColors.gold, size: 26),
          ),
          const SizedBox(height: 16),
          Text(feature.title, style: AppTextStyles.cardTitle(ink)),
          const SizedBox(height: 8),
          Text(
            feature.description,
            style: AppTextStyles.body(dim).copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
