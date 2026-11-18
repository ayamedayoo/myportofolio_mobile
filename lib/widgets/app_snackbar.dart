import 'package:material_ui/material_ui.dart';

/// Menampilkan SnackBar melayang dan menutup SnackBar lama lebih dulu,
/// supaya pesan langsung berganti saat beberapa tombol ditekan berturut-turut.
///
/// Dipakai bersama oleh `ItemCard` dan `InfoCard` agar tampilan pesannya seragam.
void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
}
