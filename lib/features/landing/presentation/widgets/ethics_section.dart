import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class EthicsSection extends StatefulWidget {
  const EthicsSection({super.key});

  @override
  State<EthicsSection> createState() => _EthicsSectionState();
}

class _EthicsSectionState extends State<EthicsSection> {
  int? _expandedIndex;

  static const List<_EthicsItem> _items = [
    _EthicsItem(
      icon: Icons.volunteer_activism,
      title: 'Gratuit pour toujours',
      description:
          'Jamais de paywall sur le bilan cognitif. L\'accès aux tests et aux résultats restera toujours gratuit.',
    ),
    _EthicsItem(
      icon: Icons.info_outline,
      title: 'Non-diagnostic',
      description:
          'Nos résultats sont informatifs, jamais diagnostiques. Seul un professionnel de santé peut poser un diagnostic.',
    ),
    _EthicsItem(
      icon: Icons.lock_outline,
      title: 'Données protégées',
      description:
          'Anonymisation RGPD stricte. Vos données ne sont jamais revendues, ni partagées avec des tiers.',
    ),
    _EthicsItem(
      icon: Icons.people_outline,
      title: 'Accessible à tous',
      description:
          'Disponible en 10 langues, sur mobile et desktop, sans barrière technique ni financière.',
    ),
    _EthicsItem(
      icon: Icons.favorite_border,
      title: 'Orienté vers le soin',
      description:
          'En cas de résultats préoccupants, nous orientons vers des professionnels de santé qualifiés.',
    ),
    _EthicsItem(
      icon: Icons.science_outlined,
      title: 'Fondé sur la science',
      description:
          'Chaque item est validé cliniquement selon les standards de la psychologie cognitive internationale.',
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
            'Notre charte éthique',
            style: AppTextStyles.serif(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Les principes qui guident chacune de nos décisions.',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          ...List.generate(_items.length, (i) {
            final item = _items[i];
            final isExpanded = _expandedIndex == i;
            final isLast = i == _items.length - 1;
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _expandedIndex = isExpanded ? null : i;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(item.icon, size: 22, color: AppColors.accent),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.title,
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 20,
                              color: AppColors.textTertiary,
                            ),
                          ],
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeInOut,
                          child: isExpanded
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    left: 34,
                                  ),
                                  child: Text(
                                    item.description,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                      height: 1.55,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.border,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _EthicsItem {
  final IconData icon;
  final String title;
  final String description;

  const _EthicsItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
