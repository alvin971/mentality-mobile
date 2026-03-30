import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class EthicsSection extends StatelessWidget {
  const EthicsSection({super.key});

  static const List<_EthicsCard> _cards = [
    _EthicsCard(
      icon: Icons.volunteer_activism,
      title: 'Gratuit pour toujours',
      description: 'Jamais de paywall sur le bilan cognitif',
    ),
    _EthicsCard(
      icon: Icons.info_outline,
      title: 'Non-diagnostic',
      description: 'Résultats informatifs, jamais diagnostiques',
    ),
    _EthicsCard(
      icon: Icons.lock_outline,
      title: 'Données protégées',
      description: 'Anonymisation RGPD, aucune revente',
    ),
    _EthicsCard(
      icon: Icons.people_outline,
      title: 'Accessible à tous',
      description: '10 langues, mobile & desktop',
    ),
    _EthicsCard(
      icon: Icons.favorite_border,
      title: 'Orienté vers le soin',
      description: 'Orientation vers des professionnels si nécessaire',
    ),
    _EthicsCard(
      icon: Icons.science_outlined,
      title: 'Fondé sur la science',
      description: 'Chaque item validé cliniquement',
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
            '§08',
            style: AppTextStyles.mono(
              fontSize: 11,
              letterSpacing: 2,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Notre charte éthique',
            style: AppTextStyles.serif(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: _cards.map((card) => _EthicsCardWidget(card: card)).toList(),
          ),
        ],
      ),
    );
  }
}

class _EthicsCardWidget extends StatelessWidget {
  final _EthicsCard card;

  const _EthicsCardWidget({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(card.icon, size: 24, color: AppColors.accent),
          const SizedBox(height: 12),
          Text(
            card.title,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            card.description,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _EthicsCard {
  final IconData icon;
  final String title;
  final String description;

  const _EthicsCard({
    required this.icon,
    required this.title,
    required this.description,
  });
}
