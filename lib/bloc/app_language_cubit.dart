import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_image_gen/utils/app_language.dart';

part 'app_language_state.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit(Locale locale) : super(AppLanguageInitial(locale)) {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final selectedLanguage = await LanguageSharedPreferences.getLocale();
    emit(AppLanguageUpdate(selectedLanguage));
  }

  Future<void> changeLanguage(String value) async {
    await LanguageSharedPreferences.setLocale(value).then((locale) {
      emit(AppLanguageUpdate(locale));
    });
  }
}
