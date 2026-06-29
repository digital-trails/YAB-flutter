import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../theme.dart';

/// On web, render the app inside a centered phone "device" so it reads as a
/// mobile app in the browser. On native (iOS/Android) the app already runs
/// full-screen, so this is a passthrough. Mirrors phone-frame.web.tsx /
/// phone-frame.tsx from YAB-react.
class PhoneFrame extends StatelessWidget {
  const PhoneFrame({super.key, required this.child});

  final Widget child;

  // iPhone 15/16 logical viewport, the proportions used by YAB-react.
  static const double _deviceWidth = 393;
  static const double _deviceHeight = 852;
  static const double _bezel = 11;
  static const double _statusBarHeight = 50;

  static const Color _backdrop = Color(0xFF15151A);
  static const Color _bezelColor = Color(0xFF1C1C1F);
  static const Color _buttonColor = Color(0xFF101013);

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return child;

    final colors = context.colors;

    return ColoredBox(
      color: _backdrop,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: _deviceWidth,
              height: _deviceHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Hardware buttons (sit on the metal edge).
                  const _SideButton(left: true, top: 96, height: 28),
                  const _SideButton(left: true, top: 150, height: 56),
                  const _SideButton(left: true, top: 220, height: 56),
                  const _SideButton(left: false, top: 176, height: 90),

                  // Bezel + screen.
                  Container(
                    decoration: BoxDecoration(
                      color: _bezelColor,
                      borderRadius: BorderRadius.circular(56),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x99000000),
                          blurRadius: 70,
                          offset: Offset(0, 24),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(_bezel),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: ColoredBox(
                        color: colors.background,
                        child: Column(
                          children: [
                            _StatusBar(tint: colors.text),
                            Expanded(
                              child: Padding(
                                // Leave room so the tab bar clears the home indicator.
                                padding: const EdgeInsets.only(bottom: 20),
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: child,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Dynamic Island over the status bar.
                  Positioned(
                    top: 11,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 114,
                        height: 33,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(19),
                        ),
                      ),
                    ),
                  ),

                  // Home indicator.
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 134,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.28),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar({required this.tint});

  final Color tint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: PhoneFrame._statusBarHeight,
      child: Padding(
        padding: const EdgeInsets.only(left: 28, right: 28, bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '9:41',
              style: TextStyle(
                color: tint,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Signal bars.
                for (final h in const [5.0, 8.0, 11.0, 14.0])
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Container(
                      width: 3,
                      height: h,
                      decoration: BoxDecoration(
                        color: tint,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                const SizedBox(width: 6),
                // Battery body + fill.
                Container(
                  width: 22,
                  height: 11,
                  padding: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: tint),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: tint,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                // Battery cap.
                Container(
                  width: 1.5,
                  height: 4,
                  color: tint,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SideButton extends StatelessWidget {
  const _SideButton({
    required this.left,
    required this.top,
    required this.height,
  });

  final bool left;
  final double top;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left ? -4 : null,
      right: left ? null : -4,
      child: Container(
        width: 4,
        height: height,
        decoration: BoxDecoration(
          color: PhoneFrame._buttonColor,
          borderRadius: BorderRadius.horizontal(
            left: left ? const Radius.circular(2) : Radius.zero,
            right: left ? Radius.zero : const Radius.circular(2),
          ),
        ),
      ),
    );
  }
}
