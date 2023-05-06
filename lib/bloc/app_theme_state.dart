part of 'app_theme_cubit.dart';

abstract class AppThemeState extends Equatable {
  final AppTheme theme;

  const AppThemeState(this.theme);
  @override
  List<Object> get props => [theme];
}

class AppThemeInitial extends AppThemeState {
  const AppThemeInitial(AppTheme theme) : super(theme);
}

class AppThemeUpdate extends AppThemeState {
  const AppThemeUpdate(AppTheme theme) : super(theme);
}
