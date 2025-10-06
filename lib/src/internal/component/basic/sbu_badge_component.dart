// Copyright (c) 2024 Sendbird, Inc. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_uikit/sendbird_uikit.dart';
import 'package:sendbird_uikit/src/internal/component/base/sbu_base_component.dart';
import 'package:sendbird_uikit/src/internal/component/basic/sbu_text_component.dart';
import 'package:sendbird_uikit/src/internal/resource/sbu_text_styles.dart';

class SBUBadgeComponent extends SBUStatefulComponent {
  final int count;
  final bool isLarge; // height 20 or 16

  final double _height;

  const SBUBadgeComponent({
    required this.count,
    required this.isLarge,
    super.key,
  }) : _height = isLarge ? 20 : 16;

  @override
  State<StatefulWidget> createState() => SBUBadgeComponentState();
}

class SBUBadgeComponentState extends State<SBUBadgeComponent> {
  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.watch<SBUThemeProvider>().isLight();

    final count = widget.count;
    final isLarge = widget.isLarge;
    final height = widget._height;

    final String number = count > 99 ? '99+' : count.toString();
    final text = SBUTextComponent(
      text: number,
      textType: SBUTextType.caption1,
      textColorType: SBUTextColorType.badge,
    );

    Color color;
    if (isLarge) {
      color = isLightTheme
          ? const Color(
              0xFF9E9E9E) // Grey background for unread count as per Figma
          : SBUColors.primaryLight;
    } else {
      color = isLightTheme ? SBUColors.errorMain : SBUColors.errorLight;
    }

    return Container(
      height: height,
      constraints: BoxConstraints(
        minWidth:
            height, // Ensure minimum width equals height for circular badges
      ),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(height / 2), // Perfect circular radius
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}
