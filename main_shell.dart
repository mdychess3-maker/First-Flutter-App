import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/nav_provider.dart';
import '../contact/contact_screen.dart';
import '../expertise/expertise_screen.dart';
import '../home/home_screen.dart';
import '../portfolio/portfolio_screen.dart';
import 'widgets/animated_nav_bar.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  late final PageController _controller;

  static const _pages = [
    HomeScreen(),
    PortfolioScreen(),
    ExpertiseScreen(),
    ContactScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: ref.read(navIndexProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    ref.read(navIndexProvider.notifier).state = index;
  }

  void _onPageChanged(int index) {
    ref.read(navIndexProvider.notifier).state = index;
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = ref.watch(navIndexProvider);

    // Any source of truth (tab tap, or a CTA button on another screen such
    // as Home's "View My Edits") flows through navIndexProvider. Whenever
    // it changes and doesn't already match the visible page, animate the
    // PageView there — keeps every entry point perfectly in sync.
    ref.listen<int>(navIndexProvider, (previous, next) {
      final current = _controller.hasClients ? _controller.page?.round() : null;
      if (current != next) {
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 380),
          curve: Curves.easeOutCubic,
        );
      }
    });

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _controller,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: AnimatedNavBar(
        activeIndex: activeIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
