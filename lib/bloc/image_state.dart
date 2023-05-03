part of 'image_cubit.dart';

abstract class ImageState extends Equatable {
  const ImageState();
  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final Uint8List image;
  const ImageLoaded({required this.image});
  @override
  List<Object> get props => [image];
}

class ImageError extends ImageState {
  final String error;
  const ImageError({required this.error});
  @override
  List<Object> get props => [error];
}
