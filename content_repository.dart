import 'package:flutter_lucide/flutter_lucide.dart';
import '../models/feature_item.dart';
import '../models/portfolio_video.dart';

/// Static content mirrored from the MDY Chess website. There is no backend
/// for this portfolio app, so content lives here as plain Dart data —
/// simple, fast, and offline-friendly.
class ContentRepository {
  ContentRepository._();

  static const List<PortfolioVideo> portfolioVideos = [
    PortfolioVideo(youtubeId: 'v0pHJ28PaRI', title: 'Cinematic Chess Edit I'),
    PortfolioVideo(youtubeId: 'qTZ6O0jT5R8', title: 'Cinematic Chess Edit II'),
    PortfolioVideo(youtubeId: 'fIILw2qkMvc', title: 'Cinematic Chess Edit III'),
    PortfolioVideo(youtubeId: '4UTaFPX-lZY', title: 'Cinematic Chess Edit IV'),
  ];

  static const List<FeatureItem> features = [
    FeatureItem(
      icon: LucideIcons.zap,
      title: 'Fast Delivery',
      description:
          'Speed is essential in content creation. I deliver high-end '
          'edits within your tightest deadlines.',
    ),
    FeatureItem(
      icon: LucideIcons.rocket,
      title: 'Viral Style',
      description:
          'Engineered for retention. I use psychological cutting '
          'patterns to keep viewers glued to the screen.',
    ),
    FeatureItem(
      icon: LucideIcons.clapperboard,
      title: 'HQ Production',
      description:
          '4K rendering with frame-perfect synchronization and premium '
          'sound design.',
    ),
    FeatureItem(
      icon: LucideIcons.brain_circuit,
      title: 'Chess Insight',
      description:
          'I understand the game. I know exactly when to highlight a '
          'move for maximum dramatic impact.',
    ),
    FeatureItem(
      icon: LucideIcons.sparkles,
      title: 'Custom VFX',
      description:
          'Unique visual effects that set your brand apart from '
          'generic template editors.',
    ),
    FeatureItem(
      icon: LucideIcons.gem,
      title: 'Client Success',
      description:
          'Focused on long-term partnerships and helping creators reach '
          'millions of subscribers.',
    ),
  ];
}
