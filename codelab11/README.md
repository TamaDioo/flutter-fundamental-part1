# Pemrograman Mobile - Pemrograman Asynchronous di Flutter

NIM : 2341720098 <br>
NAMA : Dio Andika Pradana Mulia Tama <br>
KELAS : TI-3F

## Praktikum 1: Mengunduh Data dari Web Service (API)

### Langkah 1: Buat Project Baru

Buatlah sebuah project flutter baru dengan nama **books** di folder **src week-11** repository GitHub Anda.

Kemudian Tambahkan dependensi `http` dengan mengetik perintah berikut di terminal.

```shell
flutter pub add http
```

### Langkah 2: Cek file `pubspec.yaml`

Jika berhasil install plugin, pastikan plugin `http` telah ada di file `pubspec` ini seperti berikut.

![Langkah 1](images/prak1_langkah1.png)

### Langkah 3: Buka file `main.dart`

Ketiklah kode seperti berikut ini.

> **Soal 1** <br>
> Tambahkan **nama panggilan Anda** pada `title` app sebagai identitas hasil pekerjaan Anda.

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Demo Dio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back from the Future')),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            ElevatedButton(child: const Text('Go'), onPressed: () {}),
            const Spacer(),
            Text(result),
            const Spacer(),
            const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
```

> Catatan: <br>
> Tidak ada yang spesial dengan kode di `main.dart` tersebut. Perlu diperhatikan di kode tersebut terdapat widget `CircularProgressIndicator` yang akan menampilkan animasi berputar secara terus-menerus, itu pertanda bagus bahwa aplikasi Anda responsif (tidak freeze/lag). Ketika animasi terlihat berhenti, itu berarti UI menunggu proses lain sampai selesai.

### Langkah 4: Tambah method `getData()`

Tambahkan method ini ke dalam `class \_FuturePageState` yang berguna untuk mengambil data dari API Google Books.

```dart
  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = 'books/v1/volumes/Q5mJEAAAQBAJ';
    Uri uri = Uri.https(authority, path);
    return http.get(uri);
  }
```

> **Soal 2**
>
> - Carilah judul buku favorit Anda di Google Books, lalu ganti ID buku pada variabel `path` di kode tersebut. Caranya ambil di URL browser Anda seperti gambar berikut ini.
>   ![Langkah 2](images/prak1_langkah4.1.png)
> - Kemudian cobalah akses di browser URI tersebut dengan lengkap seperti ini. Jika menampilkan data JSON, maka Anda telah berhasil. Lakukan capture milik Anda dan tulis di `README` pada laporan praktikum. Lalu lakukan commit dengan pesan "**W11: Soal 2**".
>   ![Langkah 2](images/prak1_langkah4.2.png)

### Langkah 5: Tambah kode di `ElevatedButton`

Tambahkan kode pada `onPressed` di `ElevatedButton` seperti berikut.

```dart
            ElevatedButton(
              child: Text('Go!'),
              onPressed: () {
                setState(() {});
                getData()
                    .then((value) {
                      result = value.body.toString().substring(0, 450);
                      setState(() {});
                    })
                    .catchError((_) {
                      result = 'An error occured';
                      setState(() {});
                    });
              },
            ),
```

Lakukan run aplikasi Flutter Anda. Anda akan melihat tampilan akhir seperti gambar berikut. Jika masih terdapat error, silakan diperbaiki hingga bisa running.

**Soal 3**

- Jelaskan maksud kode langkah 5 tersebut terkait `substring` dan `catchError`!

  Kode `substring(0, 450)` akan memotong atau memangkas data teks yang diterima. Fungsi `getData()` mengambil data dari Google Books API. Data yang dikembalikan (`value.body`) seringkali berupa teks yang sangat panjang, bisa ribuan karakter. Jika semua teks itu ditampilkan di layar, tampilannya akan berantakan atau terjadi overflow. Oleh karena itu, kode `value.body.toString().substring(0, 450)` digunakan untuk mengambil hanya 450 karakter pertama saja (dimulai dari indeks 0 hingga sebelum 450) dari data tersebut. Sisa datanya diabaikan. Ini memastikan data yang ditampilkan di `Text(result)` pas di layar sebagai cuplikan.

  Sedangkan `catchError` digunakan untuk menangani kegagalan (error handling). Fungsi `getData()` adalah operasi jaringan yang bergantung pada koneksi internet dan ketersediaan server Google. Operasi ini bisa gagal kapan saja (misalnya: HP tidak ada koneksi internet, server Google sedang down, atau URL salah). Jika `getData()` gagal, `Future` akan selesai dengan status error. Tanpa `catchError`, aplikasi akan crash. Jadi, blok `.catchError` berfungsi sebagai jaring pengaman. Jika terjadi error, kode di dalam `.then()` akan dilewati, dan kode di dalam `.catchError` akan dieksekusi.

- Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "**W11: Soal 3**". ꪜ

![Langkah 5](images/prak1_langkah5.gif)

## Praktikum 2: Menggunakan await/async untuk menghindari callbacks

### Langkah 1: Buka file `main.dart`

Tambahkan tiga method berisi kode seperti berikut di dalam `class _FuturePageState`.

```dart
Future<int> returnOneAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 1;
}

Future<int> returnTwoAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 2;
}

Future<int> returnThreeAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 3;
}
```

### Langkah 2: Tambah method `count()`

Lalu tambahkan lagi method ini di bawah ketiga method sebelumnya.

```dart
  Future count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }
```

### Langkah 3: Panggil `count()`

Lakukan comment kode sebelumnya, ubah isi kode onPressed() menjadi seperti berikut.

```dart
            ElevatedButton(
              child: Text('Go!'),
              onPressed: () {
                count();
              },
            ),
```

### Langkah 4: Run

Akhirnya, **run** atau tekan **F5** jika aplikasi belum running. Maka Anda akan melihat seperti gambar berikut, hasil angka 6 akan tampil setelah delay 9 detik.

![Langkah 4](images/prak2_langkah4.gif)
![Langkah 4](images/prak2_langkah4.png)

**Soal 4**

- Jelaskan maksud kode langkah 1 dan 2 tersebut!

  Langkah 1 menambahkan tiga method yaitu `returnOneAsync`, `returnTwoAsync`, dan `returnThreeAsync`.

  - Keyword `async` menandakan bahwa method ini adalah fungsi asinkron. Artinya, fungsi ini bisa melakukan pekerjaan yang butuh waktu (seperti download data, tulis data ke database) tanpa membuat seluruh aplikasi macet.
  - `Future<int>`: Ini adalah "janji" bahwa fungsi tersebut akan mengembalikan sebuah nilai int (angka) di masa depan (Future).
  - `await Future.delayed(...)`. `Future.delayed` adalah perintah untuk "diam/tunggu" selama durasi yang ditentukan, dalam kasus ini 3 detik. Keyword `await` adalah perintah untuk menjeda eksekusi fungsi ini di baris tersebut sampai perintah "tunggu 3 detik" selesai. Ketka fungsi ini "dijeda" (`await`), aplikasi Flutter tidak ikut macet. UI tetap berjalan, dan loading spinner (`CircularProgressIndicator`) bisa terus berputar.
  - `return 1;`: Setelah 3 detik selesai, jeda await berakhir, dan fungsi ini akhirnya mengembalikan nilai 1 (untuk `returnOneAsync`).

  Langkah 2 menambahkan method `count` untuk mengelola ketiga method dari Langkah 1.

  - `Future count() async` menandakan method ini juga merupakan fungsi asinkron.
  - `total = await returnOneAsync();`. Baris ini menjalankan method `returnOneAsync()`. Lalu menunggu (`await`) sampai method itu selesai (yang memakan waktu 3 detik). Setelah selesai dan mengembalikan nilai 1, masukkan nilai itu ke `total`. Saat ini `total` bernilai 1.
  - `total += await returnTwoAsync();`. Baris ini menjalankan method `returnTwoAsync()`. Lalu, menunggu lagi (`await`) sampai method itu selesai (3 detik lagi). Setelah selesai dan mengembalikan 2, tambahkan ke `total`. Saat ini `total` bernilai 1 + 2 = 3.
  - `total += await returnThreeAsync();`. Sama seperti sebelumnya, menunggu 3 detik lagi untuk `returnThreeAsync`. Setelah selesai, tambahkan 3 ke `total`. `total` akhirnya bernilai 3 + 3 = 6.
  - `setState(() { ... })`: Setelah semua proses `await` selesai (total 9 detik), baris ini dieksekusi. `setState` memberi tahu Flutter untuk memperbarui layar dengan nilai `result` yang baru, yaitu "6".

- Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "**W11: Soal 4**". ꪜ
