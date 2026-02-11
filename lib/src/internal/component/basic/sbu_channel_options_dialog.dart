// Copyright (c) 2024 Sendbird, Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_uikit/sendbird_uikit.dart';
import 'package:sendbird_uikit/src/internal/component/base/sbu_base_component.dart';

/// Custom dialog component for channel options based on Figma design
/// Figma: https://www.figma.com/design/EEp6rAIHdLYs9yiBZo7NGF/Eval---2025-Draft-1?node-id=2396-22443
class SBUChannelOptionsDialog extends SBUStatefulComponent {
  final String title;
  final bool isPushOff;
  final VoidCallback onTurnOffNotifications;
  final VoidCallback onDeleteAndLeave;

  const SBUChannelOptionsDialog({
    required this.title,
    required this.isPushOff,
    required this.onTurnOffNotifications,
    required this.onDeleteAndLeave,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SBUChannelOptionsDialogState();
}

class _SBUChannelOptionsDialogState extends State<SBUChannelOptionsDialog> {
  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.watch<SBUThemeProvider>().isLight();
    final strings = context.watch<SBUStringProvider>().strings;

    // Get the notification action text based on current push status
    final notificationText = widget.isPushOff
        ? strings.turnPushNotificationOn
        : strings.turnPushNotificationOff;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        decoration: BoxDecoration(
          color:
              isLightTheme ? SBUColors.background50 : SBUColors.background500,
          border: Border.all(
            color: isLightTheme
                ? SBUColors.background100
                : SBUColors.background400,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Centered Title
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 4),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'SfProText',
                  fontSize: 16,
                  fontWeight: FontWeight.w500, // Medium - 500
                  color: isLightTheme
                      ? SBUColors.lightThemeTextHighEmphasis
                      : SBUColors.darkThemeTextHighEmphasis,
                  letterSpacing: -0.64,
                  height: 1.0,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Menu Items Column
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Turn off/on notifications option - 38px height from Figma
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onTurnOffNotifications();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              notificationText,
                              style: TextStyle(
                                fontFamily: 'SfProText',
                                fontSize: 15,
                                fontWeight: FontWeight.w400, // Regular
                                color: isLightTheme
                                    ? SBUColors.lightThemeTextHighEmphasis
                                    : SBUColors.darkThemeTextHighEmphasis,
                                letterSpacing: -0.3,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Notification icon - 17x17px positioned at y=10.5
                        Padding(
                          padding: const EdgeInsets.only(top: 10.5),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isLightTheme
                                  ? Colors.transparent
                                  : SBUColors.darkThemeTextHighEmphasis,
                              isLightTheme ? BlendMode.dst : BlendMode.srcIn,
                            ),
                            child: Image.asset(
                              'assets/icons/ic_notification_off.png',
                              width: 17,
                              height: 17,
                              package: 'sendbird_uikit',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Delete and leave chat option - 38px height from Figma
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onDeleteAndLeave();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              strings.leaveChannel,
                              style: TextStyle(
                                fontFamily: 'SfProText',
                                fontSize: 15,
                                fontWeight: FontWeight.w400, // Regular
                                color: isLightTheme
                                    ? SBUColors.errorMain
                                    : SBUColors.errorLight,
                                letterSpacing: -0.3,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Delete icon - 17x17px positioned at y=10.5
                        Padding(
                          padding: const EdgeInsets.only(top: 10.5),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isLightTheme
                                  ? Colors.transparent
                                  : SBUColors.errorLight,
                              isLightTheme ? BlendMode.dst : BlendMode.srcIn,
                            ),
                            child: Image.asset(
                              'assets/icons/ic_delete.png',
                              width: 17,
                              height: 17,
                              package: 'sendbird_uikit',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
