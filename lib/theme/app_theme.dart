import 'package:material_ui/material_ui.dart';

/// Mode tema yang sedang aktif (terang atau gelap).
///
/// Disimpan di [ValueNotifier] supaya halaman tetap `StatelessWidget`.
/// Hanya widget yang mendengarkan notifier ini yang dibangun ulang.
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
  ThemeMode.light,
);

/// Mengganti tema terang ke gelap atau sebaliknya.
void toggleThemeMode() {
  themeModeNotifier.value = themeModeNotifier.value == ThemeMode.dark
      ? ThemeMode.light
      : ThemeMode.dark;
}

/// Tema terang dan gelap dibuat dari warna dasar yang sama dengan Tutorial 8.
ThemeData buildTheme(Brightness brightness) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      secondary: Colors.amber[700],
      brightness: brightness,
    ),
    useMaterial3: true,
  );
}
