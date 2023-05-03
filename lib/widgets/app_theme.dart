import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import '../utils/strings.dart';

ThemeMode getMode(String appMode) {
  switch (appMode) {
    case light:
      return ThemeMode.light;
    case dark:
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

class AppTheme {
  final String name;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const AppTheme({
    required this.lightTheme,
    required this.name,
    required this.darkTheme,
  });
}


AppTheme indigoTheme = AppTheme(
  name: 'Indigo Nights',
  lightTheme: FlexThemeData.light(
    useMaterial3: true,
    scheme: FlexScheme.indigo,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      navigationBarHeight: 70,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Cairo',

  ),
  darkTheme: FlexThemeData.dark(
    useMaterial3: true,
    scheme: FlexScheme.indigo,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      navigationBarHeight: 70,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Cairo',
  ),
);




AppTheme blueWhaleTheme = AppTheme(
  name: 'Blue Whale',
  lightTheme: FlexThemeData.light(
    useMaterial3: true,
    scheme: FlexScheme.blueWhale,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      navigationBarHeight: 70,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Cairo',

  ),
  darkTheme: FlexThemeData.dark(
    useMaterial3: true,
    scheme: FlexScheme.blueWhale,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: 'Cairo',

  ),
);

AppTheme material = AppTheme(
  name: 'Material',
  lightTheme: FlexThemeData.light(
    useMaterial3: true,
    scheme: FlexScheme.material,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Cairo',

  ),
  darkTheme: FlexThemeData.dark(
    useMaterial3: true,
    scheme: FlexScheme.material,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Cairo',

  ),
);

AppTheme goldSunset = AppTheme(
  name: 'Gold Sunset',
  lightTheme: FlexThemeData.light(
    scheme: FlexScheme.gold,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Cairo',

  ),
  darkTheme: FlexThemeData.dark(
    scheme: FlexScheme.gold,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Cairo',

  ),

);

AppTheme dellGenoaGreen = AppTheme(
  name: 'Dell Genoe Green',
  lightTheme: FlexThemeData.light(
    scheme: FlexScheme.dellGenoa,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Cairo',

  ),
  darkTheme: FlexThemeData.dark(
    scheme: FlexScheme.dellGenoa,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      navigationBarHeight: 70,

    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Cairo',

  ),
);
