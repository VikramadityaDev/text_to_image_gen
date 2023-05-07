import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/app_theme_mode.dart';
import '../utils/strings.dart';
import '../widgets/app_theme.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit(AppTheme initialTheme) : super(AppThemeInitial(initialTheme)) {
    loadTheme();
  }
  Future<void> loadTheme() async {
    final String? themeName = await ThemeSharedPreferences.getThemeName();
    final AppTheme theme = themeName != null
        ? appThemes.keys.firstWhere(
            (theme) => theme.name.toLowerCase() == themeName.toLowerCase(),
            orElse: () => appThemes.keys.first,
          )
        : appThemes.keys.first;
    emit(AppThemeUpdate(theme));
  }

  Future<void> updateTheme(AppTheme newTheme) async {
    await ThemeSharedPreferences.setThemeName(appThemes[newTheme]!);
    emit(AppThemeUpdate(newTheme));
  }
}
