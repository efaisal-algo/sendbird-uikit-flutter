// Copyright (c) 2024 Sendbird, Inc. All rights reserved.

import 'package:flutter/painting.dart';
import 'package:sendbird_uikit/src/public/resource/sbu_colors.dart';
import 'package:sendbird_uikit/src/public/resource/sbu_theme_provider.dart';

enum SBUTextType {
  heading1,
  heading2,
  subtitle1,
  subtitle2,
  body1,
  body2,
  body3,
  body4,
  button,
  caption1,
  caption2,
  caption3,
  caption4
}

enum SBUTextColorType {
  primary, // [light] primaryMain, [dark] primaryLight
  secondary, // [light] secondaryMain, [dark] secondaryLight
  error, // [light] errorMain, [dark] errorLight
  text01, // [light] lightThemeTextHighEmphasis, [dark] darkThemeTextHighEmphasis
  text02, // [light] lightThemeTextMidEmphasis, [dark] darkThemeTextMidEmphasis
  text03, // [light] lightThemeTextLowEmphasis, [dark] darkThemeTextLowEmphasis
  text04, // [light] lightThemeTextDisabled, [dark] darkThemeTextDisabled
  badge, // [light] darkThemeTextHighEmphasis, [dark] lightThemeTextHighEmphasis
  message, // [light] darkThemeTextHighEmphasis, [dark] lightThemeTextHighEmphasis
  toast, // [light] darkThemeTextHighEmphasis, [dark] lightThemeTextHighEmphasis
  messageEdited, // [light] darkThemeTextMidEmphasis, [dark] lightThemeTextMidEmphasis
  messageDate, // [light] darkThemeTextHighEmphasis, [dark] darkThemeTextMidEmphasis
  information, // [light] lightThemeTextHighEmphasis, [dark] lightThemeTextHighEmphasis
  disabled, // [light] lightThemeTextDisabled, [dark] darkThemeTextDisabled
  newMessage, // [light] white, [dark] white
  otherNewMessage, // [light] white, [dark] white
}

class SBUTextStyles {
  static String fontFamily = 'SfProText';
  static TextStyle getTextStyle({
    required SBUTheme theme,
    required SBUTextType textType,
    required SBUTextColorType textColorType,
  }) {
    final color = _getTextColor(theme: theme, textColorType: textColorType);
    const fontFamily = 'SfProText';

    switch (textType) {
      case SBUTextType.heading1:
        return TextStyle(
          fontFamily: fontFamily,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          height: 32 / 24,
          letterSpacing: -0.8,
          color: color,
        );
      case SBUTextType.heading2:
      case SBUTextType.subtitle1:
        return TextStyle(
          fontFamily: fontFamily,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          height: 27 / 18,
          letterSpacing: -0.8,
          color: color,
        );
      case SBUTextType.subtitle2:
        return TextStyle(
          fontFamily: fontFamily,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          height: 27 / 18,
          letterSpacing: -0.8,
          color: color,
        );
      case SBUTextType.body1:
        return TextStyle(
          fontFamily: fontFamily,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          height: 21 / 14,
          letterSpacing: -0.8,
          color: color,
        );
      case SBUTextType.body2:
      case SBUTextType.button:
        return TextStyle(
          fontFamily: fontFamily,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          height: 21 / 14,
          letterSpacing: -0.8,
          color: color,
        );
      case SBUTextType.body3:
        return TextStyle(
          fontFamily: fontFamily,
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          height: 21 / 14,
          letterSpacing: -0.8,
          color: color,
        );  
      case SBUTextType.body4:
        return TextStyle(
          fontFamily: fontFamily,
          fontSize: 15.0,
          height: 21 / 16,
          fontWeight: FontWeight.normal,
          letterSpacing: -0.8,
          color: color,
        );

      case SBUTextType.caption1:
      case SBUTextType.caption2:
      case SBUTextType.caption3:
      case SBUTextType.caption4:
        return TextStyle(
          fontFamily: fontFamily,
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          height: 15.6 / 12,
          letterSpacing: -0.8,
          color: color,
        ); 
    }
  }

  static Color _getTextColor({
    required SBUTheme theme,
    required SBUTextColorType textColorType,
  }) {
    switch (textColorType) {
      case SBUTextColorType.primary:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.primaryMain;
          case SBUTheme.dark:
            return SBUColors.primaryLight;
        }
      case SBUTextColorType.secondary:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.secondaryMain;
          case SBUTheme.dark:
            return SBUColors.secondaryLight;
        }
      case SBUTextColorType.error:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.errorMain;
          case SBUTheme.dark:
            return SBUColors.errorLight;
        }
      case SBUTextColorType.text01:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.lightThemeTextHighEmphasis;
          case SBUTheme.dark:
            return SBUColors.darkThemeTextHighEmphasis;
        }
      case SBUTextColorType.text02:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.lightThemeTextMidEmphasis;
          case SBUTheme.dark:
            return SBUColors.darkThemeTextMidEmphasis;
        }
      case SBUTextColorType.text03:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.lightThemeTextLowEmphasis;
          case SBUTheme.dark:
            return SBUColors.darkThemeTextLowEmphasis;
        }
      case SBUTextColorType.text04:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.lightThemeTextDisabled;
          case SBUTheme.dark:
            return SBUColors.darkThemeTextDisabled;
        }
      case SBUTextColorType.badge:
      case SBUTextColorType.message:
      case SBUTextColorType.toast:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.darkThemeTextHighEmphasis;
          case SBUTheme.dark:
            return SBUColors.lightThemeTextHighEmphasis;
        }
      case SBUTextColorType.messageEdited:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.darkThemeTextMidEmphasis;
          case SBUTheme.dark:
            return SBUColors.lightThemeTextMidEmphasis;
        }
      case SBUTextColorType.messageDate:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.darkThemeTextHighEmphasis;
          case SBUTheme.dark:
            return SBUColors.darkThemeTextMidEmphasis;
        }
      case SBUTextColorType.information:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.lightThemeTextHighEmphasis;
          case SBUTheme.dark:
            return SBUColors.lightThemeTextHighEmphasis;
        }
      case SBUTextColorType.disabled:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.lightThemeTextDisabled;
          case SBUTheme.dark:
            return SBUColors.darkThemeTextDisabled;
        }
      case SBUTextColorType.newMessage:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.lightThemeNewMssage;
          case SBUTheme.dark:
            return SBUColors.lightThemeNewMssage;
        }
      case SBUTextColorType.otherNewMessage:
        switch (theme) {
          case SBUTheme.light:
            return SBUColors.lightThemeOtherNewMssage;
          case SBUTheme.dark:
            return SBUColors.darkThemeOtherNewMssage;
        }
    }
  }
}
