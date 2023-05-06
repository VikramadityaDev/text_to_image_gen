part of 'app_directory_cubit.dart';

abstract class AppDirectoryState extends Equatable {
  final String path;
  const AppDirectoryState(this.path);
  @override
  List<Object> get props => [path];
}

class AppDirectoryInitial extends AppDirectoryState {
  const AppDirectoryInitial(super.path);
}

class AppDirectoryUpdated extends AppDirectoryState {
  const AppDirectoryUpdated(super.path);
}
