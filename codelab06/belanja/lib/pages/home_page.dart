import 'package:belanja/models/item.dart';
import 'package:flutter/material.dart';
import 'package:belanja/widgets/product_card.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final List<Item> items = [
    Item(
      name: 'Sugar',
      price: 5000,
      image: 'images/gula.jpg',
      stock: 20,
      rating: 4.9,
      description:
          'Gula pasir berkualitas tinggi, cocok untuk berbagai keperluan memasak dan membuat minuman manis. Memiliki tekstur halus dan mudah larut.',
    ),
    Item(
      name: 'Salt',
      price: 2000,
      image: 'images/garam.jpg',
      stock: 15,
      rating: 4.5,
      description:
          'Garam dapur murni yang dapat meningkatkan cita rasa masakan Anda. Ideal untuk semua jenis hidangan.',
    ),
    Item(
      name: 'Milk',
      price: 6000,
      image: 'images/susu.jpg',
      stock: 12,
      rating: 4.8,
      description:
          'Susu segar yang kaya akan kalsium dan nutrisi penting untuk kesehatan tulang. Cocok untuk diminum langsung atau sebagai bahan memasak.',
    ),
    Item(
      name: 'Flour',
      price: 8000,
      image: 'images/tepung.jpg',
      stock: 10,
      rating: 4.6,
      description:
          'Tepung terigu serbaguna yang ideal untuk membuat roti, kue, dan berbagai hidangan lainnya. Memiliki tekstur halus dan kualitas terbaik.',
    ),
    Item(
      name: 'Rice',
      price: 10000,
      image: 'images/beras.jpg',
      stock: 14,
      rating: 4.7,
      description:
          'Beras berkualitas tinggi dengan tekstur pulen, cocok untuk hidangan sehari-hari. Ditanam secara organik untuk hasil terbaik.',
    ),
    Item(
      name: 'Oil',
      price: 21000,
      image: 'images/minyak.jpg',
      stock: 18,
      rating: 4.8,
      description:
          'Minyak goreng berkualitas tinggi yang tahan panas dan cocok untuk berbagai jenis masakan. Memiliki rasa netral dan sehat.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Menampilkan 2 item per baris
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ProductCard(
            item: items[index],
            onTap: () {
              context.goNamed('item', extra: items[index]);
              // Navigator.pushNamed(context, '/item', arguments: items[index]);
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Dio Andika Pradana M. T. - 2341720098',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
