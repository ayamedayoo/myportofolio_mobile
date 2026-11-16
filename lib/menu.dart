import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/theme/app_theme.dart';
import 'package:myportofolio_mobile/widgets/info_card.dart';
import 'package:myportofolio_mobile/widgets/item_card.dart';
import 'package:myportofolio_mobile/widgets/profile_header.dart';

/// Lebar layar (logical pixel) mulai dari mana grid memakai empat kolom,
/// misalnya di tablet atau browser.
const double wideLayoutBreakpoint = 600;

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
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorScheme.primary,
        // onPrimary menjaga judul tetap terbaca di tema terang maupun gelap.
        foregroundColor: colorScheme.onPrimary,
        actions: [
          IconButton(
            tooltip: isDark ? 'Mode terang' : 'Mode gelap',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: toggleThemeMode,
          ),
        ],
      ),
      // SingleChildScrollView mencegah overflow saat isi halaman lebih
      // tinggi dari layar, misalnya di ponsel kecil atau mode lanskap.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProfileHeader(
              name: "Samuel Kaevin Phasca",
              subtitle: "Mahasiswa Fakultas Ilmu Komputer UI",
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 4),
            Text(
              'Ketuk kartu untuk menyalin isinya.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            // Jumlah kolom mengikuti lebar layar: dua di ponsel, empat di layar lebar.
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= wideLayoutBreakpoint;
                return GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: isWide ? 4 : 2,
                  childAspectRatio: isWide ? 1.1 : 1.3,
                  // Grid ada di dalam SingleChildScrollView: tingginya mengikuti
                  // isi dan scroll-nya diserahkan ke induk.
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: items.map((item) => ItemCard(item)).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
