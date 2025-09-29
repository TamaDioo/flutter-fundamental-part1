import 'package:flutter/material.dart';

// Widget ini (MyHomePage) adalah halaman utama yang berisi state (data yang bisa berubah).
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // Variabel final untuk menyimpan judul yang dikirim dari MyApp.
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Class _MyHomePageState adalah tempat state dan UI dari MyHomePage dikelola.
class _MyHomePageState extends State<MyHomePage> {
  // State: variabel _counter akan berubah setiap kali tombol ditekan.
  int _counter = 0;

  // Fungsi untuk menambah nilai _counter dan memperbarui UI.
  void _incrementCounter() {
    // setState memberi tahu Flutter bahwa ada perubahan state,
    // sehingga build() akan dipanggil lagi untuk me-render ulang UI.
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Mengakses title dari widget MyHomePage di atas.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(child: SizedBox(height: 50.0)),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
