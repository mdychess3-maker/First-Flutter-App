import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/config/app_config.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/video_link_icon.dart';

class ChannelCtaCard extends StatelessWidget {
  final VoidCallback onViewEdits;

  const ChannelCtaCard({super.key, required this.onViewEdits});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : AppColors.lightInk;
    final dim = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LucideIcons.sparkles, color: AppColors.gold, size: 30),
          const SizedBox(height: 14),
          Text(AppStrings.exploreTitle, style: AppTextStyles.heading(ink)),
          const SizedBox(height: 10),
          Text(AppStrings.exploreBody, style: AppTextStyles.body(dim)),
          const SizedBox(height: 22),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () async {
                  Haptics.tap();
                  await launchUrl(
                    Uri.parse(AppConfig.youtubeChannelUrl),
                    mode: LaunchMode.externalApplication,
                  );
                },
                icon: const VideoLinkIcon(size: 18, color: Colors.black),
                label: Text('Visit My Channel'.toUpperCase(),
                    style: AppTextStyles.button(Colors.black)),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  Haptics.tap();
                  onViewEdits();
                },
                icon: Icon(LucideIcons.layout_grid, size: 18, color: ink),
                label: Text('View More Edits'.toUpperCase(),
                    style: AppTextStyles.button(ink)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  side: BorderSide(color: ink.withOpacity(0.25)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
  }
}
