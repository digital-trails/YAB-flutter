import 'package:flutter/material.dart';

import 'screens/explore_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'theme.dart';
import 'widgets/animated_splash.dart';

void main() => runApp(const YabApp());

class YabApp extends StatelessWidget {
  const YabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YAB',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: _buildTheme(AppColors.light, Brightness.light),
      darkTheme: _buildTheme(AppColors.dark, Brightness.dark),
      home: const RootShell(),
    );
  }

  ThemeData _buildTheme(AppColors c, Brightness brightness) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: c.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kSplashColor,
        brightness: brightness,
      ).copyWith(surface: c.background),
      useMaterial3: true,
    );
  }
}

/// Holds the tab state and overlays the animated splash on first launch.
/// Mirrors the Tabs layout + AnimatedSplashOverlay in src/app/_layout.tsx.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  static const _screens = [
    HomeScreen(),
    ExploreScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  static const _tabs = [
    _TabSpec('Home', Icons.home, Icons.home_outlined),
    _TabSpec('Explore', Icons.search, Icons.search_outlined),
    _TabSpec('Profile', Icons.person, Icons.person_outline),
    _TabSpec('Settings', Icons.settings, Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _index, children: _screens),
          const AnimatedSplashOverlay(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colors.background,
          border: Border(top: BorderSide(color: colors.backgroundElement)),
        ),
        child: SafeArea(
          top: false,
          child: BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            type: BottomNavigationBarType.fixed,
            backgroundColor: colors.background,
            elevation: 0,
            selectedItemColor: colors.text,
            unselectedItemColor: colors.textSecondary,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            items: [
              for (var i = 0; i < _tabs.length; i++)
                BottomNavigationBarItem(
                  label: _tabs[i].label,
                  icon: Icon(_tabs[i].outline),
                  activeIcon: Icon(_tabs[i].filled),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabSpec {
  const _TabSpec(this.label, this.filled, this.outline);
  final String label;
  final IconData filled;
  final IconData outline;
}
