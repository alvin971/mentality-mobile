import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class RoadmapSection extends StatelessWidget {
  const RoadmapSection({super.key});

  static const List<_RoadmapItem> _items = [
    _RoadmapItem(
      title: 'Évaluation cognitive QI',
      description: '12 sous-tests WAIS-IV adaptatifs',
      badge: 'Disponible',
      isAvailable: true,
    ),
    _RoadmapItem(
      title: 'Intelligence émotionnelle',
      description: 'Mesure de la conscience et régulation émotionnelle',
      badge: 'Bientôt',
      isAvailable: false,
    ),
    _RoadmapItem(
      title: 'Évaluation TDAH',
      description: 'Screening cliniquement validé des critères TDAH',
      badge: 'Bientôt',
      isAvailable: false,
    ),
    _RoadmapItem(
      title: 'Spectre autistique',
      description: 'Outils d\u2019auto-évaluation ASD validés',
      badge: 'Bientôt',
      isAvailable: false,
    ),
    _RoadmapItem(
      title: 'Suivi santé mentale',
      description: 'Tableau de bord longitudinal de votre bien-être',
      badge: 'Bientôt',
      isAvailable: false,
    ),
    _RoadmapItem(
      title: 'IA conversationnelle',
      description: 'Compagnon psychologique disponible 24/7',
      badge: 'Bientôt',
      isAvailable: false,
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
            '§06',
            style: AppTextStyles.mono(
              fontSize: 11,
              letterSpacing: 2,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Ce qui arrive',
            style: AppTextStyles.serif(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 28),
          ..._items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == _items.length - 1;
            return _TimelineRow(
              item: item,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final _RoadmapItem item;
  final bool isLast;

  const _TimelineRow({required this.item, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TimelineIndicator(isAvailable: item.isAvailable, isLast: isLast),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _Badge(
                        label: item.badge,
                        isAvailable: item.isAvailable,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineIndicator extends StatelessWidget {
  final bool isAvailable;
  final bool isLast;

  const _TimelineIndicator({required this.isAvailable, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      child: Column(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isAvailable ? AppColors.accent : AppColors.textTertiary,
              shape: BoxShape.circle,
            ),
          ),
          if (!isLast)
            Expanded(
              child: Center(
                child: Container(
                  width: 1,
                  color: AppColors.border,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final bool isAvailable;

  const _Badge({required this.label, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isAvailable
            ? AppColors.accent.withValues(alpha: 0.12)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(100),
        border: isAvailable
            ? null
            : Border.all(color: AppColors.border, width: 1),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isAvailable ? AppColors.accent : AppColors.textTertiary,
        ),
      ),
    );
  }
}

class _RoadmapItem {
  final String title;
  final String description;
  final String badge;
  final bool isAvailable;

  const _RoadmapItem({
    required this.title,
    required this.description,
    required this.badge,
    required this.isAvailable,
  });
}
