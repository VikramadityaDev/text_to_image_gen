import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/app_directory.dart';
import '../utils/strings.dart';

part 'app_directory_state.dart';

class AppDirectoryCubit extends Cubit<AppDirectoryState> {
  AppDirectoryCubit(String path) : super(AppDirectoryInitial(path)) {
    loadPath();
  }

  Future<void> loadPath() async {
    final selectedPath = await PathSharedPreferences.getPath();
    emit(AppDirectoryUpdated(selectedPath ?? pathHint));
  }

  Future<void> changePath(String value) async {
    await PathSharedPreferences.setPath(value);
    emit(AppDirectoryUpdated(value));
  }
}
