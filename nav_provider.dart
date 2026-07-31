import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Index of the active bottom-navigation tab, shared between the
/// [MainShell]'s PageView and its animated nav bar so both stay in sync
/// whether the user taps a tab or swipes between pages.
final navIndexProvider = StateProvider<int>((ref) => 0);
