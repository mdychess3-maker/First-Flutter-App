import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/section_header.dart';
import '../../data/repositories/content_repository.dart';
import 'video_player_screen.dart';
import 'widgets/video_thumbnail_card.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videos = ContentRepository.portfolioVideos;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
            sliver: SliverToBoxAdapter(
              child: SectionHeader(
                eyebrow: AppStrings.portfolioEyebrow,
                title: AppStrings.portfolioTitle,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.82,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final video = videos[index];
                  return VideoThumbnailCard(
                    video: video,
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 350),
                          pageBuilder: (_, __, ___) =>
                              VideoPlayerScreen(video: video),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: Tween(begin: 0.96, end: 1.0)
                                    .animate(animation),
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ).animate().fadeIn(
                        delay: (80 * index).ms,
                        duration: 450.ms,
                      ).slideY(begin: 0.08, end: 0);
                },
                childCount: videos.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
