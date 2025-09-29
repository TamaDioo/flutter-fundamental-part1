import 'dart:async';
import 'package:flutter/material.dart';

// Widget ini (MyHomePage) adalah halaman utama yang berisi state (tanggal yang dipilih).
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// Class _MyHomePageState mengelola state dan UI untuk MyHomePage.
class _MyHomePageState extends State<MyHomePage> {
  // State untuk menyimpan tanggal yang dipilih, diinisialisasi dengan tanggal saat ini.
  DateTime selectedDate = DateTime.now();

  // Fungsi async untuk menampilkan dialog Date Picker.
  Future<void> _selectDate(BuildContext context) async {
    // Menunggu pengguna memilih tanggal dari dialog.
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8), // Tanggal paling awal yang bisa dipilih
      lastDate: DateTime(2101), // Tanggal paling akhir yang bisa dipilih
    );

    // Jika pengguna memilih tanggal (tidak null) dan tanggalnya berbeda dari yang sudah ada,
    // perbarui state.
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Menampilkan tanggal yang dipilih dalam format YYYY-MM-DD.
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Memanggil fungsi untuk menampilkan date picker saat tombol ditekan.
                _selectDate(context);
              },
              child: const Text('Pilih Tanggal'),
            ),
          ],
        ),
      ),
    );
  }
}
