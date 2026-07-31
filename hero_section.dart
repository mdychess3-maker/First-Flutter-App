import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/config/app_config.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/widgets/gradient_text.dart';
import '../../../core/widgets/video_link_icon.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewEdits;

  const HeroSection({super.key, required this.onViewEdits});

  Future<void> _openChannel() async {
    Haptics.tap();
    final uri = Uri.parse(AppConfig.youtubeChannelUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 520,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Floating watermark, mirrors the site's translucent queen glyph.
          Positioned(
            top: 10,
            child: SvgPicture.asset(
              AppAssets.queenWatermark,
              width: 240,
              height: 240,
              colorFilter: ColorFilter.mode(
                AppColors.gold.withOpacity(isDark ? 0.07 : 0.10),
                BlendMode.srcIn,
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .moveY(begin: -14, end: 14, duration: 4000.ms, curve: Curves.easeInOut)
                .rotate(begin: -0.01, end: 0.01, duration: 4000.ms),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(
                text: AppStrings.heroTitle,
                gradient: isDark
                    ? AppColors.goldTextGradientDark
                    : AppColors.goldTextGradientLight,
                style: AppTextStyles.display(Colors.white).copyWith(fontSize: 54),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.15, end: 0, curve: Curves.easeOutCubic),
              const SizedBox(height: 10),
              Text(
                AppStrings.heroSubtitle.toUpperCase(),
                style: AppTextStyles.subHeading(
                  isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
                ).copyWith(letterSpacing: 5),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 34),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 14,
                runSpacing: 14,
                children: [
                  _PrimaryButton(
                    label: 'View My Edits',
                    icon: LucideIcons.play,
                    onTap: () {
                      Haptics.tap();
                      onViewEdits();
                    },
                  ),
                  _SecondaryButton(
                    label: 'Visit Channel',
                    icon: VideoLinkIcon(
                      size: 18,
                      color: isDark ? Colors.white : AppColors.lightInk,
                    ),
                    onTap: _openChannel,
                  ),
                ],
              ).animate().fadeIn(delay: 350.ms, duration: 600.ms).slideY(
                    begin: 0.2,
                    end: 0,
                  ),
              const SizedBox(height: 30),
              _HighlightChips(isDark: isDark)
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 600.ms),
            ],
          ),
        ],
      ),
    );
  }
}

class _HighlightChips extends StatelessWidget {
  final bool isDark;
  const _HighlightChips({required this.isDark});

  static const _tags = ['4K Renders', 'Viral Cuts', 'Chess-Aware Editing'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: _tags
          .map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(isDark ? 0.08 : 0.10),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.gold.withOpacity(0.35)),
              ),
              child: Text(
                tag,
                style: AppTextStyles.caption(
                  isDark ? AppColors.goldLight : AppColors.gold,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label.toUpperCase(), style: AppTextStyles.button(Colors.black)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        elevation: 8,
        shadowColor: AppColors.goldGlow,
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;
  const _SecondaryButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? Colors.white : AppColors.lightInk;
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: icon,
      label: Text(label.toUpperCase(), style: AppTextStyles.button(ink)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        side: BorderSide(color: ink.withOpacity(0.25)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
