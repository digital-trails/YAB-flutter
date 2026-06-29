import 'package:flutter/material.dart';

import '../theme.dart';

/// Full-screen solid-color splash overlay that scales down and fades out,
/// mirroring `AnimatedSplashOverlay` in src/components/animated-icon.tsx.
class AnimatedSplashOverlay extends StatefulWidget {
  const AnimatedSplashOverlay({super.key});

  @override
  State<AnimatedSplashOverlay> createState() => _AnimatedSplashOverlayState();
}

class _AnimatedSplashOverlayState extends State<AnimatedSplashOverlay>
    with SingleTickerProviderStateMixin {
  static const _duration = Duration(milliseconds: 600);

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: _duration);

  // Opacity holds at 1 until 20%, then fades to 0 by 70%.
  late final Animation<double> _opacity = TweenSequence<double>([
    TweenSequenceItem(tween: ConstantTween(1), weight: 20),
    TweenSequenceItem(
      tween: Tween(begin: 1, end: 0).chain(CurveTween(curve: Curves.easeOut)),
      weight: 50,
    ),
    TweenSequenceItem(tween: ConstantTween(0), weight: 30),
  ]).animate(_controller);

  // Scale eases from a large initial factor down to 1.
  late final Animation<double> _scale =
      Tween(begin: 6.0, end: 1.0).animate(
    CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
  );

  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _controller.forward().whenComplete(() {
      if (mounted) setState(() => _visible = false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();

    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacity.value.clamp(0.0, 1.0),
              child: Transform.scale(scale: _scale.value, child: child),
            );
          },
          child: Container(
            color: kSplashColor,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/expo-logo.png',
              width: 76,
              height: 71,
            ),
          ),
        ),
      ),
    );
  }
}
