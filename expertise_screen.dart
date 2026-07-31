import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/section_header.dart';
import '../../data/repositories/content_repository.dart';
import 'widgets/feature_card.dart';

class ExpertiseScreen extends StatelessWidget {
  const ExpertiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = ContentRepository.features;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
            sliver: SliverToBoxAdapter(
              child: SectionHeader(
                eyebrow: AppStrings.expertiseEyebrow,
                title: AppStrings.expertiseTitle,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final feature = features[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: FeatureCard(feature: feature)
                        .animate()
                        .fadeIn(delay: (90 * index).ms, duration: 450.ms)
                        .slideX(begin: 0.06, end: 0),
                  );
                },
                childCount: features.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
