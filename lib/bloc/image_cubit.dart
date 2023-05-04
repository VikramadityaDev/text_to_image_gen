import 'dart:typed_data';

import 'package:brain_fusion/brain_fusion.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());
  final AI _ai = AI();

  Future<void> generate(String query, AIStyle style) async {
    emit(ImageLoading());
    try {
      Uint8List image = await _ai.runAI(query, style);
      emit(ImageLoaded(image: image));
    } catch (_) {
      emit(const ImageError(error: 'There is error . Try Again Later'));
    }
  }
}
