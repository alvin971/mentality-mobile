import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class CognitiveProfileSection extends StatelessWidget {
  const CognitiveProfileSection({super.key});

  static const int _iqScore = 118;

  static const List<_IndexData> _indices = [
    _IndexData(
      code: 'ICV',
      score: 112,
      percentile: 79,
      label: 'Compréhension Verbale',
      color: Color(0xFF4D7C4A),
    ),
    _IndexData(
      code: 'IRP',
      score: 108,
      percentile: 70,
      label: 'Raisonnement Perceptif',
      color: Color(0xFF5E7C6F),
    ),
    _IndexData(
      code: 'IMT',
      score: 115,
      percentile: 84,
      label: 'Mémoire de Travail',
      color: Color(0xFF3D7A5C),
    ),
    _IndexData(
      code: 'IVT',
      score: 104,
      percentile: 61,
      label: 'Vitesse de Traitement',
      color: Color(0xFF8A7C4A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Votre profil cognitif complet',
            style: AppTextStyles.serif(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Visualisez vos 4 indices WAIS-IV et votre score global.',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          _ScoreRuler(score: _iqScore, indices: _indices),
          const SizedBox(height: 20),
          _buildQIDisplay(),
          const SizedBox(height: 20),
          _buildPercentileRow(),
        ],
      ),
    );
  }

  Widget _buildQIDisplay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_iqScore',
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

  Widget _buildPercentileRow() {
    return Row(
      children: _indices.map((idx) {
        return Expanded(
          child: Column(
            children: [
              Text(
                '${idx.percentile}e',
                style: GoogleFonts.dmMono(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: idx.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                idx.code,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: AppColors.textTertiary,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ScoreRuler extends StatelessWidget {
  final int score;
  final List<_IndexData> indices;

  const _ScoreRuler({required this.score, required this.indices});

  @override
  Widget build(BuildContext context) {
    // Score range: 70–130
    final fraction = ((score - 70) / 60).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final markerLeft = (width * fraction) - 8;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Color bands
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Row(
                    children: indices
                        .map(
                          (idx) => Expanded(
                            child: Container(
                              height: 8,
                              color: idx.color.withValues(alpha: 0.5),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                // Marker dot
                Positioned(
                  left: markerLeft.clamp(0.0, width - 16),
                  top: -4,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.accent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '70',
                  style: GoogleFonts.dmMono(
                    fontSize: 10,
                    color: AppColors.textTertiary,
                  ),
                ),
                Text(
                  'Score: $score',
                  style: GoogleFonts.dmMono(
                    fontSize: 10,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '130',
                  style: GoogleFonts.dmMono(
                    fontSize: 10,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _IndexData {
  final String code;
  final int score;
  final int percentile;
  final String label;
  final Color color;

  const _IndexData({
    required this.code,
    required this.score,
    required this.percentile,
    required this.label,
    required this.color,
  });
}
