import 'package:flutter_test/flutter_test.dart';

import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('Halaman utama menampilkan identitas dan tombol menu', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('2506657333'), findsOneWidget);
    expect(find.text('Samuel Kaevin Phasca'), findsOneWidget);
    expect(find.text('PBP E'), findsOneWidget);
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('Menekan tombol memunculkan SnackBar', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Grid tombol bisa berada di bawah area layar test, jadi digulir dulu.
    await tester.ensureVisible(find.text('Lihat Proyek'));
    await tester.tap(find.text('Lihat Proyek'));
    await tester.pump();
    expect(
      find.text('Kamu telah menekan tombol Lihat Proyek!'),
      findsOneWidget,
    );
  });
}
