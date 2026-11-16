import 'package:flutter/material.dart';

/// Kartu kecil untuk satu data identitas, misalnya NPM.
class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.content});

  /// Label di bagian atas kartu, misalnya "NPM".
  final String title;

  /// Isi data, misalnya "2506657333".
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
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
    );
  }
}
