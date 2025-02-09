import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management_app/presentation/widgets/common_boxshadow_container.dart';
import 'package:task_management_app/utils/color.dart';
import 'package:task_management_app/utils/text_styles.dart';

class SyncButton extends StatefulWidget {
  final bool needToUpdate;
  final VoidCallback onSync;

  const SyncButton(
      {super.key, required this.needToUpdate, required this.onSync});

  @override
  State<SyncButton> createState() => _SyncButtonState();
}

class _SyncButtonState extends State<SyncButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    // ✅ Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // ✅ Define the shaking animation
    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticIn),
    );

    // ✅ Start shaking when `needToUpdate` is true
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.needToUpdate) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void didUpdateWidget(covariant SyncButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.needToUpdate && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.needToUpdate) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0), // ✅ Move left & right
          child: CommonBoxshadowContainer(
            height: 40.h,
            width: 140.w,
            color: greenColor,
            onTap: widget.onSync,
            child: Center(
              child: Text(
                "Sync",
                style: subHeadingStyle.copyWith(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
