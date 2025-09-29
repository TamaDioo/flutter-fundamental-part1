import 'package:flutter/material.dart';

// Widget ini hanya berisi TextField
class InputSelectionWidget extends StatelessWidget {
  const InputSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: false,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }
}
