import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A soft, frosted card with a hairline gold-tinted border — the base
/// building block for feature cards, video cards and CTA panels.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final double borderRadius;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.onTap,
    this.borderRadius = 22,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark ? Colors.white.withOpacity(0.07) : Colors.black.withOpacity(0.06);
    final bg = isDark ? AppColors.obsidianCard : AppColors.ivoryCard;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
          color: bg.withOpacity(0.92),
          child: InkWell(
            onTap: onTap,
            splashColor: AppColors.goldGlow,
            highlightColor: AppColors.goldGlow.withOpacity(0.06),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: borderColor),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
