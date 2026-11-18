import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:myportofolio_mobile/widgets/app_snackbar.dart';

/// Kartu kecil untuk satu data identitas, misalnya NPM.
///
/// Kartu bisa diketuk untuk menyalin isinya ke clipboard.
class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.content});

  /// Label di bagian atas kartu, misalnya "NPM".
  final String title;

  /// Isi data, misalnya "2506657333".
  final String content;

  Future<void> _copyContent(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: content));
    // Setelah await, widget bisa saja sudah hilang dari layar.
    if (!context.mounted) return;
    showAppSnackBar(context, '$title disalin: $content');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _copyContent(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              Text(content, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
