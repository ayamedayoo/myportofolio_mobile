import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/widgets/app_snackbar.dart';

/// Tombol aksi berbentuk kartu. Warna latarnya diambil dari [ItemHomepage.color].
class ItemCard extends StatelessWidget {
  const ItemCard(this.item, {super.key});

  final ItemHomepage item;

  @override
  Widget build(BuildContext context) {
    // Semantics memberi tahu pembaca layar bahwa kartu ini sebuah tombol.
    return Semantics(
      button: true,
      label: item.name,
      excludeSemantics: true,
      child: Tooltip(
        message: item.name,
        child: Material(
          color: item.color,
          borderRadius: BorderRadius.circular(12),
          // Efek riak InkWell ikut melengkung mengikuti sudut kartu.
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              // Getaran singkat di ponsel sebagai tanda tombol sudah ditekan.
              HapticFeedback.lightImpact();
              showAppSnackBar(context, item.pressedMessage);
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, color: Colors.white, size: 30.0),
                  const SizedBox(height: 6),
                  Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
