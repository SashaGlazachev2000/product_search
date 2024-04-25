import 'package:flutter/material.dart';
import 'package:product_search/view/search_product/image_screen.dart';
import 'package:product_search/view/search_product/screen_search_product.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (c) => SearchProductWidget(),
        '/image': (context) {
          final arguments =
              (ModalRoute.of(context)?.settings.arguments ?? '') as String;
          return ImageScreen(
            image: arguments,
          );
        },
      },
      theme: ThemeData(),
      // home: SearchProductWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
