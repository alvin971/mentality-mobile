import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class PlatformSection extends StatelessWidget {
  const PlatformSection({super.key});

  static const List<_PillarData> _pillars = [
    _PillarData(
      number: '01',
      title: 'Évaluation cognitive',
      subtitle:
          '12 sous-tests WAIS-IV adaptatifs pour mesurer 5 indices composites de l\'intelligence.',
      icon: Icons.psychology,
      color: Color(0xFF4D7C4A),
    ),
    _PillarData(
      number: '02',
      title: 'Accompagnement IA',
      subtitle:
          'Un compagnon psychologique disponible 24/7, non-directif, confidentiel.',
      icon: Icons.chat_bubble_outline,
      color: Color(0xFF3D7A5C),
    ),
    _PillarData(
      number: '03',
      title: 'Supervision clinique',
      subtitle:
          'Validé par des psychiatres, psychologues et neuropsychologues.',
      icon: Icons.verified_outlined,
      color: Color(0xFF5E7C6F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Une plateforme de psychologie complète',
            style: AppTextStyles.serif(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Trois piliers conçus pour votre santé mentale.',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          ...List.generate(_pillars.length, (i) {
            final pillar = _pillars[i];
            return Padding(
              padding: EdgeInsets.only(bottom: i < _pillars.length - 1 ? 12 : 0),
              child: _PillarCard(data: pillar),
            );
          }),
        ],
      ),
    );
  }
}

class _PillarCard extends StatelessWidget {
  final _PillarData data;

  const _PillarCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: data.color.withValues(alpha: 0.08),
        border: Border.all(
          color: data.color.withValues(alpha: 0.25),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(data.icon, color: data.color, size: 26),
              const Spacer(),
              Text(
                data.number,
                style: GoogleFonts.dmMono(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textTertiary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            data.title,
            style: GoogleFonts.sourceSerif4(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.subtitle,
            style: GoogleFonts.dmSans(
              fontSize: 13.5,
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _PillarData {
  final String number;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _PillarData({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}
