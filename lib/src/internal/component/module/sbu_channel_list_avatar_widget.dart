// Copyright (c) 2024 Sendbird, Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_uikit/sendbird_uikit.dart';
import 'package:sendbird_uikit/src/internal/component/basic/sbu_image_component.dart';

/// Custom avatar widget for channel list items with theme-aware background and rounded square shape
class SBUChannelListAvatarWidget extends StatelessWidget {
  final GroupChannel channel;
  final double size;

  const SBUChannelListAvatarWidget({
    required this.channel,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.watch<SBUThemeProvider>().isLight();

    // Get the cover image URL or first member's profile URL
    String? imageUrl = _getImageUrl();

    // Use theme-aware background color from SBUColors
    final backgroundColor =
        isLightTheme ? SBUColors.background50 : SBUColors.background500;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4), // 4px rounded corners
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null && imageUrl.isNotEmpty
          ? SBUImageComponent(
              imageUrl: imageUrl,
              cacheKey: imageUrl,
            )
          : _buildPlaceholder(isLightTheme),
    );
  }

  String? _getImageUrl() {
    // Check if channel has a custom cover URL
    final isDefaultCoverUrl = channel.coverUrl
        .startsWith('https://static.sendbird.com/sample/cover/cover_');

    if (channel.coverUrl.isNotEmpty && !isDefaultCoverUrl) {
      return channel.coverUrl;
    }

    // Get first member's profile URL (excluding current user)
    final members = channel.members;
    for (final member in members) {
      if (member.userId != SendbirdChat.currentUser?.userId) {
        if (member.profileUrl.isNotEmpty) {
          return member.profileUrl;
        }
      }
    }

    return null;
  }

  Widget _buildPlaceholder(bool isLightTheme) {
    // Theme-aware placeholder using SBUColors
    return Container(
      color: isLightTheme ? SBUColors.background200 : SBUColors.background400,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: SBUColors.background300,
          size: 32,
        ),
      ),
    );
  }
}
