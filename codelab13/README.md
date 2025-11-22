# Persistensi Data

NIM : 2341720098 <br>
NAMA : Dio Andika Pradana Mulia Tama <br>
KELAS : TI-3F

## Praktikum 1: Konversi Dart model ke JSON

### Kode Program `main.dart`:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo Dio',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: false),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON Dio')),
      body: Container(),
    );
  }
}
```

**Soal 1**

- Tambahkan **nama panggilan Anda** pada `title` app sebagai identitas hasil pekerjaan Anda. ꪜ
- Gantilah warna tema aplikasi sesuai kesukaan Anda. ꪜ
- Lakukan commit hasil jawaban Soal 1 dengan pesan "**W13: Jawaban Soal 1**" ꪜ

### Update Kode Program Class `_MyHomePageState` di `main.dart`:

```dart
class _MyHomePageState extends State<MyHomePage> {
  String pizzaString = '';

  @override
  void initState() {
    super.initState();
    readJsonFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON Dio')),
      body: Text(pizzaString),
    );
  }

  Future readJsonFile() async {
    String myString = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/pizzalist.json');
    setState(() {
      pizzaString = myString;
    });
  }
}
```

### Run

![Langkah 10](images/prak1_langkah10.jpg)

**Soal 2**

- Masukkan hasil capture layar ke laporan praktikum Anda. ꪜ
- Lakukan commit hasil jawaban Soal 2 dengan pesan "**W13: Jawaban Soal 2**" ꪜ

### Kode Program file `lib/model/pizza.dart`:

```dart
class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;

  Pizza.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      pizzaName = json['pizzaName'],
      description = json['description'],
      price = json['price'],
      imageUrl = json['imageUrl'];
}
```

### Update Kode Program Class `_MyHomePageState` di `main.dart`:

```dart
class _MyHomePageState extends State<MyHomePage> {
  String pizzaString = '';
  List<Pizza> myPizzas = [];

  @override
  void initState() {
    super.initState();
    readJsonFile().then((value) {
      setState(() {
        myPizzas = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON Dio')),
      body: ListView.builder(
        itemCount: myPizzas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(myPizzas[index].pizzaName),
            subtitle: Text(myPizzas[index].description),
          );
        },
      ),
    );
  }

  Future<List<Pizza>> readJsonFile() async {
    String myString = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/pizzalist.json');
    List pizzaMapList = jsonDecode(myString);
    List<Pizza> myPizzas = [];
    for (var pizza in pizzaMapList) {
      Pizza myPizza = Pizza.fromJson(pizza);
      myPizzas.add(myPizza);
    }
    return myPizzas;
    // setState(() {
    //   pizzaString = pizzaMapList.toString();
    // });
  }
```

### Run

Jalankan aplikasi. Sekarang, Anda akan melihat data pizza ditampilkan dalam daftar yang lebih terstruktur sebagai objek List Dart.

![Langkah 22](images/prak1_langkah22.jpg)

**Soal 3**

- Masukkan hasil capture layar ke laporan praktikum Anda. ꪜ
- Lakukan commit hasil jawaban Soal 2 dengan pesan "**W13: Jawaban Soal 3**" ꪜ
