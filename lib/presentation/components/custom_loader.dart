import 'dart:math' as Math;

import 'package:flutter/material.dart';

class DotsLoader extends StatefulWidget {
  final Color? color;
  const DotsLoader(this.color, {super.key});

  @override
  State<DotsLoader> createState() => _DotsLoaderState();
}

class _DotsLoaderState extends State<DotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        // Use a sine wave offset, each dot shifted in phase
        final dot1 = _waveShift(0.0);
        final dot2 = _waveShift(0.33);
        final dot3 = _waveShift(0.66);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, dot1),
              child: _dot(widget.color),
            ),
            const SizedBox(width: 6),
            Transform.translate(
              offset: Offset(0, dot2),
              child: _dot(widget.color),
            ),
            const SizedBox(width: 6),
            Transform.translate(
              offset: Offset(0, dot3),
              child: _dot(widget.color),
            ),
          ],
        );
      },
    );
  }

  /// Function that returns a smooth up/down offset like a wave
  double _waveShift(double phase) {
    final progress = (_controller.value + phase) % 1.0;
    return -6 * (0.5 * (1 - Math.cos(progress * 2 * 3.1416)));
  }

  Widget _dot(Color? color) => Container(
    width: 6,
    height: 6,
    decoration: BoxDecoration(
      color: color ?? Colors.white,
      shape: BoxShape.circle,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
