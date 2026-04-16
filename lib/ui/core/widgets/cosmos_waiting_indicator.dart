import 'dart:math';

import 'package:flutter/material.dart';

class CosmosWaitingIndicator extends StatefulWidget {
  final Color? color;
  final double size;

  const CosmosWaitingIndicator({super.key, this.color, this.size = 40.0});

  @override
  State<CosmosWaitingIndicator> createState() => _CosmosWaitingIndicatorState();
}

class _CosmosWaitingIndicatorState extends State<CosmosWaitingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _CosmosWaitingIndicatorPainter(
            color: color,
            progress: _controller.value,
          ),
        );
      },
    );
  }
}

class _CosmosWaitingIndicatorPainter extends CustomPainter {
  final Color color;
  final double progress;

  const _CosmosWaitingIndicatorPainter({
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..color = color;

    final centerRadius = size.width * 0.22;
    canvas.drawCircle(center, centerRadius, paint);

    final orbitRadius = size.width * 0.36;
    final orbitingRadius = size.width * 0.1;
    final angle = progress * 2 * pi;
    final orbitingCenter = Offset(
      center.dx + orbitRadius * cos(angle),
      center.dy + orbitRadius * sin(angle),
    );
    canvas.drawCircle(orbitingCenter, orbitingRadius, paint);
  }

  @override
  bool shouldRepaint(_CosmosWaitingIndicatorPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
