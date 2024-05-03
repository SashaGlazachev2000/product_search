class ProductImageState {}

class InitialProductImageState extends ProductImageState {}

class LoadedProductImageState extends ProductImageState {
  final String httpImage;
  final Map<String, String> headers = {
    "Authorization":
        "Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6UHNtbWs5MDEyNA=="
  };
  final bool isActiveNextButton;
  final bool isActiveBackButton;

  LoadedProductImageState({
    required this.httpImage,
    required this.isActiveNextButton,
    required this.isActiveBackButton,
  });
}

class ErrorProductImageState extends ProductImageState {}
