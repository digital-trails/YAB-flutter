import 'package:flutter/material.dart';

import '../widgets/screen_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenContainer(
      title: 'Profile',
      subtitle: 'Account details and user info go here.',
      children: [
        AppCard(
          title: 'User',
          body: "Show the signed-in user's name, avatar, and profile fields on this screen.",
        ),
        AppCard(
          title: 'Activity',
          body: 'Recent activity or stats can live here.',
        ),
      ],
    );
  }
}
