class Store {
  Store({required this.store, required this.amount, required this.quality});

  final String store;
  final String quality;
  final int amount;

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      store: json['store'] as String,
      quality: json['quality'] as String,
      amount: json['amount'] as int,
    );
  }
}
