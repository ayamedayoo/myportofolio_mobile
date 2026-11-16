import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/widgets/info_card.dart';
import 'package:myportofolio_mobile/widgets/item_card.dart';

/// Halaman utama aplikasi portofolio.
///
/// Isinya tidak berubah selama aplikasi berjalan, jadi cukup memakai
/// [StatelessWidget]. Semua data diambil dari field `final` di bawah.
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506657333";
  final String nama = "Samuel Kaevin Phasca";
  final String kelas = "PBP E";

  /// Tombol aksi. Tombol yang mengarah ke bagian portofolio memakai warna
  /// dingin, sedangkan Logout memakai merah supaya tidak tertekan tanpa sengaja.
  final List<ItemHomepage> items = [
    ItemHomepage("Lihat Proyek", Icons.folder_open, Colors.blue.shade700),
    ItemHomepage("Lihat Award", Icons.emoji_events, Colors.purple.shade600),
    ItemHomepage("Tambah Proyek", Icons.add_circle, Colors.green.shade700),
    ItemHomepage("Logout", Icons.logout, Colors.red.shade700),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // SingleChildScrollView mencegah overflow saat isi halaman lebih
      // tinggi dari layar, misalnya di ponsel kecil atau mode lanskap.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // IntrinsicHeight + stretch menyamakan tinggi ketiga kartu,
            // walaupun nama butuh lebih dari satu baris.
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: InfoCard(title: 'NPM', content: npm),
                  ),
                  Expanded(
                    child: InfoCard(title: 'Name', content: nama),
                  ),
                  Expanded(
                    child: InfoCard(title: 'Class', content: kelas),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
              child: Text(
                'Selamat datang di Portofolio Samuel!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
            GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              // Grid ada di dalam SingleChildScrollView: tingginya mengikuti
              // isi dan scroll-nya diserahkan ke induk.
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: items.map((item) => ItemCard(item)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
