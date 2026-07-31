import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_assets.dart';

/// Lucide removed all brand/social icons (youtube, discord, etc.) upstream,
/// so `flutter_lucide` no longer exposes `LucideIcons.youtube`. Rather than
/// pull in a brand-icon package or reproduce a trademarked logo, this is a
/// small hand-authored generic "external video" glyph used everywhere the
/// app links out to the YouTube channel.
class VideoLinkIcon extends StatelessWidget {
  final double size;
  final Color color;

  const VideoLinkIcon({super.key, this.size = 18, required this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.videoLink,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
