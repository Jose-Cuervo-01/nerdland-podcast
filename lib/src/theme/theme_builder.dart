import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/theme/colors.dart';

class ThemeBuilder {
  static ThemeData buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      textTheme: _buildTextTheme(),
      accentColor: kAccentColor,
      primaryColor: kPrimaryColor,
      // scaffoldBackgroundColor: kPrimaryColor,
    );
  }

  static TextTheme _buildTextTheme() {
    return TextTheme(
      title: TextStyle(
        fontSize: 24,
        // color: kAccentColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Zilla Slab',
      ),
      subhead: TextStyle(
        fontSize: 18,
        color: kPrimaryColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Zilla Slab',
      ),
      overline: TextStyle(
        // fontFamily: 'Zilla Slab',
        // color: kGreyColor,
      ),
    );
  }
}
