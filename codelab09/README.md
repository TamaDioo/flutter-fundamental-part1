# Pemrograman Mobile - Kamera

NIM : 2341720098 <br>
NAMA : Dio Andika Pradana Mulia Tama <br>
KELAS : TI-3F

## Praktikum 1: Mengambil Foto dengan Kamera di Flutter

### Langkah 1: Buat Project Baru

Buatlah sebuah project flutter baru dengan nama **kamera_flutter**, lalu sesuaikan style laporan praktikum yang Anda buat.

### Langkah 2: Tambah dependensi yang diperlukan

Anda memerlukan tiga dependensi pada project flutter untuk menyelesaikan praktikum ini.

`camera` → menyediakan seperangkat alat untuk bekerja dengan kamera pada device.

`path_provider` → menyediakan lokasi atau path untuk menyimpan hasil foto.

`path` → membuat path untuk mendukung berbagai platform.

Untuk menambahkan dependensi plugin, jalankan perintah `flutter pub add` seperti berikut di terminal:

```dart
flutter pub add camera path_provider path
```

![Langkah 2](images/langkah2.png)

### Langkah 3: Ambil Sensor Kamera dari device

Selanjutnya, kita perlu mengecek jumlah kamera yang tersedia pada perangkat menggunakan plugin `camera` seperti pada kode berikut ini. Kode ini letakkan dalam `void main()`. Ubah `void main()` menjadi async function seperti berikut ini.

**lib/main.dart**

```dart
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
}
```

Pastikan melakukan impor plugin sesuai yang dibutuhkan.

### Langkah 4: Buat dan inisialisasi `CameraController`

Setelah Anda dapat mengakses kamera, gunakan langkah-langkah berikut untuk membuat dan menginisialisasi `CameraController`. Pada langkah berikut ini, Anda akan membuat koneksi ke kamera perangkat yang memungkinkan Anda untuk mengontrol kamera dan menampilkan pratinjau umpan kamera.

1. Buat `StatefulWidget` dengan kelas `State` pendamping.
2. Tambahkan variabel ke kelas `State` untuk menyimpan `CameraController`.
3. Tambahkan variabel ke kelas `State` untuk menyimpan `Future` yang dikembalikan dari `CameraController.initialize()`.
4. Buat dan inisialisasi controller dalam metode `initState()`.
5. Hapus controller dalam metode `dispose()`.

**lib/widget/takepicture_screen.dart**

```dart
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return Container();
  }
}
```

### Langkah 5: Gunakan `CameraPreview` untuk menampilkan preview foto

Gunakan widget `CameraPreview` dari package `camera` untuk menampilkan preview foto. Anda perlu tipe objek void berupa `FutureBuilder` untuk menangani proses async.

**lib/widget/takepicture_screen.dart**

```dart
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture - 2341720098')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
```

### Langkah 6: Ambil foto dengan `CameraController`

Anda dapat menggunakan `CameraController` untuk mengambil gambar menggunakan metode `takePicture()`, yang mengembalikan objek `XFile`, merupakan sebuah objek abstraksi `File` lintas platform yang disederhanakan. Pada Android dan iOS, gambar baru disimpan dalam direktori cache masing-masing, dan `path` ke lokasi tersebut dikembalikan dalam `XFile`.

Pada codelab ini, buatlah sebuah `FloatingActionButton` yang digunakan untuk mengambil gambar menggunakan `CameraController` saat pengguna mengetuk tombol.

Pengambilan gambar memerlukan 2 langkah:

1. Pastikan kamera telah diinisialisasi.
2. Gunakan controller untuk mengambil gambar dan pastikan ia mengembalikan objek `Future`.

Praktik baik untuk membungkus operasi kode ini dalam blok `try / catch` guna menangani berbagai kesalahan yang mungkin terjadi.

Kode berikut letakkan dalam `Widget build` setelah field `body`.

**lib/widget/takepicture_screen.dart**

```dart
FloatingActionButton(
  // Provide an onPressed callback.
  onPressed: () async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and then get the location
      // where the image file is saved.
      final image = await _controller.takePicture();
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  },
  child: const Icon(Icons.camera_alt),
)
```

### Langkah 7: Buat widget baru `DisplayPictureScreen`

Buatlah file baru pada folder widget yang berisi kode berikut.

**lib/widget/displaypicture_screen.dart**

```dart
import 'dart:io';
import 'package:flutter/material.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture - 2341720098')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
```

### Langkah 8: Edit `main.dart`

Edit pada file ini bagian `runApp` seperti kode berikut.

**lib/main.dart**

```dart
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'widget/takepicture_screen.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
```

### Langkah 9: Menampilkan hasil foto

Tambahkan kode seperti berikut pada bagian `try / catch` agar dapat menampilkan hasil foto pada `DisplayPictureScreen`.

**lib/widget/takepicture_screen.dart**

```dart
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            if (!context.mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
```

Silakan deploy pada device atau smartphone Anda dan perhatikan hasilnya! 🙂

![Praktikum 1](images/prak1_hasil.gif)

## Praktikum 2: Membuat photo filter carousel

Semua orang tahu bahwa foto akan terlihat lebih bagus dengan filter. Pada codelab ini, Anda akan membuat rangkaian pilihan filter yang dapat digeser sesuai pilihan warna.

Selesaikan langkah-langkah praktikum berikut ini.

### Langkah 1: Buat project baru

Buatlah project flutter baru di pertemuan 09 dengan nama **photo_filter_carousel**

### Langkah 2: Buat widget Selector ring dan dark gradient

Buatlah folder `widget` dan file baru yang berisi kode berikut.

**lib/widget/filter_selector.dart**

```dart

```

### Langkah 3: Buat widget photo filter carousel

Buat file baru di folder widget dengan kode seperti berikut.

**lib/widget/filter_carousel.dart**

```dart

```

### Langkah 4: Membuat filter warna - bagian 1

Buat file baru di folder widget seperti kode berikut.

**lib/widget/carousel_flowdelegate.dart**

```dart

```

### Langkah 5: Membuat filter warna

Buat file baru di folder widget seperti kode berikut.

**lib/widget/filter_item.dart**

```dart

```

### Langkah 6: Implementasi filter carousel

Terakhir, kita impor widget `PhotoFilterCarousel` ke `main` seperti kode berikut ini.

**lib/main.dart**

```dart

```

### Troubleshoot

Jika diperlukan, beberapa widget yang telah Anda buat sebelumnya, memerlukan kode import berikut ini.

**lib/main.dart**

```dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ViewportOffset;
```

# Tugas Praktikum

1. Selesaikan Praktikum 1 dan 2, lalu dokumentasikan dan push ke repository Anda berupa screenshot setiap hasil pekerjaan beserta penjelasannya di file `README.md`! Jika terdapat error atau kode yang tidak dapat berjalan, silakan Anda perbaiki sesuai tujuan aplikasi dibuat! ꪜ
2. Gabungkan hasil praktikum 1 dengan hasil praktikum 2 sehingga setelah melakukan pengambilan foto, dapat dibuat filter carouselnya!
3. Jelaskan maksud `void async` pada praktikum 1? <br>
   Langkah 5 bertujuan
4. Jelaskan fungsi dari anotasi `@immutable` dan `@override`? <br>
   Tujuan utama
5. Kumpulkan link commit repository GitHub Anda kepada dosen yang telah disepakati! ꪜ
