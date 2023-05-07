part of 'app_mode_cubit.dart';

abstract class AppModeState extends Equatable {
  final String mode;

  const AppModeState(this.mode);

  @override
  List<Object?> get props => [mode];
}

class AppModeInitial extends AppModeState {
  const AppModeInitial(super.mode);
}

class AppModeUpdate extends AppModeState {
  const AppModeUpdate(super.mode);
}
