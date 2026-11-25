import 'package:flutter/material.dart';

import '../../theme/catppuccin_theme.dart';

/// Card do Avatar Ada Lovelace com visual Toon e balão de fala
class AdaAvatarCard extends StatelessWidget {
  final String message;

  const AdaAvatarCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CatppuccinColors.surface0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Avatar Ilustrado / Ícone da Ada
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: CatppuccinColors.lavender, width: 2),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/ada-icon.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.face_3,
                    color: CatppuccinColors.lavender,
                    size: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Balão de fala
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: CatppuccinColors.mantle,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: CatppuccinColors.surface1),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: CatppuccinColors.text,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
