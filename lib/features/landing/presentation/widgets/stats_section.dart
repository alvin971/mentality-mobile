import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  static const List<_StatData> _stats = [
    _StatData(value: '12', label: 'sous-tests WAIS-IV'),
    _StatData(value: '100%', label: 'gratuit pour toujours'),
    _StatData(value: '4', label: 'indices composites'),
    _StatData(value: '24/7', label: 'accompagnement IA'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: _stats.map((stat) => _StatCard(stat: stat)).toList(),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final _StatData stat;

  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            stat.value,
            style: AppTextStyles.serif(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.label,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatData {
  final String value;
  final String label;

  const _StatData({required this.value, required this.label});
}
