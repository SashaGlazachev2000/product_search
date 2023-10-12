import 'package:flutter/material.dart';

class SearchProductModel extends ChangeNotifier {
  void pushCode(int? code) {
    if (code == null) {
      return;
    }
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
