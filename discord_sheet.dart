import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/config/app_config.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/haptics.dart';

class DiscordSheet extends StatefulWidget {
  const DiscordSheet({super.key});

  static Future<void> show(BuildContext context) {
    Haptics.tap();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const DiscordSheet(),
    );
  }

  @override
  State<DiscordSheet> createState() => _DiscordSheetState();
}

class _DiscordSheetState extends State<DiscordSheet> {
  bool _copied = false;

  Future<void> _copyId() async {
    Haptics.success();
    await Clipboard.setData(const ClipboardData(text: AppConfig.discordId));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.obsidianElevated : AppColors.ivoryElevated;
    final ink = isDark ? Colors.white : AppColors.lightInk;
    final dim = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 32),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border.all(color: AppColors.gold.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: dim.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.message_square, color: AppColors.gold, size: 30),
            ),
            const SizedBox(height: 18),
            Text(AppStrings.discordConnectTitle, style: AppTextStyles.heading(ink)),
            const SizedBox(height: 8),
            Text(
              AppStrings.discordConnectBody,
              textAlign: TextAlign.center,
              style: AppTextStyles.body(dim),
            ),
            const SizedBox(height: 22),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.black.withOpacity(0.04),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.gold, style: BorderStyle.solid),
              ),
              alignment: Alignment.center,
              child: Text(
                AppConfig.discordId,
                style: AppTextStyles.heading(AppColors.gold).copyWith(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _copyId,
                icon: Icon(_copied ? LucideIcons.check : LucideIcons.copy, size: 18),
                label: Text(
                  (_copied ? 'Copied!' : 'Copy ID').toUpperCase(),
                  style: AppTextStyles.button(Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _copied ? AppColors.success : AppColors.gold,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
              ),
            )
                .animate(target: _copied ? 1 : 0)
                .scale(begin: const Offset(1, 1), end: const Offset(1.03, 1.03)),
            const SizedBox(height: 14),
            TextButton(
              onPressed: () async {
                Haptics.tap();
                await launchUrl(
                  Uri.parse(AppConfig.discordInviteUrl),
                  mode: LaunchMode.externalApplication,
                );
              },
              child: Text(
                'Join My Server Instead',
                style: AppTextStyles.caption(dim).copyWith(fontSize: 12.5),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 0.15, end: 0, duration: 350.ms, curve: Curves.easeOutCubic);
  }
}
