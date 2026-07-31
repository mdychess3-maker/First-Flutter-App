# MDY Chess — Portfolio App

A production-ready Flutter portfolio app for **MDY Chess**, a cinematic chess
video editor. Ported faithfully from the official website (obsidian + gold
theme, Cinzel/Inter typography, portfolio reel, service highlights, Discord
contact flow) into a smooth, animated, WhatsApp-feel native app.

## ✨ Features

- **Home** — animated gold-gradient hero, quick highlight chips, "Explore My
  World" channel CTA
- **Portfolio** — grid of cinematic edits, tap to play natively (no WebView)
  via `youtube_player_flutter`, or open directly on YouTube
- **Expertise** — the six "Grandmaster Service" pillars (Fast Delivery,
  Viral Style, HQ Production, Chess Insight, Custom VFX, Client Success)
- **Contact** — "Ready to Play?" CTA, Discord ID copy-to-clipboard bottom
  sheet, direct server invite, YouTube channel link
- Custom-generated app icon, adaptive icon, splash screen, and an in-app
  gold queen-crown SVG watermark — no third-party image/CDN assets
- Light & dark mode, toggled from the Home app bar, persisted with
  `shared_preferences`, managed with `flutter_riverpod`
- Smooth, staggered `flutter_animate` transitions throughout
- A custom animated pill-style bottom navigation bar with a swipeable
  `PageView`, haptic feedback on every tap — built to feel like a modern
  chat app rather than a static brochure

## 🧱 Tech stack (pinned, per project requirements)

| Tool               | Version   |
|---------------------|-----------|
| Flutter             | 3.24.5    |
| Android Gradle Plugin | 8.6.0   |
| Gradle              | 8.11.1    |
| Kotlin              | 1.9.24    |
| Java                | 17        |

All pub.dev dependencies are version-pinned in `pubspec.yaml` (no `^` ranges)
and are stable, non-experimental packages.

## 📂 Project structure

```
lib/
  core/            theme, colors, text styles, constants, shared widgets, config
  data/            models + static content repository (mirrors the website copy)
  providers/       cross-cutting Riverpod providers (nav index)
  presentation/
    splash/        animated launch screen
    shell/         MainShell (PageView) + animated bottom nav bar
    home/          Home tab
    portfolio/     Portfolio grid + native video player screen
    expertise/     "Grandmaster Service" feature list
    contact/       Contact tab + Discord bottom sheet
android/           Native Android project (Gradle/Kotlin/Java configured as above)
assets/images/     Custom-generated app icon, splash icon, SVG watermark
test/              Widget smoke test
```

## 🔐 Environment variables

This app has **no backend and no API keys** — it's a static content
portfolio app — so nothing here is a secret in the traditional sense.
Still, every externally-owned value is injected at **build time** via
`--dart-define` rather than hardcoded, so the brand's links/IDs can be
changed without touching source code, and so the pattern is in place for
any secret added in the future (e.g. an analytics key).

| Variable              | Required? | Default (current MDY Chess value)     | Purpose                                    |
|------------------------|-----------|-----------------------------------------|---------------------------------------------|
| `YOUTUBE_CHANNEL_URL`  | No        | `https://youtube.com/@mdy_chess`        | "Visit Channel" / "Visit My Channel" links   |
| `DISCORD_INVITE_URL`   | No        | `https://discord.gg/T5ssgD2q2`          | "Join My Server" link                        |
| `DISCORD_ID`           | No        | `MDYChess`                              | Shown + copied in the Discord contact sheet  |
| `ANALYTICS_ENABLED`    | No        | `false`                                 | Reserved feature flag, currently unused      |

Pass them at build time, e.g.:

```bash
flutter build apk --release \
  --dart-define=YOUTUBE_CHANNEL_URL=https://youtube.com/@mdy_chess \
  --dart-define=DISCORD_INVITE_URL=https://discord.gg/T5ssgD2q2 \
  --dart-define=DISCORD_ID=MDYChess
```

### Release signing (optional, for a signed release APK/AAB)

Signing is resolved **only** from environment variables in
`android/app/build.gradle` — nothing is hardcoded, and the app still builds
fine (falling back to the Android debug keystore) if these are absent.

| Variable                | Required?                     | Description                                  |
|--------------------------|-------------------------------|-----------------------------------------------|
| `MDY_KEYSTORE_PATH`      | Only for signed release builds| Absolute path to your upload keystore (`.jks`)|
| `MDY_KEYSTORE_PASSWORD`  | Only for signed release builds| Keystore password                             |
| `MDY_KEY_ALIAS`          | Only for signed release builds| Key alias inside the keystore                 |
| `MDY_KEY_PASSWORD`       | Only for signed release builds| Key password                                  |

In Codemagic, set these as **encrypted** variables inside the `mdy_signing`
environment variable group referenced in `codemagic.yaml`. Locally, you can
export them in your shell or place an (untracked) `android/key.properties`
file with `storeFile`, `storePassword`, `keyAlias`, `keyPassword` keys.

## 🚀 Getting started

```bash
flutter pub get
dart run flutter_launcher_icons          # regenerates the launcher icon set
dart run flutter_native_splash:create    # regenerates the native splash screen
flutter run
```

## 📦 Building a release APK

```bash
flutter build apk --release
```

The output APK is written to `build/app/outputs/flutter-apk/app-release.apk`.

## ☁️ CI/CD

`codemagic.yaml` defines a ready-to-use `mdy-chess-android` workflow:
pub get → generate icons/splash → analyze → test → build release APK →
upload artifacts. Attach the `mdy_signing` and `mdy_content` variable
groups in the Codemagic dashboard (see table above) before running it.

## ✅ Pre-flight audit

- [x] All package versions pinned in `pubspec.yaml` (no caret ranges)
- [x] No deprecated widgets — uses `CardTheme` (correct for Flutter 3.24.5;
      note this class is renamed to `CardThemeData` in later Flutter
      releases, so re-check this call site if you upgrade the SDK)
- [x] `AndroidManifest.xml` declares only `INTERNET` (required for YouTube
      thumbnails/playback and outbound Discord/YouTube links); a `<queries>`
      block lets `url_launcher` detect the YouTube/Discord apps without
      requesting the broader `QUERY_ALL_PACKAGES` permission
- [x] All environment variables listed above (content config + signing)
- [x] No placeholder screens — Home, Portfolio, Expertise, Contact, the
      video player, and the splash screen are all fully implemented
- [x] No hardcoded secrets — none exist in this app; all external links are
      `--dart-define` overridable; signing reads only from env vars
- [x] No experimental/unstable packages; no `lucide_icons`/CDN icon fonts —
      icons come from `flutter_lucide` and one hand-authored SVG asset

## Notes

- This project targets **Android only**, matching the specified toolchain
  (AGP/Gradle/Kotlin/Java are all Android-specific). No `ios/` directory is
  included.
- Video playback uses `youtube_player_flutter` **9.1.3** — pinned deliberately
  to the 9.x line rather than the newer major rewrite (v10), because v10
  raises its minimum SDK to Flutter ≥3.38/Dart ≥3.10, which is incompatible
  with the pinned Flutter 3.24.5 toolchain. Version 9.1.0+ is the exact
  release line that officially targets Flutter 3.24/Dart 3.5. Under the
  hood it renders the YouTube IFrame Player API via `flutter_inappwebview` —
  this is the closest stable, non-experimental Flutter equivalent to the
  raw `<iframe>` embed the original website uses; there is no way to embed
  a YouTube player on Android without some form of WebView, since that's
  how the official IFrame Player API itself works.
- **General dependency policy**: every pinned version in `pubspec.yaml` was
  chosen to satisfy two constraints at once — (1) stable, non-experimental,
  and (2) compatible with the pinned Flutter 3.24.5/Dart ≥3.5 SDK. Where a
  package's newest release had already moved its SDK floor past 3.24.5
  (as with `youtube_player_flutter` above), the last release still inside
  that floor was chosen instead. If you upgrade the Flutter version, re-run
  `flutter pub outdated` and re-pin deliberately rather than blindly
  accepting `flutter pub upgrade --major-versions`.
