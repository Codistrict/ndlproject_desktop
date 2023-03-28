import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../themes/colors.dart';

class CustomFAB extends StatefulWidget {
  final double? size;
  final Curve curve;
  final bool visible;
  final Color iconColor;
  final Color backgroundColor;
  final List<SpeedDialChild> children;
  final AnimatedIconData icon;
  const CustomFAB(
      {super.key,
      this.size = 22,
      this.curve = Curves.bounceIn,
      this.visible = true,
      this.iconColor = primaryColor,
      this.backgroundColor = secondaryColor,
      required this.icon,
      required this.children});

  @override
  State<CustomFAB> createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: widget.icon,
      animatedIconTheme:
          IconThemeData(size: widget.size, color: widget.iconColor),
      backgroundColor: widget.backgroundColor,
      visible: widget.visible,
      curve: widget.curve,
      children: widget.children,
    );
  }
}
