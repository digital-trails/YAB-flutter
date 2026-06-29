import 'package:flutter/material.dart';

import '../widgets/screen_container.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenContainer(
      title: 'Explore',
      subtitle: 'A placeholder screen for browsing or discovery.',
      children: [
        AppCard(
          title: 'List content',
          body:
              'Drop a ListView or your feed component here. This screen scrolls, so it is a '
              'good fit for longer content.',
        ),
        AppCard(
          title: 'Same code, three platforms',
          body: 'This screen renders on iOS, Android, and the web from a single widget.',
        ),
      ],
    );
  }
}
