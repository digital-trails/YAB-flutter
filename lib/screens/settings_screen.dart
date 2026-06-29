import 'package:flutter/material.dart';

import '../widgets/screen_container.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenContainer(
      title: 'Settings',
      subtitle: 'App preferences and configuration.',
      children: [
        AppCard(
          title: 'Appearance',
          body:
              'The app already follows the system light/dark theme. Add toggles or options here.',
        ),
        AppCard(
          title: 'About',
          body: 'YAB · version 1.0.0',
        ),
      ],
    );
  }
}
