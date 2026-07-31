import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/haptics.dart';
import '../../../data/models/portfolio_video.dart';

class VideoThumbnailCard extends StatelessWidget {
  final PortfolioVideo video;
  final VoidCallback onTap;

  const VideoThumbnailCard({
    super.key,
    required this.video,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Material(
        color: AppColors.obsidianCard,
        child: InkWell(
          splashColor: AppColors.goldGlow,
          onTap: () {
            Haptics.tap();
            onTap();
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                video.thumbnailUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: AppColors.obsidianCard,
                    child: const Center(
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.gold,
                        ),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.obsidianCard,
                  alignment: Alignment.center,
                  child: const Icon(LucideIcons.image_off, color: AppColors.gold),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.05),
                      Colors.black.withOpacity(0.55),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.gold, width: 1.4),
                  ),
                  child: const Icon(LucideIcons.play, color: AppColors.gold, size: 26),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
