import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/utils/haptics.dart';
import '../../providers/nav_provider.dart';
import 'widgets/channel_cta_card.dart';
import 'widgets/hero_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeMode = ref.watch(themeModeProvider);

    void goToPortfolio() => ref.read(navIndexProvider.notifier).state = 1;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            titleSpacing: 20,
            title: RichText(
              text: TextSpan(
                style: AppTextStyles.cardTitle(
                  isDark ? Colors.white : AppColors.lightInk,
                ).copyWith(letterSpacing: 2, fontSize: 18),
                children: const [
                  TextSpan(text: 'MDY '),
                  TextSpan(
                    text: 'CHESS',
                    style: TextStyle(color: AppColors.gold),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  tooltip: themeMode == ThemeMode.dark
                      ? 'Switch to light mode'
                      : 'Switch to dark mode',
                  onPressed: () {
                    Haptics.select();
                    ref.read(themeModeProvider.notifier).toggle();
                  },
                  icon: Icon(
                    themeMode == ThemeMode.dark
                        ? LucideIcons.sun
                        : LucideIcons.moon,
                    color: AppColors.gold,
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                HeroSection(onViewEdits: goToPortfolio),
                const SizedBox(height: 8),
                ChannelCtaCard(onViewEdits: goToPortfolio),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    AppStrings.footerCopyright,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption(
                      isDark ? AppColors.darkTextDim : AppColors.lightTextDim,
                    ),
                  ),
                ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
