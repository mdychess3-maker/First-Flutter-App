/// Centralised, compile-time configuration.
///
/// Nothing sensitive is hardcoded in source. Every externally-owned value
/// (channel links, social handles, contact identifiers) is injected at
/// build time via `--dart-define`, falling back to the current public
/// MDY Chess values so the app still builds and runs out of the box.
///
/// Example release build with overrides:
/// ```
/// flutter build apk \
///   --dart-define=YOUTUBE_CHANNEL_URL=https://youtube.com/@mdy_chess \
///   --dart-define=DISCORD_INVITE_URL=https://discord.gg/T5ssgD2q2 \
///   --dart-define=DISCORD_ID=MDYChess
/// ```
class AppConfig {
  AppConfig._();

  static const String youtubeChannelUrl = String.fromEnvironment(
    'YOUTUBE_CHANNEL_URL',
    defaultValue: 'https://youtube.com/@mdy_chess',
  );

  static const String discordInviteUrl = String.fromEnvironment(
    'DISCORD_INVITE_URL',
    defaultValue: 'https://discord.gg/T5ssgD2q2',
  );

  static const String discordId = String.fromEnvironment(
    'DISCORD_ID',
    defaultValue: 'MDYChess',
  );

  /// Feature flag: toggle analytics/crash-reporting hooks in the future
  /// without shipping a new binary flavor. Currently unused by the UI,
  /// reserved for future integration.
  static const bool analyticsEnabled = bool.fromEnvironment(
    'ANALYTICS_ENABLED',
    defaultValue: false,
  );
}
