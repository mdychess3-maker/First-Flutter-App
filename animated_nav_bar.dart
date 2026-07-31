import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/haptics.dart';

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

const _items = [
  _NavItem(LucideIcons.home, 'Home'),
  _NavItem(LucideIcons.layout_grid, 'Portfolio'),
  _NavItem(LucideIcons.award, 'Expertise'),
  _NavItem(LucideIcons.message_circle, 'Contact'),
];

class AnimatedNavBar extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTabSelected;

  const AnimatedNavBar({
    super.key,
    required this.activeIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final barColor = isDark ? AppColors.obsidianElevated : AppColors.ivoryElevated;
    final inactiveColor = isDark ? AppColors.darkTextDim : AppColors.lightTextDim;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: barColor.withOpacity(0.96),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.black.withOpacity(0.05),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.4 : 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final tabWidth = constraints.maxWidth / _items.length;
              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 380),
                    curve: Curves.easeOutCubic,
                    left: tabWidth * activeIndex + 8,
                    top: 8,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 380),
                      curve: Curves.easeOutCubic,
                      width: tabWidth - 16,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(isDark ? 0.16 : 0.18),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.gold.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(_items.length, (index) {
                      final item = _items[index];
                      final selected = index == activeIndex;
                      final color = selected ? AppColors.gold : inactiveColor;

                      return Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {
                            if (index != activeIndex) {
                              Haptics.select();
                              onTabSelected(index);
                            }
                          },
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(item.icon, color: color, size: 22),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: selected
                                      ? Padding(
                                          key: ValueKey(item.label),
                                          padding: const EdgeInsets.only(top: 3),
                                          child: Text(
                                            item.label,
                                            style: AppTextStyles.caption(color)
                                                .copyWith(fontSize: 10),
                                          ),
                                        )
                                      : const SizedBox(
                                          key: ValueKey('empty'),
                                          height: 0,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
