// Copyright (c) 2024 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_uikit/sendbird_uikit.dart';
import 'package:sendbird_uikit/src/internal/component/base/sbu_base_component.dart';
import 'package:sendbird_uikit/src/internal/component/basic/sbu_dialog_menu_component.dart';
import 'package:sendbird_uikit/src/internal/component/basic/sbu_icon_button_component.dart';
import 'package:sendbird_uikit/src/internal/component/basic/sbu_icon_component.dart';
import 'package:sendbird_uikit/src/internal/component/basic/sbu_text_component.dart';
import 'package:sendbird_uikit/src/internal/resource/sbu_text_styles.dart';

enum SBUModerationType {
  members,
  operators,
  mutedMembers,
  bannedUsers,
}

/// Custom avatar widget for member list items
class _MemberAvatar extends StatelessWidget {
  final User user;
  final double size;
  final bool isLightTheme;

  const _MemberAvatar({
    required this.user,
    required this.size,
    required this.isLightTheme,
  });

  String _getInitials(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) return '';

    final words = trimmedName.split(' ');
    if (words.length >= 2) {
      // Get first char from first two words
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else {
      // Get first two chars from single word
      return trimmedName.length >= 2
          ? trimmedName.substring(0, 2).toUpperCase()
          : trimmedName[0].toUpperCase();
    }
  }

  Color _getBackgroundColor() {
    // Light background color for initials
    return isLightTheme
        ? const Color(0xFFFFF4E8) // Light peach/orange background
        : const Color(0xFF3E3E3E); // Dark theme background
  }

  Color _getTextColor() {
    return isLightTheme
        ? const Color(0xFFFF8A00) // Orange text
        : const Color(0xFFFFB74D); // Light orange for dark theme
  }

  Color _getBorderColor() {
    return isLightTheme
        ? const Color(0xFFFF8A00) // Orange border
        : const Color(0xFFFFB74D); // Light orange for dark theme
  }

  @override
  Widget build(BuildContext context) {
    final profileUrl = user.profileUrl;
    final hasImage = profileUrl.isNotEmpty;
    final nickname = user.nickname.isEmpty ? user.userId : user.nickname;
    final initials = _getInitials(nickname);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _getBorderColor(),
          width: 1,
        ),
        color: hasImage ? Colors.transparent : _getBackgroundColor(),
      ),
      child: ClipOval(
        child: hasImage
            ? Image.network(
                profileUrl,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to initials if image fails to load
                  return Container(
                    color: _getBackgroundColor(),
                    child: Center(
                      child: Text(
                        initials,
                        style: TextStyle(
                          color: _getTextColor(),
                          fontSize: size * 0.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    color: _getTextColor(),
                    fontSize: size * 0.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }
}

class SBUUserListItemComponent extends SBUStatefulComponent {
  final double width;
  final double height;
  final Color backgroundColor;
  final GroupChannel channel;
  final User user;
  final bool canOperate;
  final SBUModerationType moderationType;

  const SBUUserListItemComponent({
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.channel,
    required this.user,
    required this.canOperate,
    required this.moderationType,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => SBUUserListItemComponentState();
}

class SBUUserListItemComponentState extends State<SBUUserListItemComponent> {
  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.watch<SBUThemeProvider>().isLight();
    final strings = context.watch<SBUStringProvider>().strings;

    final width = widget.width;
    final height = widget.height;
    final backgroundColor = widget.backgroundColor;
    final channel = widget.channel;
    final user = widget.user;
    final canOperate = widget.canOperate;

    bool isYou = false;
    String name = widget.getNickname(user, strings);
    if (user.userId == SendbirdChat.currentUser?.userId) {
      isYou = true;
      name += ' (${strings.you})';
    }

    final isOperator = user is Member && user.role == Role.operator;
    final isMuted = user is Member && user.isMuted;

    final item = Container(
      width: width,
      height: height,
      color: backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: _MemberAvatar(
              user: user,
              size: 36,
              isLightTheme: isLightTheme,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: SBUTextComponent(
                              text: name,
                              textType: SBUTextType.subtitle2,
                              textColorType: SBUTextColorType.text01,
                            ),
                          ),
                        ),
                        if (isOperator)
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: SBUTextComponent(
                              text: strings.operator,
                              textType: SBUTextType.body2,
                              textColorType: SBUTextColorType.text02,
                            ),
                          ),
                        if (canOperate)
                          Material(
                            color: Colors.transparent,
                            child: SBUIconButtonComponent(
                              iconButtonSize: 32,
                              icon: SBUIconComponent(
                                iconSize: 24,
                                iconData: SBUIcons.more,
                                iconColor: isYou
                                    ? isLightTheme
                                        ? SBUColors.lightThemeTextDisabled
                                        : SBUColors.darkThemeTextDisabled
                                    : isLightTheme
                                        ? SBUColors.lightThemeTextHighEmphasis
                                        : SBUColors.darkThemeTextHighEmphasis,
                              ),
                              onButtonClicked: isYou
                                  ? null
                                  : () async {
                                      final isOperatorString = isOperator
                                          ? strings.unregisterOperator
                                          : strings.registerAsOperator;
                                      final isMutedString = isMuted
                                          ? strings.unmute
                                          : strings.mute;

                                      List<String> buttonNames;
                                      switch (widget.moderationType) {
                                        case SBUModerationType.members:
                                          buttonNames = [
                                            isOperatorString,
                                            isMutedString,
                                            strings.ban,
                                          ];
                                          break;
                                        case SBUModerationType.operators:
                                          buttonNames = [
                                            isOperatorString,
                                          ];
                                          break;
                                        case SBUModerationType.mutedMembers:
                                          buttonNames = [
                                            isMutedString,
                                          ];
                                          break;
                                        case SBUModerationType.bannedUsers:
                                          buttonNames = [
                                            strings.unban,
                                          ];
                                          break;
                                      }

                                      await showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) =>
                                            SBUDialogMenuComponent(
                                          title:
                                              widget.getNickname(user, strings),
                                          buttonNames: buttonNames,
                                          onButtonClicked: (buttonName) async {
                                            runZonedGuarded(() async {
                                              if (buttonName ==
                                                  isOperatorString) {
                                                if (isOperator) {
                                                  await channel.removeOperators(
                                                      [user.userId]);
                                                } else {
                                                  await channel.addOperators(
                                                      [user.userId]);
                                                }
                                              } else if (buttonName ==
                                                  isMutedString) {
                                                if (isMuted) {
                                                  await channel.unmuteUser(
                                                      userId: user.userId);
                                                } else {
                                                  await channel.muteUser(
                                                      userId: user.userId);
                                                }
                                              } else if (buttonName ==
                                                  strings.ban) {
                                                await channel.banUser(
                                                    userId: user.userId);
                                              } else if (buttonName ==
                                                  strings.unban) {
                                                await channel.unbanUser(
                                                    userId: user.userId);
                                              }
                                            }, (error, stack) {
                                              // TODO: Check error
                                            });
                                          },
                                          errorColorIndex: 2,
                                        ),
                                      );
                                    },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: isLightTheme
                      ? SBUColors.lightThemeTextDisabled
                      : SBUColors.darkThemeTextDisabled,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return item;
  }
}
