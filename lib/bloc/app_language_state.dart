part of 'app_language_cubit.dart';

abstract class AppLanguageState extends Equatable {
  final Locale locale;

  const AppLanguageState(this.locale);

  @override
  List<Object> get props => [locale];
}

class AppLanguageInitial extends AppLanguageState {
  const AppLanguageInitial(super.locale);
}

class AppLanguageUpdate extends AppLanguageState {
  const AppLanguageUpdate(super.locale);
}
