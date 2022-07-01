import 'package:flutter/material.dart';

class AnimatedEntryExitWidget extends StatefulWidget {
  final double dimension;
  final bool showFace;
  final VoidCallback onDisappear;
  final Widget child;

  const AnimatedEntryExitWidget({
    Key? key,
    required this.child,
    required this.dimension,
    required this.showFace,
    required this.onDisappear,
  }) : super(key: key);
  @override
  State<AnimatedEntryExitWidget> createState() {
    return _AnimatedEntryExitWidgetState();
  }
}

class _AnimatedEntryExitWidgetState extends State<AnimatedEntryExitWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) widget.onDisappear();
    });

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _syncScaleAnimation();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    _syncScaleAnimation();
  }

  void _syncScaleAnimation() {
    if (widget.showFace &&
        !_scaleController.isCompleted &&
        _scaleController.status != AnimationStatus.forward) {
      _scaleController.forward();
    } else if (!widget.showFace &&
        !_scaleController.isDismissed &&
        _scaleController.status != AnimationStatus.reverse) {
      _scaleController.reverse();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.dimension,
      height: widget.dimension,
      child: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: widget.child,
            );
          },
        ),
      ),
    );
  }
}
