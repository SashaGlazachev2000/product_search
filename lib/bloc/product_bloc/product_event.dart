class ProductEvent {}

class ProductGetProductEvent extends ProductEvent {
  final int? code;

  ProductGetProductEvent({required this.code});
}
