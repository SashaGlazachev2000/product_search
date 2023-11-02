class ProductImageState {}

class InitialProductImageState extends ProductImageState {}

class LoadedProductImageState extends ProductImageState {
  final String httpImage;
  final Map<String, String> headers = {
    "Authorization":
        "Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6UHNtbWs5MDEyNA=="
  };

  LoadedProductImageState({required this.httpImage});
}
