import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer(
      {super.key,
      this.height,
      this.width,
      this.border,
      this.borderRadius,
      this.color,
      this.boxShape,
      this.gradient,
      this.child,
      this.image,
      this.onTap,
      this.boxShadow});
  final double? height;
  final double? width;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final BoxShape? boxShape;
  final Gradient? gradient;
  final Widget? child;
  final List<BoxShadow>? boxShadow;
  final DecorationImage? image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: boxShape ?? BoxShape.rectangle,
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          color: color,
          gradient: gradient,
          image: image,
        ),
        child: child,
      ),
    );
  }
}
