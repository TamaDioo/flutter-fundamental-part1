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

- Lakukan commit hasil jawaban Soal 1 dengan pesan "**W12: Jawaban Soal 1**"

### Langkah 3: Buat file baru `stream.dart`

Buat file baru di folder lib project Anda. Lalu isi dengan kode berikut.

```dart

```

### Langkah 4: Tambah variabel `colors`

Tambahkan variabel di dalam class `ColorStream` seperti berikut.

```dart

```

**Soal 2**

- Tambahkan 5 warna lainnya sesuai keinginan Anda pada variabel `colors` tersebut.
- Lakukan commit hasil jawaban Soal 2 dengan pesan "**W12: Jawaban Soal 2**"

### Langkah 5: Tambahkan method `getColors()`

Di dalam `class ColorStream` ketik method seperti kode berikut. Perhatikan tanda bintang di akhir keyword `async*` (ini digunakan untuk melakukan `Stream` data)

```dart

```

### Langkah 6: Tambah perintah `yield*`

Tambahkan kode berikut ini.

```dart
yield* Stream.periodic(
  const Duration(seconds: 1), (int t) {
    int index = t % colors.length;
    return colors[index];
});
```

**Soal 3**

- Jelaskan fungsi keyword `yield*` pada kode tersebut!
- Apa maksud isi perintah kode tersebut?
- Lakukan commit hasil jawaban Soal 3 dengan pesan "**W12: Jawaban Soal 3**"

### Langkah 7: Buka `main.dart`

Ketik kode impor file ini pada file `main.dart`

```dart
import 'stream.dart';
```

### Langkah 8: Tambah variabel

Ketik dua properti ini di dalam `class _StreamHomePageState`

```dart

```

### Langkah 9: Tambah method `changeColor()`

Tetap di file main, Ketik kode seperti berikut

```dart

```

### Langkah 10: Lakukan override `initState()`

Ketikkan kode seperti berikut.

```dart

```

### Langkah 11: Ubah isi `scaffold()`

Sesuaikan kode seperti berikut.

```dart

```

### Langkah 12: Run

Lakukan running pada aplikasi Flutter Anda, maka akan terlihat berubah warna background setiap detik.

![Langkah 12](images/prak1_langkah12.png)

**Soal 4**

- Capture hasil praktikum Anda berupa GIF dan lampirkan di README.
- Lakukan commit hasil jawaban Soal 4 dengan pesan "**W12: Jawaban Soal 4**"

### Langkah 13: Ganti isi method `changeColor()`

Anda boleh comment atau hapus kode sebelumnya, lalu ketika kode seperti berikut.

```dart

```

**Soal 5**

- Jelaskan perbedaan menggunakan `listen` dan `await for` (langkah 9) !
- Lakukan commit hasil jawaban Soal 5 dengan pesan "**W12: Jawaban Soal 5**"

> Catatan: Stream di Flutter memiliki fitur yang powerfull untuk menangani data secara async. Stream dapat dimanfaatkan pada skenario dunia nyata seperti real-time messaging, unggah dan unduh file, tracking lokasi user, bekerja dengan data sensor IoT, dan lain sebagainya.

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
