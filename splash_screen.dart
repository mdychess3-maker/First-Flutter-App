import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../shell/main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1900), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (_, __, ___) => const MainShell(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidian,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.queenWatermark,
              width: 96,
              height: 96,
              colorFilter: const ColorFilter.mode(
                AppColors.gold,
                BlendMode.srcIn,
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .moveY(begin: -6, end: 6, duration: 1800.ms, curve: Curves.easeInOut)
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1)),
            const SizedBox(height: 22),
            Text(
              'MDY',
              style: AppTextStyles.display(Colors.white).copyWith(
                letterSpacing: 10,
                fontSize: 40,
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
            const SizedBox(height: 14),
            Text(
              'LOADING EXPERIENCE',
              style: AppTextStyles.caption(AppColors.gold),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .fadeIn(delay: 400.ms, duration: 900.ms)
                .then()
                .fadeOut(duration: 900.ms),
          ],
        ),
      ),
    );
  }
}
