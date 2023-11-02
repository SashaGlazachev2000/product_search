class ImageEvent {}

class ImageGetEvent extends ImageEvent {
  final int imagesCount;

  final int? code;

  ImageGetEvent({this.imagesCount = 1, required this.code});
}

class ImageAddEvent extends ImageEvent {}

class ImageRemoveEvent extends ImageEvent {}
