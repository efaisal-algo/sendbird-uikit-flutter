// Copyright (c) 2024 Sendbird, Inc. All rights reserved.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_uikit/sendbird_uikit.dart';
import 'package:sendbird_uikit/src/internal/component/base/sbu_base_component.dart';
import 'package:sendbird_uikit/src/internal/component/basic/sbu_icon_component.dart';
import 'package:sendbird_uikit/src/internal/component/basic/sbu_image_component.dart';

class SBUAvatarComponent extends SBUStatefulComponent {
  final double width;
  final double height;
  final SBUIconComponent? icon;
  final Color? backgroundColor;
  final List<String>? imageUrls;
  final bool isMutedMember;
  final String? userInitials;
  final bool showBorder;

  const SBUAvatarComponent({
    required this.width,
    required this.height,
    this.icon,
    this.backgroundColor,
    this.imageUrls,
    this.isMutedMember = false,
    this.userInitials,
    this.showBorder = false,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => SBUAvatarComponentState();
}

class SBUAvatarComponentState extends State<SBUAvatarComponent> {
  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.watch<SBUThemeProvider>().isLight();

    final width = widget.width;
    final height = widget.height;
    final icon = widget.icon;
    final backgroundColor = widget.backgroundColor;
    final isMutedMember = widget.isMutedMember;
    final userInitials = widget.userInitials;
    final showBorder = widget.showBorder;

    const orangeColor = Color(0xFFFF7A00);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: showBorder
            ? orangeColor.withOpacity(0.1) // Orange with 10% opacity
            : (isLightTheme ? SBUColors.background50 : SBUColors.background600),
        borderRadius:
            BorderRadius.circular(width / 2), // Make it perfectly circular
        border: showBorder
            ? Border.all(
                color: orangeColor, // Orange border
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color:
                (isLightTheme ? Colors.black : Colors.white).withOpacity(0.04),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(
            showBorder ? 0.5 : 0), // 0.5 padding when border is shown
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
              (width - (showBorder ? 1 : 0)) / 2), // Make it perfectly circular
          child: Stack(
            children: [
              _getAvatarImage(isLightTheme) ?? Container(),
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(
                      width / 2), // Make it perfectly circular
                ),
              ),
              if (icon != null && userInitials == null)
                Padding(
                  padding: EdgeInsets.all(
                      max((width - icon.iconSize) / 2, 0) as double),
                  child: icon,
                ),
              if (userInitials != null)
                Center(
                  child: Text(
                    userInitials,
                    style: TextStyle(
                      fontSize: width * 0.4,
                      fontWeight: FontWeight.w600,
                      color: isLightTheme
                          ? SBUColors.darkThemeTextHighEmphasis
                          : SBUColors.lightThemeTextHighEmphasis,
                    ),
                  ),
                ),
              if (isMutedMember)
                Stack(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        color: SBUColors.primaryMain.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(
                            width / 2), // Make it perfectly circular
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          max((width - width * 0.71428571428) / 2, 0)
                              as double),
                      child: SBUIconComponent(
                        iconSize: width * 0.71428571428,
                        iconData: SBUIcons.mute,
                        iconColor: SBUColors.darkThemeTextHighEmphasis,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImage(
    bool isLightTheme,
    String imageUrl,
    double width,
    double height,
  ) {
    if (imageUrl.isEmpty) {
      double size = max(width, height);
      return SizedBox(
        width: width,
        height: height,
        child: Container(
          width: size,
          height: size,
          color: SBUColors.background300,
          child: SBUIconComponent(
            iconSize: size * 0.57142857142,
            iconData: SBUIcons.user,
            iconColor: isLightTheme
                ? SBUColors.darkThemeTextHighEmphasis
                : SBUColors.lightThemeTextHighEmphasis,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: width,
        height: height,
        child: SBUImageComponent(
          imageUrl: imageUrl,
          cacheKey: imageUrl,
        ),
      );
    }
  }

  Widget? _getAvatarImage(bool isLightTheme) {
    final imageUrls = widget.imageUrls;

    if (imageUrls != null) {
      switch (imageUrls.length) {
        case 1:
          return _oneImageInCircle(isLightTheme, imageUrls[0]);
        case 2:
          return _twoImagesInCircle(isLightTheme, imageUrls[0], imageUrls[1]);
        case 3:
          return _threeImagesInCircle(
              isLightTheme, imageUrls[0], imageUrls[1], imageUrls[2]);
        case 4:
          return _fourImagesInCircle(isLightTheme, imageUrls[0], imageUrls[1],
              imageUrls[2], imageUrls[3]);
        default:
          return null;
      }
    }
    return null;
  }

  Widget _oneImageInCircle(
    bool isLightTheme,
    String imageUrl,
  ) {
    final width = widget.width;
    final height = widget.height;

    return ClipOval(
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: _getImage(isLightTheme, imageUrl, width, height),
        ),
      ),
    );
  }

  Widget _twoImagesInCircle(
    bool isLightTheme,
    String imageUrl1,
    String imageUrl2,
  ) {
    final width = widget.width;
    final height = widget.height;

    return ClipOval(
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Stack(
            children: [
              Transform(
                transform: Matrix4.identity()..translate(-width / 4),
                child: _getImage(isLightTheme, imageUrl1, width / 2, height),
              ),
              Transform(
                transform: Matrix4.identity()..translate(width / 4),
                child: _getImage(isLightTheme, imageUrl2, width / 2, height),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _threeImagesInCircle(
    bool isLightTheme,
    String imageUrl1,
    String imageUrl2,
    String imageUrl3,
  ) {
    final width = widget.width;
    final height = widget.height;

    return ClipOval(
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Stack(
            children: [
              Transform(
                transform: Matrix4.identity()..translate(0.0, -height / 4),
                child: _getImage(isLightTheme, imageUrl1, width, height / 2),
              ),
              Transform(
                transform: Matrix4.identity()..translate(0.0, height / 4),
                child:
                    _getImage(isLightTheme, imageUrl2, width / 2, height / 2),
              ),
              Transform(
                transform: Matrix4.identity()..translate(width / 2, height / 4),
                child:
                    _getImage(isLightTheme, imageUrl3, width / 2, height / 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fourImagesInCircle(
    bool isLightTheme,
    String imageUrl1,
    String imageUrl2,
    String imageUrl3,
    String imageUrl4,
  ) {
    final width = widget.width;
    final height = widget.height;

    return ClipOval(
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Stack(
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..translate(-width / 4, -height / 4),
                child:
                    _getImage(isLightTheme, imageUrl1, width / 2, height / 2),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(width / 4, -height / 4),
                child:
                    _getImage(isLightTheme, imageUrl2, width / 2, height / 2),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(-width / 4, height / 4),
                child:
                    _getImage(isLightTheme, imageUrl3, width / 2, height / 2),
              ),
              Transform(
                transform: Matrix4.identity()..translate(width / 4, height / 4),
                child:
                    _getImage(isLightTheme, imageUrl4, width / 2, height / 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
