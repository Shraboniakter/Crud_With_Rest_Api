import 'package:crud_with_rest_api/Screen/ProductCreateScreen.dart';
import 'package:crud_with_rest_api/Screen/ProductGridViewScreen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp((app()));
}
class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductGridViewScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
