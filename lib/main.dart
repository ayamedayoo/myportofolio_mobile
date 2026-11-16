import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/menu.dart';
import 'package:myportofolio_mobile/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

/// Root aplikasi: hanya berisi pengaturan tema dan halaman awal.
/// Tampilan halaman utama ada di `menu.dart`.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Hanya MaterialApp yang dibangun ulang saat mode tema berganti.
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'MyPortfolio',
          debugShowCheckedModeBanner: false,
          theme: buildTheme(Brightness.light),
          darkTheme: buildTheme(Brightness.dark),
          themeMode: themeMode,
          home: MyHomePage(),
        );
      },
    );
  }
}
