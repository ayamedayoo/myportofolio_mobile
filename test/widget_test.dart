import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/menu.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/theme/app_theme.dart';
import 'package:myportofolio_mobile/widgets/item_card.dart';
import 'package:myportofolio_mobile/widgets/profile_header.dart';

/// Mengatur ukuran layar test, misalnya ukuran ponsel atau tablet.
void setScreenSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

int gridColumns(WidgetTester tester) {
  final grid = tester.widget<GridView>(find.byType(GridView));
  return (grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount)
      .crossAxisCount;
}

void main() {
  // Mode tema disimpan di variabel global, jadi dikembalikan ke terang
  // sebelum setiap test supaya test tidak saling memengaruhi.
  setUp(() => themeModeNotifier.value = ThemeMode.light);

  group('ItemHomepage', () {
    test('pesan SnackBar mengikuti nama tombol', () {
      const item = ItemHomepage('Logout', Icons.logout, Colors.red);
      expect(item.pressedMessage, 'Kamu telah menekan tombol Logout!');
    });
  });

  group('ProfileHeader', () {
    test('inisial diambil dari dua kata pertama nama', () {
      const header = ProfileHeader(name: 'Samuel Kaevin Phasca', subtitle: '');
      expect(header.initials, 'SK');
    });
  });

  group('Halaman utama', () {
    testWidgets('menampilkan identitas pemilik', (tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('2506657333'), findsOneWidget);
      expect(find.text('Samuel Kaevin Phasca'), findsOneWidget);
      expect(find.text('PBP E'), findsOneWidget);
      expect(find.text('SK'), findsOneWidget);
    });

    testWidgets('menampilkan empat tombol aksi', (tester) async {
      await tester.pumpWidget(const MyApp());

      for (final name in [
        'Lihat Proyek',
        'Lihat Award',
        'Tambah Proyek',
        'Logout',
      ]) {
        expect(find.text(name), findsOneWidget);
      }
    });

    testWidgets('setiap tombol punya warna latar yang berbeda', (tester) async {
      await tester.pumpWidget(const MyApp());

      final colors = tester
          .widgetList<ItemCard>(find.byType(ItemCard))
          .map((card) => card.item.color)
          .toSet();
      expect(colors.length, 4);
    });

    testWidgets('setiap tombol memunculkan SnackBar sesuai namanya', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      for (final name in [
        'Lihat Proyek',
        'Lihat Award',
        'Tambah Proyek',
        'Logout',
      ]) {
        // Grid bisa berada di bawah area layar test, jadi digulir dulu.
        await tester.ensureVisible(find.text(name));
        await tester.tap(find.text(name));
        await tester.pumpAndSettle();
        expect(find.text('Kamu telah menekan tombol $name!'), findsOneWidget);
      }
      // SnackBar lama diganti, bukan ditumpuk.
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('mengetuk kartu NPM menyalin NPM ke clipboard', (tester) async {
      String? copied;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            copied = (call.arguments as Map)['text'] as String;
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );

      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('2506657333'));
      await tester.pump();

      expect(copied, '2506657333');
      expect(find.text('NPM disalin: 2506657333'), findsOneWidget);
    });

    testWidgets('tombol di AppBar mengganti mode terang dan gelap', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      Brightness brightness() =>
          Theme.of(tester.element(find.byType(MyHomePage))).brightness;

      expect(brightness(), Brightness.light);
      await tester.tap(find.byTooltip('Mode gelap'));
      await tester.pumpAndSettle();
      expect(brightness(), Brightness.dark);
      await tester.tap(find.byTooltip('Mode terang'));
      await tester.pumpAndSettle();
      expect(brightness(), Brightness.light);
    });

    testWidgets('dua kolom dan tanpa overflow di layar ponsel', (tester) async {
      setScreenSize(tester, const Size(360, 640));
      await tester.pumpWidget(const MyApp());

      expect(gridColumns(tester), 2);
      // Overflow memicu exception, jadi test gagal kalau ada yang terpotong.
      expect(tester.takeException(), isNull);
    });

    testWidgets('empat kolom di layar lebar', (tester) async {
      setScreenSize(tester, const Size(1024, 768));
      await tester.pumpWidget(const MyApp());

      expect(gridColumns(tester), 4);
      expect(tester.takeException(), isNull);
    });
  });
}
