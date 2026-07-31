import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/config/app_config.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/haptics.dart';
import '../../core/widgets/video_link_icon.dart';
import 'widgets/discord_sheet.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : AppColors.lightInk;
    final dim = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 140),
        child: Column(
          children: [
            SvgPicture.asset(
              AppAssets.queenWatermark,
              width: 72,
              height: 72,
              colorFilter: const ColorFilter.mode(AppColors.gold, BlendMode.srcIn),
            ).animate().fadeIn(duration: 500.ms).scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                ),
            const SizedBox(height: 20),
            Text(
              AppStrings.contactTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.display(ink).copyWith(fontSize: 34),
            ).animate().fadeIn(delay: 100.ms, duration: 500.ms),
            const SizedBox(height: 10),
            Text(
              AppStrings.contactSubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.subHeading(dim).copyWith(letterSpacing: 3),
            ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => DiscordSheet.show(context),
                icon: const Icon(LucideIcons.message_square, size: 18),
                label: Text('Contact on Discord'.toUpperCase(),
                    style: AppTextStyles.button(Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
              ),
            ).animate().fadeIn(delay: 300.ms, duration: 500.ms).slideY(
                  begin: 0.15,
                  end: 0,
                ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  Haptics.tap();
                  await launchUrl(
                    Uri.parse(AppConfig.discordInviteUrl),
                    mode: LaunchMode.externalApplication,
                  );
                },
                icon: Icon(LucideIcons.users, size: 18, color: ink),
                label: Text('Join My Server'.toUpperCase(),
                    style: AppTextStyles.button(ink)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  side: BorderSide(color: ink.withOpacity(0.25)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ).animate().fadeIn(delay: 380.ms, duration: 500.ms).slideY(
                  begin: 0.15,
                  end: 0,
                ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () async {
                  Haptics.tap();
                  await launchUrl(
                    Uri.parse(AppConfig.youtubeChannelUrl),
                    mode: LaunchMode.externalApplication,
                  );
                },
                icon: const VideoLinkIcon(size: 18, color: AppColors.gold),
                label: Text('youtube.com/@mdy_chess',
                    style: AppTextStyles.caption(AppColors.gold).copyWith(fontSize: 13)),
              ),
            ).animate().fadeIn(delay: 460.ms, duration: 500.ms),
            const SizedBox(height: 40),
            Text(
              AppStrings.footerCopyright,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption(dim),
            ).animate().fadeIn(delay: 560.ms, duration: 500.ms),
          ],
        ),
      ),
    );
  }
}
