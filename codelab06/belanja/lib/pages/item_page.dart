import 'package:flutter/material.dart';
import 'package:belanja/models/item.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Item;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${item.name}'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          elevation: 4.0, // Memberi efek bayangan pada card
          margin: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(24.0), // Memberi jarak di dalam card
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Membuat tinggi Column sesuai isinya
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Rp ${item.price}',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
