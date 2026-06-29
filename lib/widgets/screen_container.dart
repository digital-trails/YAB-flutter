import 'package:flutter/material.dart';

import '../theme.dart';

/// Shared layout for the boilerplate tab screens: a scrollable, theme-aware
/// container with a title, optional subtitle, and room for screen content.
/// Mirrors src/components/screen-container.tsx.
class ScreenContainer extends StatelessWidget {
  const ScreenContainer({
    super.key,
    required this.title,
    this.subtitle,
    this.children = const [],
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final topInset = MediaQuery.of(context).padding.top;

    return Container(
      color: colors.background,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: topInset + Spacing.six,
          bottom: Spacing.four,
          left: Spacing.four,
          right: Spacing.four,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 32,
                    height: 44 / 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: Spacing.three),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Spacing.two),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 16,
                        height: 24 / 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                for (final child in children) ...[
                  const SizedBox(height: Spacing.three),
                  child,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Simple themed card for grouping placeholder content on a screen.
class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.title, this.body});

  final String title;
  final String? body;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(Spacing.three),
      decoration: BoxDecoration(
        color: colors.backgroundElement,
        borderRadius: BorderRadius.circular(Spacing.three),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.text,
              fontSize: 14,
              height: 20 / 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (body != null) ...[
            const SizedBox(height: Spacing.two),
            Text(
              body!,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 14,
                height: 20 / 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
