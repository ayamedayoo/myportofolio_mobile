import 'package:flutter/material.dart';

/// Data untuk satu tombol aksi di halaman utama.
///
/// Warna latar disimpan di model, jadi `ItemCard` cukup membaca [color]
/// tanpa percabangan if-else. Menambah tombol baru cukup dengan menambah
/// satu objek `ItemHomepage` di daftar tombol.
class ItemHomepage {
  /// Nama tombol, juga dipakai di pesan SnackBar.
  final String name;

  /// Ikon yang tampil di atas nama tombol.
  final IconData icon;

  /// Warna latar kartu tombol.
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);

  /// Pesan SnackBar saat tombol ini ditekan.
  String get pressedMessage => 'Kamu telah menekan tombol $name!';
}
