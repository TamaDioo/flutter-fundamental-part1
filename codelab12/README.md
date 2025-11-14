# Lanjutan State Management dengan Streams

NIM : 2341720098 <br>
NAMA : Dio Andika Pradana Mulia Tama <br>
KELAS : TI-3F

## Praktikum 1: Dart Streams

Kode Program `main.dart`:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Dio',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

**Soal 1**

- Tambahkan **nama panggilan Anda** pada `title` app sebagai identitas hasil pekerjaan Anda. ꪜ

  ```dart
  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Stream Dio',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const StreamHomePage(),
      );
    }
  }
  ```

- Gantilah warna tema aplikasi sesuai kesukaan Anda. ꪜ

  ```dart
      theme: ThemeData(primarySwatch: Colors.indigo),
  ```

- Lakukan commit hasil jawaban Soal 1 dengan pesan "**W12: Jawaban Soal 1**" ꪜ

Kode program `stream.dart`:

```dart
import 'package:flutter/material.dart';

class ColorStream {
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
  ];
}
```

**Soal 2**

- Tambahkan 5 warna lainnya sesuai keinginan Anda pada variabel `colors` tersebut. ꪜ
  ```dart
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
    Colors.yellow,
    Colors.pink,
    Colors.lime,
    Colors.cyan,
    Colors.orange,
  ];
  ```
- Lakukan commit hasil jawaban Soal 2 dengan pesan "**W12: Jawaban Soal 2**" ꪜ

Menambahkan method `getColors()` dan perintah `yield*` pada `stream.dart`:

```dart
  Stream<Color> getColors() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int t) {
      int index = t % colors.length;
      return colors[index];
    });
  }
```

**Soal 3**

- Jelaskan fungsi keyword `yield*` pada kode tersebut!

  Keyword `yield*` berfungsi untuk meneruskan (mendelegasikan) semua nilai dari _Stream_ lain ke dalam _Stream_ saat ini.

  - `yield` (tanpa \*): Digunakan untuk mengirim satu nilai ke dalam _Stream_.
  - `yield*` (dengan \*): Digunakan untuk mengambil seluruh _Stream_ lain dan membiarkan semua nilainya mengalir ke dalam _Stream_ saat ini, satu per satu.

  Pada kode tersebut, `yield* Stream.periodic(...)` dapat diartikan: "Ambil Stream yang dibuat oleh `Stream.periodic`, dan setiap kali Stream itu menghasilkan nilai, teruskan nilai tersebut seolah-olah itu adalah nilai dari Stream `getColors`."

- Apa maksud isi perintah kode tersebut?

  Singkatnya, kode tersebut bertujuan untuk membuat sebuah generator warna yang tidak pernah berhenti.
  Fungsi `getColors()` adalah sebuah Stream yang akan mengeluarkan satu warna baru setiap satu detik, secara berulang-ulang dari daftar yang ada.

  1. Class `ColorStream` memiliki sebuah List berisi 10 warna (`final List<Color> colors`).
  2. `Stream.periodic(const Duration(seconds: 1), ...)` adalah sebuah Stream bawaan Dart yang akan menghasilkan sebuah angka (`int `) setiap 1 detik. Angka ini akan terus bertambah (0, 1, 2, 3, ...).
  3. Kode `int index = t % colors.length;` menggunakan operasi modulo. `colors.length` adalah 10, jadi:

     - Ketika t = 0, index = 0 % 10 = 0
     - Ketika t = 1, index = 1 % 10 = 1
     - ...
     - Ketika t = 9, index = 9 % 10 = 9
     - Ketika t = 10, index = 10 % 10 = 0 (kembali ke awal)
     - Ketika t = 11, index = 11 % 10 = 1
     - Dan seterusnya...

  4. `return colors[index];` mengambil warna dari List berdasarkan index yang berulang tersebut.
  5. `yield\*` memastikan bahwa warna yang dipilih di langkah 4 dikeluarkan oleh Stream `getColors` setiap detiknya.

  Hasil akhirnya adalah sebuah Stream yang akan menampilkan: Colors.blueGrey (detik 1), Colors.amber (detik 2), ... Colors.orange (detik 10), lalu Colors.blueGrey (detik 11), dan seterusnya.

- Lakukan commit hasil jawaban Soal 3 dengan pesan "**W12: Jawaban Soal 3**" ꪜ

Update kode `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Dio',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;

  @override
  void initState() {
    super.initState();
    colorStream = ColorStream();
    changeColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream Dio')),
      body: Container(decoration: BoxDecoration(color: bgColor)),
    );
  }

  void changeColor() async {
    await for (var eventColor in colorStream.getColors()) {
      setState(() {
        bgColor = eventColor;
      });
    }
  }
}
```

### Run

Lakukan running pada aplikasi Flutter Anda, maka akan terlihat berubah warna background setiap detik.

![Langkah 12](images/prak1_langkah12.gif)

**Soal 4**

- Capture hasil praktikum Anda berupa GIF dan lampirkan di README. ꪜ
- Lakukan commit hasil jawaban Soal 4 dengan pesan "**W12: Jawaban Soal 4**" ꪜ

Mengganti isi method `changeColor()`:

```dart
  void changeColor() async {
    colorStream.getColors().listen((eventColor) {
      setState(() {
        bgColor = eventColor;
      });
    });
  }
```

**Soal 5**

- Jelaskan perbedaan menggunakan `listen` dan `await for` (langkah 9) !

  Perbedaan utamanya terletak pada cara eksekusi kodenya (**blocking vs non-blocking**).

  - `.listen()` adalah metode non-blocking. Method "berlangganan" ke Stream dan method akan langsung selesai, tapi akan mendapat "panggilan" setiap kali ada data baru. Analoginya seperti berlangganan notifikasi email. Hanya mendaftar sekali (`.listen`), lalu bebas melanjutkan pekerjaan lain. Setiap kali ada data baru (email masuk), maka akan "diberi tahu" (kode `callback` dipanggil).
  - `await for` adalah loop yang blocking (di dalam fungsi `async`). Method akan "berhenti sejenak" di loop tersebut, menunggu setiap data baru, mengeksekusi loop, lalu menunggu lagi. Jadi, method `changeColor()` akan berhenti (pause) di loop itu dan tidak akan pindah ke baris berikutnya.

- Lakukan commit hasil jawaban Soal 5 dengan pesan "**W12: Jawaban Soal 5**" ꪜ

## Praktikum 2: Stream controllers dan sinks

### Langkah 1: Buka file `stream.dart`

Lakukan impor dengan mengetik kode ini.

```dart
import 'dart:async';
```

### Langkah 2: Tambah class `NumberStream`

Tetap di file `stream.dart` tambah class baru seperti berikut.

```dart

```

### Langkah 3: Tambah `StreamController`

Di dalam `class NumberStream` buatlah variabel seperti berikut.

```dart

```

### Langkah 4: Tambah method `addNumberToSink`

Tetap di `class NumberStream` buatlah method ini

```dart

```

### Langkah 5: Tambah method `close()`

```dart

```

### Langkah 6: Buka `main.dart`

Ketik kode import seperti berikut

```dart

```

### Langkah 7: Tambah variabel

Di dalam `class _StreamHomePageState` ketik variabel berikut

```dart

```

### Langkah 8: Edit `initState()`

```dart

```

### Langkah 9: Edit `dispose()`

```dart

```

### Langkah 10: Tambah method `addRandomNumber()`

```dart
void addRandomNumber() {
  Random random = Random();
  int myNum = random.nextInt(10);
  numberStream.addNumberToSink(myNum);
}
```

### Langkah 11: Edit method `build()`

```dart

```

### Langkah 12: Run

Lakukan running pada aplikasi Flutter Anda, maka akan terlihat seperti gambar berikut.

![Langkah 12](images/prak1_langkah12.png)

**Soal 6**

- Jelaskan maksud kode langkah 8 dan 10 tersebut!
- Capture hasil praktikum Anda berupa GIF dan lampirkan di README.
- Lalu lakukan commit dengan pesan "**W12: Jawaban Soal 6**".

### Langkah 13: Buka `stream.dart`

Tambahkan method berikut ini.

```dart

```

### Langkah 14: Buka `main.dart`

Tambahkan method `onError` di dalam class `StreamHomePageState` pada method `listen` di fungsi `initState()` seperti berikut ini.

```dart

```

### Langkah 15: Edit method `addRandomNumber()`

Lakukan _comment_ pada dua baris kode berikut, lalu ketik kode seperti berikut ini.

```dart

```

**Soal 7**

- Jelaskan maksud kode langkah 13 sampai 15 tersebut!
- Kembalikan kode seperti semula pada Langkah 15, comment `addError()` agar Anda dapat melanjutkan ke praktikum 3 berikutnya.
- Lalu lakukan commit dengan pesan "**W12: Jawaban Soal 7**".

## Praktikum 3: Injeksi data ke streams
