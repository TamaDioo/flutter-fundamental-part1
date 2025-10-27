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
@immutable
class FilterSelector extends StatefulWidget {
  const FilterSelector({
    super.key,
    required this.filters,
    required this.onFilterChanged,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
  });

  final List<Color> filters;
  final void Function(Color selectedColor) onFilterChanged;
  final EdgeInsets padding;

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  static const _filtersPerScreen = 5;
  static const _viewportFractionPerItem = 1.0 / _filtersPerScreen;

  late final PageController _controller;
  late int _page;

  int get filterCount => widget.filters.length;

  Color itemColor(int index) => widget.filters[index % filterCount];

  @override
  void initState() {
    super.initState();
    _page = 0;
    _controller = PageController(
      initialPage: _page,
      viewportFraction: _viewportFractionPerItem,
    );
    _controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = (_controller.page ?? 0).round();
    if (page != _page) {
      _page = page;
      widget.onFilterChanged(widget.filters[page]);
    }
  }

  void _onFilterTapped(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 450),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      controller: _controller,
      axisDirection: AxisDirection.right,
      physics: const PageScrollPhysics(),
      viewportBuilder: (context, viewportOffset) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final itemSize = constraints.maxWidth * _viewportFractionPerItem;
            viewportOffset
              ..applyViewportDimension(constraints.maxWidth)
              ..applyContentDimensions(0.0, itemSize * (filterCount - 1));

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _buildShadowGradient(itemSize),
                _buildCarousel(
                  viewportOffset: viewportOffset,
                  itemSize: itemSize,
                ),
                _buildSelectionRing(itemSize),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildShadowGradient(double itemSize) {
    return SizedBox(
      height: itemSize * 2 + widget.padding.vertical,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
        child: SizedBox.expand(),
      ),
    );
  }

  Widget _buildCarousel({
    required ViewportOffset viewportOffset,
    required double itemSize,
  }) {
    return Container(
      height: itemSize,
      margin: widget.padding,
      child: Flow(
        delegate: CarouselFlowDelegate(
          viewportOffset: viewportOffset,
          filtersPerScreen: _filtersPerScreen,
        ),
        children: [
          for (int i = 0; i < filterCount; i++)
            FilterItem(
              onFilterSelected: () => _onFilterTapped(i),
              color: itemColor(i),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectionRing(double itemSize) {
    return IgnorePointer(
      child: Padding(
        padding: widget.padding,
        child: SizedBox(
          width: itemSize,
          height: itemSize,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(width: 6, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### Langkah 3: Buat widget photo filter carousel

Buat file baru di folder widget dengan kode seperti berikut.

**lib/widget/filter_carousel.dart**

```dart
@immutable
class PhotoFilterCarousel extends StatefulWidget {
  const PhotoFilterCarousel({super.key});

  @override
  State<PhotoFilterCarousel> createState() => _PhotoFilterCarouselState();
}

class _PhotoFilterCarouselState extends State<PhotoFilterCarousel> {
  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];

  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: _buildPhotoWithFilter(),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: _buildFilterSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoWithFilter() {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, color, child) {
        // Anda bisa ganti dengan foto Anda sendiri
        return Image.network(
          // 'https://docs.flutter.dev/cookbook/img-files'
          // '/effects/instagram-buttons/millennial-dude.jpg',
          'https://fastly.picsum.photos/id/17/720/1600.jpg?hmac=CPuW1f4SQFsPyZGOroXTW4bN_lakGE8Gse9y3-QP_Js',
          color: color.withOpacity(0.5),
          colorBlendMode: BlendMode.color,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}
```

### Langkah 4: Membuat filter warna - bagian 1

Buat file baru di folder widget seperti kode berikut.

**lib/widget/carousel_flowdelegate.dart**

```dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ViewportOffset;

class CarouselFlowDelegate extends FlowDelegate {
  CarouselFlowDelegate({
    required this.viewportOffset,
    required this.filtersPerScreen,
  }) : super(repaint: viewportOffset);

  final ViewportOffset viewportOffset;
  final int filtersPerScreen;

  @override
  void paintChildren(FlowPaintingContext context) {
    final count = context.childCount;

    // All available painting width
    final size = context.size.width;

    // The distance that a single item "page" takes up from the perspective
    // of the scroll paging system. We also use this size for the width and
    // height of a single item.
    final itemExtent = size / filtersPerScreen;

    // The current scroll position expressed as an item fraction, e.g., 0.0,
    // or 1.0, or 1.3, or 2.9, etc. A value of 1.3 indicates that item at
    // index 1 is active, and the user has scrolled 30% towards the item at
    // index 2.
    final active = viewportOffset.pixels / itemExtent;

    // Index of the first item we need to paint at this moment.
    // At most, we paint 3 items to the left of the active item.
    final min = math.max(0, active.floor() - 3).toInt();

    // Index of the last item we need to paint at this moment.
    // At most, we paint 3 items to the right of the active item.
    final max = math.min(count - 1, active.ceil() + 3).toInt();

    // Generate transforms for the visible items and sort by distance.
    for (var index = min; index <= max; index++) {
      final itemXFromCenter = itemExtent * index - viewportOffset.pixels;
      final percentFromCenter = 1.0 - (itemXFromCenter / (size / 2)).abs();
      final itemScale = 0.5 + (percentFromCenter * 0.5);
      final opacity = 0.25 + (percentFromCenter * 0.75);

      final itemTransform = Matrix4.identity()
        ..translate((size - itemExtent) / 2)
        ..translate(itemXFromCenter)
        ..translate(itemExtent / 2, itemExtent / 2)
        ..multiply(Matrix4.diagonal3Values(itemScale, itemScale, 1.0))
        ..translate(-itemExtent / 2, -itemExtent / 2);

      context.paintChild(index, transform: itemTransform, opacity: opacity);
    }
  }

  @override
  bool shouldRepaint(covariant CarouselFlowDelegate oldDelegate) {
    return oldDelegate.viewportOffset != viewportOffset;
  }
}
```

### Langkah 5: Membuat filter warna

Buat file baru di folder widget seperti kode berikut.

**lib/widget/filter_item.dart**

```dart
import 'package:flutter/material.dart';

@immutable
class FilterItem extends StatelessWidget {
  const FilterItem({super.key, required this.color, this.onFilterSelected});

  final Color color;
  final VoidCallback? onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterSelected,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            child: Image.network(
              // 'https://picsum.photos/150',
              'https://fastly.picsum.photos/id/381/150/150.jpg?hmac=g8od_Yw0Vp8XuxFdKO1LF2fv7RZCLn3VJXvMqCOyako',
              // 'https://docs.flutter.dev/cookbook/img-files'
              // '/effects/instagram-buttons/millennial-texture.jpg',
              color: color.withOpacity(0.5),
              colorBlendMode: BlendMode.hardLight,
            ),
          ),
        ),
      ),
    );
  }
}
```

### Langkah 6: Implementasi filter carousel

Terakhir, kita impor widget `PhotoFilterCarousel` ke `main` seperti kode berikut ini.

**lib/main.dart**

```dart
import 'package:flutter/material.dart';
import 'package:photo_filter_carousel/widget/filter_carousel.dart';

void main() {
  runApp(
    const MaterialApp(
      home: PhotoFilterCarousel(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
```

### Troubleshoot

Jika diperlukan, beberapa widget yang telah Anda buat sebelumnya, memerlukan kode import berikut ini.

**lib/main.dart**

```dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ViewportOffset;
```

### Hasil Output

![Praktikum 2](images/prak2_hasil.gif)

# Tugas Praktikum

1. Selesaikan Praktikum 1 dan 2, lalu dokumentasikan dan push ke repository Anda berupa screenshot setiap hasil pekerjaan beserta penjelasannya di file `README.md`! Jika terdapat error atau kode yang tidak dapat berjalan, silakan Anda perbaiki sesuai tujuan aplikasi dibuat! ꪜ
2. Gabungkan hasil praktikum 1 dengan hasil praktikum 2 sehingga setelah melakukan pengambilan foto, dapat dibuat filter carouselnya! ꪜ <br>
   Hasil Output:

   ![Tugas Praktikum](images/tuprak2.gif)

   ![Tugas Praktikum](images/tuprak2.2.gif)

3. Jelaskan maksud `void async` pada praktikum 1? <br>
   Keyword `async` adalah singkatan dari asynchronous (asinkron). Keyword `async` pada fungsi main menandakan bahwa ada proses di dalam fungsi tersebut yang tidak bisa selesai secara instan dan aplikasi harus menunggu proses itu selesai sebelum melanjutkan ke langkah berikutnya. Fungsi yang ditandai `async` secara otomatis akan mengembalikan sebuah `Future`. Ini memberi tahu Dart bahwa fungsi tersebut mungkin akan melakukan pekerjaan yang memakan waktu (seperti mengakses kamera, query database, atau mengunduh file) dan tidak akan selesai secara instan. Pada praktikum 1, proses yang butuh waktu itu adalah fungsi `availableCameras()`, yang perlu berkomunikasi dengan sistem operasi perangkat (Android/iOS) untuk mendapatkan daftar kamera yang tersedia. Ini bukan proses instan, mungkin butuh beberapa milidetik. <br>
   Keyword `await` hanya bisa digunakan di dalam fungsi yang sudah ditandai `async`. Keyword `await` akan menjeda eksekusi fungsi tersebut (bukan seluruh aplikasi) sampai operasi yang ditunggu (`Future`) selesai dan mengembalikan hasilnya. Ini berarti `await` akan menunggu sampai proses `availableCameras()` benar-benar selesai dan memberikan hasilnya (daftar kamera). Setelah hasilnya dapat, baru melanjutkan eksekusi ke baris kode berikutnya. Tanpa `await`, main akan langsung mencoba menjalankan `runApp(...)` tanpa memiliki daftar kamera, yang akan menyebabkan error karena variabel `firstCamera` belum siap.
4. Jelaskan fungsi dari anotasi `@immutable` dan `@override`? <br>

   - `@immutable` artinya tidak bisa diubah. Anotasi `@immutable` memberitahukan bahwa sebuah class dan semua propertinya tidak boleh diubah setelah objeknya dibuat. Dengan kata lain, semua field (variabel) di dalam class itu harus bersifat `final`. Di Flutter, semua Widget harus immutable. Ini adalah prinsip dasar dari cara Flutter bekerja. Flutter membangun ulang UI dengan cara membuang Widget lama dan membuat yang baru, bukan dengan mengubah Widget yang sudah ada. Misal pada `lib/widget/filter_item.dart`:

     ```dart
     @immutable
     class FilterItem extends StatelessWidget {
        const FilterItem({super.key, required this.color, this.onFilterSelected});

        final Color color; // <- final
        final VoidCallback? onFilterSelected; // <- final

        @override
        Widget build(BuildContext context) {
           // ...
        }
     }
     ```

     Anotasi `@immutable` di atas class `FilterItem` adalah penegasan bahwa sekali `FilterItem` dibuat dengan `color` tertentu, nilai `color` tersebut tidak akan pernah diubah lagi seumur hidup objek `FilterItem` itu Semua propertinya juga ditandai dengan final. Jika mencoba menghapus final, compiler akan memberikan peringatan karena melanggar kontrak `@immutable`.

   - Anotasi `@override` adalah penanda bahwa sebuah method di subclass sengaja menimpa (menggantikan) method dengan nama yang sama dari kelas induknya (superclass). Hal ini dapat mencegah kesalahan pengetikan (typo). Jika tidak sengaja salah mengetikkan nama method yang seharusnya ditimpa, compiler akan memberi tahu. Misalnya, jika ingin menimpa `initState` tapi malah mengetik `initstate` (dengan huruf 's' kecil), tanpa `@override`, kode akan berjalan tanpa error, tapi method inisialisasi tidak akan pernah dipanggil. Dengan `@override`, compiler akan langsung memberi tahu bahwa tidak ada method 'initstate' di kelas induk yang bisa ditimpa. `@override` juga menjelaskan bahwa method ini bukan method baru, melainkan implementasi ulang dari method yang sudah ada di kelas induknya.
   - Jadi, `@immutable` memastikan properti widget tidak bisa diubah. Sedangkan `@override` memastikan tidak terjadi typo (salah ketik) saat mengganti method bawaan Flutter seperti `initState`, `build`, atau `dispose`.

5. Kumpulkan link commit repository GitHub Anda kepada dosen yang telah disepakati! ꪜ
