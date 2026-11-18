import 'package:material_ui/material_ui.dart';

/// Sapaan di bagian atas halaman: avatar berisi inisial dan nama pemilik.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.name, required this.subtitle});

  final String name;
  final String subtitle;

  /// Huruf pertama dari dua kata pertama nama, misalnya "SK".
  String get initials => name
      .split(' ')
      .where((word) => word.isNotEmpty)
      .take(2)
      .map((word) => word[0].toUpperCase())
      .join();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 34,
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            initials,
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Selamat datang di Portofolio Samuel!',
          textAlign: TextAlign.center,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
