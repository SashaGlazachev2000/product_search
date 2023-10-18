import 'package:flutter/material.dart';

class SearchProductModel extends ChangeNotifier {
  String httpImage = "";
  Map<String, String> headers = {
    "code": "22328",
    "index": "1",
    "Authorization":
        "Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6UHNtbWs5MDEyNA=="
  };

  void pushCode(int? code) {
    if (code == null) {
      return;
    }

    httpImage = "https://ceshops.ru:8443/sem/hs/product_img?code=$code&index=1";
    notifyListeners();
  }
}

class SearchProductWidgetProvider extends InheritedNotifier {
  final SearchProductModel model;

  const SearchProductWidgetProvider({
    super.key,
    required super.child,
    required this.model,
  }) : super(notifier: model);

  static SearchProductModel? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<SearchProductWidgetProvider>()
        ?.widget;

    return widget is SearchProductWidgetProvider ? widget.model : null;
  }

  static SearchProductModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SearchProductWidgetProvider>()
        ?.model;
  }
}
