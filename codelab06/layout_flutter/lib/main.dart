import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      // Padding untuk seluruh baris
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /* soal 1*/
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Posisi kolom di awal (kiri)
              children: [
                /* soal 2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8), // Padding bawah 8
                  child: const Text(
                    'Wisata Gunung di Malang',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Malang, Jawa Timur, Indonesia',
                  style: TextStyle(
                    color: Colors.grey[500], // set warna menjadi abu-abu
                  ),
                ),
              ],
            ),
          ),
          /* soal 3*/
          Icon(
            Icons.star, // ikon bintang
            color: Colors.red[500], // set warna menjadi merah
          ),
          const Text('41'),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Gunung Bromo, sebuah keajaiban vulkanik di Jawa Timur, menawarkan '
        'pemandangan matahari terbit yang magis dari Puncak Penanjakan. '
        'Lautan pasirnya yang luas dan kawahnya yang aktif menciptakan '
        'lanskap sureal yang memukau setiap pengunjung. '
        'Pengalaman mendaki ke bibir kawah menjadi petualangan tak terlupakan.\n\n'
        'Dio Andika Pradana M. T.\n'
        '2341720098',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'Flutter layout: Dio Andika Pradana Mulia Tama - 2341720098',
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter layout demo')),
        body: ListView(
          children: [
            Image.asset(
              'images/bromo.jpeg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
