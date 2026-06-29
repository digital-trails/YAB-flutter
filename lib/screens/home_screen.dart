import 'package:flutter/material.dart';

import '../widgets/screen_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenContainer(
      title: 'Home',
      subtitle: 'Welcome to YAB. This is your starting point.',
      children: [
        AppCard(
          title: 'Getting started',
          body:
              'Edit lib/screens/home_screen.dart to change this screen. Screens live in '
              'lib/screens and are wired into the tab bar in main.dart.',
        ),
        AppCard(
          title: 'Navigation',
          body: 'Use the tab bar to move between Home, Explore, Profile, and Settings.',
        ),
      ],
    );
  }
}
