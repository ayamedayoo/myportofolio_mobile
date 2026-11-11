# MyPortfolio Mobile

Aplikasi mobile Flutter untuk portofolio pribadi, dibuat untuk mata kuliah Pemrograman Berbasis Platform (PBP) Fasilkom UI, Semester Gasal 2026/2027. Aplikasi ini adalah pasangan dari website portofolio Django di repositori [ayamedayoo/myportofolio](https://github.com/ayamedayoo/myportofolio). Pada tutorial berikutnya, aplikasi akan dihubungkan ke API DRF di `/api/v1/`.

## Progres Mingguan

| Minggu | Yang dikerjakan |
| --- | --- |
| Tutorial 8 | Membuat proyek `myportofolio_mobile`, memisahkan halaman utama ke `lib/menu.dart`, mengubah tema warna (indigo dan amber), mengubah `MyHomePage` menjadi `StatelessWidget`, membuat widget `InfoCard` dan `ItemCard`, serta menampilkan SnackBar saat tombol ditekan. Data yang dipakai masih data contoh milik Burhan. |

## Struktur Proyek

```
lib/
├── main.dart   # titik awal aplikasi: MyApp (MaterialApp dan tema)
└── menu.dart   # halaman utama: MyHomePage, InfoCard, ItemHomepage, ItemCard
test/
└── widget_test.dart  # test identitas, tombol menu, dan SnackBar
```

## Cara Menjalankan Proyek

1. Pasang [Flutter SDK](https://docs.flutter.dev/get-started/install) dan pastikan folder `flutter/bin` sudah masuk ke PATH. Cek dengan:

   ```bash
   flutter doctor
   ```

2. Clone repositori, lalu masuk ke foldernya:

   ```bash
   git clone https://github.com/ayamedayoo/myportofolio_mobile.git
   cd myportofolio_mobile
   flutter pub get
   ```

3. Jalankan aplikasi di Google Chrome:

   ```bash
   flutter run -d chrome
   ```

4. Cek kualitas kode dan jalankan test:

   ```bash
   flutter analyze
   flutter test
   ```
