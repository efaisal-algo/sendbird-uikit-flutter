// Copyright (c) 2024 Sendbird, Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_uikit/src/internal/component/base/sbu_base_component.dart';
import 'package:sendbird_uikit/src/internal/component/basic/sbu_image_component.dart';

/// Custom bottom sheet component for confirming leave channel action
/// Figma: https://www.figma.com/design/EEp6rAIHdLYs9yiBZo7NGF/Eval---2025-Draft-1?node-id=2342-23256
class SBULeaveChannelBottomSheet extends SBUStatefulComponent {
  final GroupChannel channel;
  final String channelName;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const SBULeaveChannelBottomSheet({
    required this.channel,
    required this.channelName,
    required this.onConfirm,
    required this.onCancel,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SBULeaveChannelBottomSheetState();
}

class _SBULeaveChannelBottomSheetState
    extends State<SBULeaveChannelBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF), // White background
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000), // rgba(0,0,0,0.15)
            offset: Offset(0, -4),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar at top
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Container(
              width: 24,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF9A9A9A), // Secondary color
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar and heading section
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Channel Avatar - 80x80px
                    _buildChannelAvatar(),

                    const SizedBox(height: 16),

                    // Heading text
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // "Are you sure you want to leave: "
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Are you sure you want to leave: ',
                            style: TextStyle(
                              fontFamily: 'SfProText',
                              fontSize: 20,
                              fontWeight: FontWeight.w500, // Medium
                              color: Color(0xFF595959), // Main 2 color
                              letterSpacing: -0.8,
                              height: 1.0,
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Channel name
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            widget.channelName,
                            style: const TextStyle(
                              fontFamily: 'SfProText',
                              fontSize: 20,
                              fontWeight: FontWeight.w500, // Medium
                              color: Color(0xFF171717), // Main color
                              letterSpacing: -0.8,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Buttons section
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          widget.onCancel();
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: const Color(0xFF595959), // Main 2 color
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: 'SfProText',
                              fontSize: 16,
                              fontWeight: FontWeight.w500, // Medium
                              color: Color(0xFF595959), // Main 2 color
                              letterSpacing: -0.32,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 11),

                    // Leave Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          widget.onConfirm();
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF7A00), // Accent color
                            borderRadius: BorderRadius.circular(100),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Text(
                            'Leave',
                            style: TextStyle(
                              fontFamily: 'SfProText',
                              fontSize: 16,
                              fontWeight: FontWeight.w500, // Medium
                              color: Color(0xFFFFFFFF), // White
                              letterSpacing: -0.32,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom slider container
          const SizedBox(height: 28),
          SizedBox(
            height: 34,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  width: 135,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF171717), // Main color
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelAvatar() {
    final coverUrl = widget.channel.coverUrl;

    return SizedBox(
      width: 80,
      height: 80,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color:
                const Color(0xFFFF7A00), // Orange border - same as Leave button
            width: 1,
          ),
        ),
        child: ClipOval(
          child: coverUrl.isNotEmpty
              ? SBUImageComponent(
                  imageUrl: coverUrl,
                  cacheKey: coverUrl,
                )
              : Container(
                  color: const Color(0xFFE0E0E0),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Color(0xFF9A9A9A),
                  ),
                ),
        ),
      ),
    );
  }
}
