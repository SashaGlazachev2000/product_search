class Store {
  Store({required this.store, required this.amount, required this.quality});

  final String store;
  final int amount;
  final String quality;

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      store: json['store'],
      amount: json['amount'],
      quality: json['quality'],
    );
  }
}
