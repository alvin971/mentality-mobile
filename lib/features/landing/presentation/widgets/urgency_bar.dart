import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/theme/app_colors.dart';

/// Badge pill natif mobile — pas de bandeau pleine largeur web.
/// S'intègre dans le Hero comme une notification discrète.
class UrgencyBadge extends StatelessWidget {
  const UrgencyBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulsingDot(),
          const SizedBox(width: 7),
          Text(
            '8 800 places restantes',
            style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: const BoxDecoration(
        color: AppColors.accent,
        shape: BoxShape.circle,
      ),
    )
        .animate(onPlay: (c) => c.repeat())
        .fadeOut(duration: 900.ms)
        .then()
        .fadeIn(duration: 900.ms);
  }
}

// Gardé pour compatibilité mais redirige vers le badge
class UrgencyBar extends StatelessWidget {
  const UrgencyBar({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
