class PortfolioVideo {
  final String youtubeId;
  final String title;

  const PortfolioVideo({
    required this.youtubeId,
    required this.title,
  });

  String get thumbnailUrl =>
      'https://img.youtube.com/vi/$youtubeId/hqdefault.jpg';

  String get watchUrl => 'https://youtube.com/shorts/$youtubeId';
}
