import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class CognitiveProfileSection extends StatelessWidget {
  const CognitiveProfileSection({super.key});

  static const List<_IndexBadgeData> _indices = [
    _IndexBadgeData(
      code: 'ICV',
      score: 112,
      label: 'Compréhension Verbale',
      color: Color(0xFF4D7C4A),
    ),
    _IndexBadgeData(
      code: 'IRP',
      score: 108,
      label: 'Raisonnement Perceptif',
      color: Color(0xFF5E7C6F),
    ),
    _IndexBadgeData(
      code: 'IMT',
      score: 115,
      label: 'Mémoire de Travail',
      color: Color(0xFF3D7A5C),
    ),
    _IndexBadgeData(
      code: 'IVT',
      score: 104,
      label: 'Vitesse de Traitement',
      color: Color(0xFF8A7C4A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            'Votre profil cognitif complet',
            style: AppTextStyles.serif(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 28),
          _buildQIDisplay(),
          const SizedBox(height: 24),
          _buildIndexBadges(),
        ],
      ),
    );
  }

  Widget _buildQIDisplay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '118',
            style: GoogleFonts.dmMono(
              fontSize: 56,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Score de QI estimé',
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Supérieur à la moyenne',
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppColors.accent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndexBadges() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _indices.map((idx) => _IndexBadge(data: idx)).toList(),
    );
  }
}

class _IndexBadge extends StatelessWidget {
  final _IndexBadgeData data;

  const _IndexBadge({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: data.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: data.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '${data.code} ${data.score}',
            style: GoogleFonts.dmMono(
              fontSize: 12,
              color: data.color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '\u2014 ${data.label}',
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _IndexBadgeData {
  final String code;
  final int score;
  final String label;
  final Color color;

  const _IndexBadgeData({
    required this.code,
    required this.score,
    required this.label,
    required this.color,
  });
}
