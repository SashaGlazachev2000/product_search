class ImageEvent {}

class ImageGetEvent extends ImageEvent {
  final int imagesCount;
  final int code;

  ImageGetEvent({required this.imagesCount, required this.code});
}

class ImageAddEvent extends ImageEvent {}

class ImageRemoveEvent extends ImageEvent {}

class ErrorImageEvent extends ImageEvent {}
