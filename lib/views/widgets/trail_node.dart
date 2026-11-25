import 'package:flutter/material.dart';

import '../../theme/catppuccin_theme.dart';

/// Nó interativo do mapa de fases com sombra e bordas perfeitamente circulares.
class TrailNode extends StatelessWidget {
  final int levelNumber;
  final String title;
  final int stars;
  final bool isUnlocked;
  final bool isCompleted;
  final VoidCallback? onTap;

  const TrailNode({
    super.key,
    required this.levelNumber,
    required this.title,
    required this.stars,
    required this.isUnlocked,
    this.isCompleted = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Container com sombra circular externa
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: isUnlocked
                    ? [
                        BoxShadow(
                          color: CatppuccinColors.mauve.withValues(alpha: 0.4),
                          blurRadius: 14,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                color: isUnlocked
                    ? CatppuccinColors.mauve
                    : CatppuccinColors.surface0,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onTap,
                  splashColor: isUnlocked
                      ? CatppuccinColors.lavender.withValues(alpha: 0.3)
                      : Colors.transparent,
                  highlightColor: isUnlocked
                      ? CatppuccinColors.lavender.withValues(alpha: 0.2)
                      : Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isUnlocked
                            ? CatppuccinColors.lavender
                            : CatppuccinColors.surface1,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        isUnlocked ? Icons.play_arrow : Icons.lock,
                        color: isUnlocked
                            ? CatppuccinColors.base
                            : CatppuccinColors.subtext0,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (isUnlocked)
              Positioned(
                bottom: -6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: CatppuccinColors.yellow,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'FASE $levelNumber',
                    style: const TextStyle(
                      color: CatppuccinColors.base,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: TextStyle(
            color: isUnlocked
                ? CatppuccinColors.text
                : CatppuccinColors.subtext0,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (i) => Icon(
              i < stars ? Icons.star : Icons.star_border,
              color: CatppuccinColors.yellow,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
