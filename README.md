# MyPortfolio Mobile

Nama : Samuel Kaevin Phasca

NPM : 2506657333

Kelas : PBP E

## Daftar Isi

- [Deskripsi Proyek](#deskripsi-proyek)
- [Progres Mingguan](#progres-mingguan)
- [Struktur Proyek](#struktur-proyek)
- [Tugas 7: Halaman Utama Portofolio](#tugas-7-halaman-utama-portofolio)
- [Cara Menjalankan Proyek](#cara-menjalankan-proyek)
- [AI Disclosure](#ai-disclosure)
- [Pertanyaan Reflektif](#pertanyaan-reflektif)

## Deskripsi Proyek

Aplikasi mobile Flutter untuk portofolio pribadi, dibuat untuk mata kuliah Pemrograman Berbasis Platform (PBP) Fasilkom UI, Semester Gasal 2026/2027. Aplikasi ini adalah pasangan dari website portofolio Django di repositori [ayamedayoo/myportofolio](https://github.com/ayamedayoo/myportofolio). Pada tutorial berikutnya, aplikasi akan dihubungkan ke API DRF di `/api/v1/`.

Untuk sekarang, aplikasi baru berisi halaman utama. API yang nanti dipakai termasuk API Award yang saya buat di Tugas 6.

Isi halaman utama saat ini:

- **Header profil** berisi avatar dengan inisial nama dan kalimat sapaan.
- **Kartu identitas** berisi NPM, nama, dan kelas. Isinya bisa disalin dengan mengetuk kartunya.
- **Tombol aksi** terdiri dari Lihat Proyek (biru), Lihat Award (ungu), Tambah Proyek (hijau), dan Logout (merah). Setiap tombol memunculkan SnackBar saat ditekan.
- **Mode gelap** bisa dinyalakan lewat tombol di pojok kanan atas.

## Progres Mingguan

| Minggu | Yang dikerjakan |
| --- | --- |
| Tutorial 8 | Membuat proyek `myportofolio_mobile`, memisahkan halaman utama ke `lib/menu.dart`, mengubah tema warna (indigo dan amber), mengubah `MyHomePage` menjadi `StatelessWidget`, membuat widget `InfoCard` dan `ItemCard`, serta menampilkan SnackBar saat tombol ditekan. Data yang dipakai masih data contoh milik Burhan. |
| Tutorial 9 | Menambahkan drawer menu (`LeftDrawer`) untuk berpindah ke Home dan Add Project, halaman form `ProjectFormPage` berisi nama, deskripsi, kategori (dropdown), teknologi, dan tautan proyek dengan validasi, pop-up `AlertDialog` yang menampilkan isi form, navigasi tombol Tambah Proyek dengan `Navigator.push()`, mengganti impor ke `package:material_ui/material_ui.dart`, serta refactoring ke folder `screens/` dan `widgets/`. Ditambah 4 test untuk navigasi dan form. |
| Tugas 7 | Data identitas diganti dengan data saya. Model `ItemHomepage` diberi atribut `color` supaya setiap tombol punya warna sendiri. Tombol disesuaikan dengan bagian portofolio saya (Proyek dan Award). Model dan widget dipisah ke folder sendiri, overflow halaman diperbaiki, dan ditambah mode gelap, grid responsif, salin isi kartu, header profil, serta 10 test. |

## Struktur Proyek

```
lib/
├── models/
│   └── item_homepage.dart     # model tombol aksi (nama, ikon, warna)
├── screens/
│   ├── menu.dart              # halaman utama: MyHomePage
│   └── project_form.dart      # halaman form tambah proyek: ProjectFormPage
├── theme/
│   └── app_theme.dart         # pembuat tema dan penyimpan mode terang/gelap
├── widgets/
│   ├── app_snackbar.dart      # fungsi SnackBar yang dipakai bersama
│   ├── info_card.dart         # kartu identitas (bisa disalin)
│   ├── left_drawer.dart       # drawer menu untuk navigasi antarhalaman
│   ├── profile_header.dart    # avatar inisial dan sapaan
│   └── project_card.dart      # kartu tombol aksi (ItemCard) dan navigasinya
└── main.dart                  # titik awal aplikasi: MyApp (MaterialApp dan tema)
test/
└── widget_test.dart  # test halaman utama, navigasi, dan form tambah proyek
```

## Tugas 7: Halaman Utama Portofolio

Di tugas ini, aplikasi contoh milik Burhan dari Tutorial 8 saya ubah menjadi halaman utama portofolio saya sendiri. Untuk minggu ini, setiap tombol baru memunculkan SnackBar. Navigasi ke halaman lain dan koneksi ke API Django akan ditambahkan di tutorial berikutnya.

### Yang bisa dilakukan di halaman utama

1. Melihat NPM, nama, dan kelas saya di tiga kartu identitas.
2. Menekan salah satu dari empat tombol aksi. Muncul SnackBar "Kamu telah menekan tombol [Nama Tombol]!".
3. Mengetuk kartu identitas untuk menyalin isinya. Muncul SnackBar, misalnya "NPM disalin: 2506657333".
4. Mengganti tema terang dan gelap lewat ikon bulan atau matahari di AppBar.

### Cara kerjanya

1. `main.dart` hanya berisi `MyApp`, yaitu `MaterialApp` beserta tema terang dan gelap. Tampilan halaman utama ada di `menu.dart`, sesuai alur Tutorial 8.

2. `MyHomePage` adalah `StatelessWidget`. NPM, nama, kelas, dan daftar tombol disimpan sebagai field `final`, jadi halaman ini tidak punya data yang berubah.

3. Warna tombol disimpan di model `ItemHomepage` lewat atribut `color`. `ItemCard` cukup membaca `item.color` untuk properti `color` milik widget `Material`. Jadi tidak ada percabangan if-else untuk memilih warna, dan menambah tombol baru cukup dengan menambah satu baris di list `items`. Pesan SnackBar juga diambil dari model lewat getter `pressedMessage`, jadi teksnya hanya ditulis di satu tempat.

4. Model, widget, dan tema dipisah ke folder masing-masing (`models/`, `widgets/`, `theme/`). Setiap file punya satu tugas, dan setiap class punya docstring.

5. SnackBar dimunculkan lewat satu fungsi, yaitu `showAppSnackBar`. Fungsi ini menutup SnackBar lama dengan `hideCurrentSnackBar()` sebelum memunculkan yang baru, jadi pesan langsung berganti saat beberapa tombol ditekan berturut-turut. `ItemCard` dan `InfoCard` sama-sama memakai fungsi ini.

6. Mode tema disimpan di `themeModeNotifier`, sebuah `ValueNotifier`. `MyApp` mendengarkannya lewat `ValueListenableBuilder`, jadi hanya `MaterialApp` yang dibangun ulang saat tema diganti. Dengan cara ini, `MyHomePage` tetap `StatelessWidget` sesuai instruksi.

7. Halaman dibungkus `SingleChildScrollView`. Tata letak Tutorial 8 tidak bisa digulir, dan dengan empat tombol isinya melebihi tinggi layar sehingga muncul error "RenderFlex overflowed by 422 pixels". Sekarang halaman bisa digulir dan grid diatur dengan `shrinkWrap` serta `NeverScrollableScrollPhysics`.

8. Grid tombol dibungkus `LayoutBuilder` untuk membaca lebar layar. Di bawah 600 piksel, grid memakai dua kolom. Di atas itu, misalnya di tablet atau browser, grid memakai empat kolom.

### Fitur tambahan di luar instruksi

1. Tombol keempat, **Lihat Award**, karena Award adalah bagian portofolio yang saya kerjakan sendiri di Tugas 3 sampai Tugas 6.
2. **Mode gelap** lewat tombol di AppBar. Warna AppBar dan teks mengikuti tema yang aktif.
3. **Grid responsif** dengan dua kolom di ponsel dan empat kolom di layar lebar.
4. **Salin isi kartu.** Kartu NPM, Name, dan Class bisa diketuk untuk menyalin isinya ke clipboard.
5. **Header profil** dengan avatar inisial "SK" yang dibuat otomatis dari nama.
6. Tinggi ketiga kartu identitas disamakan (`IntrinsicHeight`), walaupun nama butuh tiga baris di layar ponsel.
7. Tombol aksi punya `Tooltip`, label untuk pembaca layar (`Semantics`), dan getaran singkat di ponsel saat ditekan (`HapticFeedback`).
8. SnackBar berbentuk melayang dan tidak menumpuk saat tombol ditekan berkali-kali.
9. **10 test** di `test/widget_test.dart`. Test ini memeriksa identitas, keempat tombol, warna yang berbeda, pesan SnackBar setiap tombol, fitur salin, mode gelap, serta jumlah kolom dan tidak adanya overflow di ukuran ponsel dan tablet.

### Cara mencoba

1. Jalankan aplikasi dengan `flutter run -d chrome`. Pastikan kartu NPM, Name, dan Class berisi data yang benar.
2. Tekan setiap tombol aksi. Perhatikan bahwa pesan SnackBar sesuai dengan nama tombolnya dan langsung berganti saat tombol lain ditekan.
3. Ketuk kartu NPM, lalu tempel (paste) di aplikasi lain untuk memastikan NPM sudah tersalin.
4. Tekan ikon bulan di AppBar untuk masuk ke mode gelap, lalu ikon matahari untuk kembali ke mode terang.
5. Ubah lebar jendela Chrome. Grid berubah dari dua kolom menjadi empat kolom saat jendela dilebarkan.

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

   Untuk emulator Android, cukup jalankan `flutter run`.

4. Cek kualitas kode dan jalankan test:

   ```bash
   flutter analyze
   flutter test
   ```

## AI Disclosure

Saya memakai Claude Code (lewat aplikasi desktop Claude) sebagai teman diskusi dan pembimbing selama mengerjakan proyek ini, sama seperti di proyek Django. Posisinya lebih ke "asdos pribadi" yang bisa ditanya kapan saja. Ia memberi rekomendasi, menunjukkan arah, dan membantu menyusun draf kode. Keputusan, pengecekan, dan tanggung jawab atas hasil akhirnya tetap di saya.

Tutorial 8

- Alat yang saya pakai adalah Claude Code lewat aplikasi desktop Claude.
- Claude membantu saya memasang Flutter SDK dan Android SDK, mengatur PATH, membuat repositori GitHub, dan menyusun kode tutorial.

Tugas 7

- Alat yang saya pakai adalah Claude Code lewat aplikasi desktop Claude.
- Claude membantu saya menyusun kode halaman utama, memisahkan widget ke folder sendiri, menulis test, melakukan debugging, dan memberikan arahan jika terdapat yang eror

Strategi prompting:
Saya memberikan requirement soalnya  agar AI memahami konteks tugas. Dengan begitu, ketika saya beres melakukan coding dan mengalami kebuntuan (error), AI dapat memberikan petunjuk (hint) dan rekomendasi perbaikan yang selaras dengan target nilai.

Selama pengerjaan, saya melakukan commit kode secara lokal dan menunda proses push. Di tahap ini, saya menggunakan AI untuk melakukan code review atas pekerjaan saya guna memastikan tidak ada bug atau kesalahan logika yang terlewat sebelum kode tersebut dikumpulkan.

Setelah draf awal selesai saya kerjakan, saya meminta AI untuk mengevaluasi source code saya berdasarkan rubrik. Untuk kriteria yang belum terpenuhi, saya meminta AI menunjukkan letak kekeliruannya, lalu saya memperbaiki bagian tersebut secara mandiri berdasarkan saran yang diberikan.

Untuk bagian README, saya menulis keseluruhan drafnya sendiri dan hanya menggunakan AI untuk proofreading (pengecekan tata bahasa). Saya menyeleksi saran perbaikannya agar gaya bahasa dan formatnya tetap natural dan konsisten dengan tulisan saya di repositori Django sebelumnya.

Bagian yang dibantu secara spesifik:

| Bagian | Bantuan Claude |
| --- | --- |
| `lib/menu.dart` | Mengganti data Burhan dengan data saya, menyusun empat tombol, grid responsif, dan tombol mode gelap |
| `lib/models/item_homepage.dart` | Model tombol dengan atribut `color` dan getter `pressedMessage` |
| `lib/widgets/` | Memisahkan `InfoCard` dan `ItemCard`, menambah `ProfileHeader`, `showAppSnackBar`, fitur salin, Tooltip, Semantics, dan getaran |
| `lib/theme/app_theme.dart`, `lib/main.dart` | Tema terang dan gelap dengan `ValueNotifier` |
| `test/widget_test.dart` | Menulis 10 test, lalu menjalankan `flutter analyze` dan `flutter test` |
| `README.md` | Draf penjelasan Tugas 7 dan jawaban reflektif |

Yang saya putuskan sendiri:
- Pada percobaan pertama tanggal 9 November, saya sadar bahwa tugas yang sedang berjalan adalah Tugas 6, bukan Tugas 7. Saya meminta semua hasil Tugas 7 saat itu dihapus dan mengerjakan Tugas 6 lebih dulu. Tugas 7 di repositori ini dikerjakan ulang dari hasil Tutorial 8.
- Saya meminta Tugas 7 belum di-push sampai saya memeriksanya, dan meminta commit tidak memakai atribusi Claude.
- Saya menilai gaya bahasa README kurang cocok dengan tulisan saya. Titik duanya terlalu banyak, dan jawaban reflektifnya terlalu banyak memakai bahasa gaul. Saya lalu meminta README mengikuti gaya README Django dan meminta jawaban reflektif memakai bahasa sehari-hari dengan kalimat efektif.

Log prompting (pesan yang saya kirim ke Claude untuk Tutorial 8 dan Tugas 7, ditulis ulang tanpa salah ketik):
1. (Melampirkan `tugas-7.pdf`, 9 November) "Cari folder myportofolio lalu kerjakan ini." Hasilnya kemudian saya minta dihapus karena tugas yang sedang berjalan adalah Tugas 6.
2. (Melampirkan `tutorial-8.pdf`, 11 November) "Kerjakan."
3. "Apakah tutorial sudah dikerjakan semua?"
4. "Selesaikan semuanya agar statusnya berhasil semua, lalu push ke GitHub tanpa atribusi Claude."
5. "Kamu saja yang buatkan GitHub dan tambahkan PATH-nya sendiri."
6. (Melampirkan `tugas-7.pdf`, 16 November) "Kerjakan Tugas 7-nya dengan baik dan mendapatkan nilai 4/4 di seluruh subtest, jangan melakukan push dulu."
7. "Apakah kamu juga sudah update README-nya?"
8. Meminta AI disclosure dibuat ringkas seperti minggu-minggu sebelumnya.
9. "Aku ingin kamu melihat gaya bahasa di README.md di myportofolio, jadi jangan menggunakan tanda titik dua berlebihan."
10. "Apakah semuanya sudah mendapatkan 4/4? Selain itu, aku ingin pertanyaan reflektif dibuat jauh lebih humanis dengan bahasa sehari-hari dan kalimat efektif (SPOK)."
11. "Aku ingin dokumentasi dan AI-nya juga dapat 4."

Keterbatasan AI yang saya temukan dan perbaikannya:
- **AI ikut menyalin kelemahan dari contoh.** Tata letak Tutorial 8 tidak bisa digulir. Dengan tiga tombol, masalah ini tidak terlihat. Setelah tombol keempat ditambahkan, isi halaman melebihi layar dan muncul error "RenderFlex overflowed by 422 pixels". Draf pertama Claude masih memakai tata letak tutorial apa adanya. Masalah ini baru ketahuan dari test, lalu diperbaiki dengan `SingleChildScrollView`. Pelajarannya, kode contoh dari tutorial tetap perlu diuji ulang setelah diubah.
- **Hasil pengecekan bisa terlihat lolos padahal gagal.** Pada commit pertama, perintah test dan commit dijalankan berurutan, tetapi hasil test hanya dibaca dari baris terakhir. Cara itu selalu dianggap berhasil, sehingga commit tetap masuk walaupun test-nya gagal. Kesalahan ini terlihat dari isi output dan diperbaiki di commit berikutnya. Sejak itu, setiap pengecekan memeriksa kode keluar (exit code) test, bukan hanya teks terakhirnya.
- **Layar test berbeda dengan layar asli.** Ukuran layar bawaan test Flutter adalah 800x600 piksel. Akibatnya, tombol bisa berada di luar layar dan ketukan test tidak mengenai apa pun. Test perlu menggulir ke tombol lebih dulu dengan `ensureVisible`, dan perlu diuji juga di ukuran ponsel (360x640) dan tablet (1024x768).

## Pertanyaan Reflektif

### Tugas 7

1. Saya membayangkan widget tree seperti boneka Rusia yang saling membungkus, karena setiap widget di Flutter bisa membungkus widget lain di dalamnya. Di aplikasi saya, `MyApp` membungkus `MaterialApp`, lalu `MaterialApp` membungkus `MyHomePage` yang di dalamnya ada `Scaffold`, dan susunan itu terus turun sampai ke widget kecil seperti `Text` dan `Icon`. Susunan bertingkat inilah yang disebut widget tree.

   Hubungan induk dan anak berjalan dari atas ke bawah. Induk memberi batas ruang kepada anaknya, kemudian anak memilih ukurannya sendiri di dalam batas itu, sedangkan induk yang menentukan posisi anak tersebut. Di halaman saya, `Row` membagi lebarnya menjadi tiga bagian yang sama lewat `Expanded` sehingga setiap `InfoCard` mendapat lebar yang sama. Induk juga mengirim data kepada anak lewat konstruktor, misalnya ketika `MyHomePage` mengirim objek `ItemHomepage` kepada `ItemCard` yang kemudian memakai `item.color` sebagai warna latarnya. Sebaliknya, anak juga bisa mengambil data dari widget di atasnya, seperti `Theme.of(context)` yang mengambil tema dari `MaterialApp` walaupun letaknya jauh di atas.

2. Saya memakai cukup banyak widget, jadi saya mengelompokkannya sesuai kegunaannya.

   Kelompok pertama adalah kerangka aplikasi. `MaterialApp` mengatur judul, tema terang dan gelap, serta halaman awal, sedangkan `ValueListenableBuilder` membungkus `MaterialApp` agar tampilannya berganti setiap kali mode tema berubah. `Scaffold` menyediakan kerangka halaman untuk `AppBar`, isi halaman, dan SnackBar, sementara `AppBar` menampilkan judul di bagian atas sekaligus menjadi tempat `IconButton` untuk mengganti tema.

   Kelompok kedua adalah pengatur tata letak. `SingleChildScrollView` membuat halaman bisa digulir sehingga isinya tidak terpotong. `Column` menyusun widget dari atas ke bawah, sedangkan `Row` menyusun widget dari kiri ke kanan. `Expanded` membagi lebar `Row` secara rata untuk tiga kartu identitas, lalu `IntrinsicHeight` menyamakan tinggi ketiganya, dan `Padding` serta `SizedBox` memberi jarak antarbagian. `LayoutBuilder` membaca lebar layar untuk menentukan jumlah kolom, kemudian `GridView.count` menyusun tombol dalam dua atau empat kolom.

   Kelompok ketiga adalah isi tampilan. `Text` menampilkan tulisan dan `Icon` menampilkan ikon, sedangkan `CircleAvatar` menampilkan inisial "SK" di dalam lingkaran dan `Card` membentuk kotak berbayang untuk `InfoCard`. Di dalam `ItemCard`, `Material` memberi warna latar dan sudut melengkung, sementara `InkWell` membuat kartu bisa diketuk sambil menampilkan efek riak. `Tooltip` menampilkan nama tombol ketika tombol ditekan lama, `Semantics` memberi tahu pembaca layar bahwa kartu itu adalah tombol, dan `SnackBar` menampilkan pesan singkat di bagian bawah layar lewat `ScaffoldMessenger`.

   Selain widget bawaan Flutter, saya juga membuat widget sendiri, yaitu `MyApp`, `MyHomePage`, `ProfileHeader`, `InfoCard`, dan `ItemCard`.

3. `MaterialApp` menyediakan kebutuhan dasar aplikasi bergaya Material Design, mulai dari tema, perpindahan antarhalaman lewat `Navigator`, sampai `ScaffoldMessenger` untuk SnackBar, sedangkan judul aplikasi dan pengaturan bahasa juga diatur di sini.

   Kebanyakan aplikasi Flutter menaruh `MaterialApp` di posisi paling atas karena banyak widget di bawahnya mencari data ke arah atas. `Theme.of(context)` mencari tema dan `ScaffoldMessenger.of(context)` mencari tempat untuk menampilkan SnackBar, sehingga pencarian itu tidak akan menemukan apa pun dan aplikasi bisa error jika `MaterialApp` tidak ada di atas. Di aplikasi saya, `MaterialApp` juga menyimpan tema terang dan gelap, jadi semua halaman di bawahnya langsung ikut berubah ketika saya mengganti mode tema.

4. `StatelessWidget` adalah widget yang tidak menyimpan data yang berubah, sehingga tampilannya hanya bergantung pada data dari induknya. `StatefulWidget` justru punya objek `State` untuk menyimpan data yang bisa berubah, dan ketika data itu berubah, kita memanggil `setState()` agar Flutter menggambar ulang tampilannya.

   Saya memilih `StatelessWidget` untuk tampilan yang isinya tetap, seperti halaman utama, `InfoCard`, dan `ItemCard` di tugas ini. Sebaliknya, saya akan memilih `StatefulWidget` jika sebuah widget perlu mengingat perubahan dari interaksi pengguna, misalnya isi form, checkbox, angka penghitung, atau data yang dimuat dari internet. Awalnya saya mengira fitur mode gelap pasti membutuhkan `StatefulWidget`, tetapi ternyata halaman saya tetap bisa memakai `StatelessWidget` karena mode tema saya simpan di `ValueNotifier` dan hanya `ValueListenableBuilder` di `MyApp` yang mendengarkan perubahannya.

5. `BuildContext` adalah alamat sebuah widget di dalam widget tree yang diberikan Flutter kepada setiap widget lewat method `build(BuildContext context)`. Dengan alamat itu, sebuah widget bisa mencari data dari widget di atasnya. Di tugas ini, saya memakai `Theme.of(context)` agar warna `AppBar` dan teks mengikuti tema, dan saya juga memakai `ScaffoldMessenger.of(context)` untuk menampilkan SnackBar.

   Dari tugas ini, saya belajar dua hal tentang context. Pertama, pencarian lewat context selalu dimulai dari widget itu sendiri ke arah atas, bukan ke bawah. Kedua, context bisa kedaluwarsa setelah proses yang memakan waktu, sehingga di `InfoCard` saya memeriksa `context.mounted` lebih dulu setelah proses penyalinan ke clipboard selesai, karena kartunya bisa saja sudah hilang dari layar. Aplikasi baru menampilkan SnackBar jika kartunya masih ada.

6. Hot reload memasukkan perubahan kode ke aplikasi yang sedang berjalan, lalu Flutter menjalankan ulang method `build` tanpa menghapus state aplikasi, sehingga aplikasi saya tetap berada di mode gelap setelah hot reload. Proses ini biasanya selesai dalam waktu kurang dari satu detik. Sementara itu, hot restart menjalankan ulang aplikasi dari awal dengan kode baru, sehingga semua state kembali ke nilai awal dan mode gelap tadi kembali menjadi mode terang. Hot restart memang lebih lambat, tetapi masih lebih cepat daripada mematikan lalu menyalakan ulang aplikasi.

   Hot reload tidak cukup untuk perubahan di luar method `build`, seperti perubahan pada fungsi `main()`, perubahan nilai awal variabel global seperti `themeModeNotifier`, atau pergantian `StatelessWidget` menjadi `StatefulWidget`, karena perubahan seperti itu membutuhkan hot restart. Untuk perubahan yang lebih besar, misalnya penambahan package baru di `pubspec.yaml`, penambahan aset baru, atau perubahan kode native Android dan iOS, kita perlu melakukan full restart dengan menghentikan lalu menjalankan ulang `flutter run`.
