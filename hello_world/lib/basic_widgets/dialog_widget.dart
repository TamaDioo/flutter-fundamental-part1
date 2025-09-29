import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // Pusatkan tombol di tengah layar
      child: Center(
        child: ElevatedButton(
          child: const Text('Show Alert'),
          onPressed: () {
            showAlertDialog(context);
          },
        ),
      ),
    );
  }
}

// Fungsi untuk menampilkan dialog
showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      // Menutup dialog saat tombol ditekan
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Dio Andika P. M. T."),
    content: const Text("Dio Andika P. M. T. - 2341720098"),
    actions: [okButton],
  );

  // Menampilkan dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
