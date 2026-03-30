import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class TestsSection extends StatelessWidget {
  const TestsSection({super.key});

  static const Color _verbal = Color(0xFF4D7C4A);
  static const Color _visuel = Color(0xFF5E7C6F);
  static const Color _memoire = Color(0xFF3D7A5C);
  static const Color _vitesse = Color(0xFF8A7C4A);

  static const List<_TestData> _tests = [
    _TestData(name: 'Similitudes', tag: 'Verbal', color: _verbal),
    _TestData(name: 'Vocabulaire', tag: 'Verbal', color: _verbal),
    _TestData(name: 'Information', tag: 'Verbal', color: _verbal),
    _TestData(name: 'Cubes', tag: 'Visuel', color: _visuel),
    _TestData(name: 'Matrices', tag: 'Visuel', color: _visuel),
    _TestData(name: 'Puzzles visuels', tag: 'Visuel', color: _visuel),
    _TestData(name: 'Empan de chiffres', tag: 'Mémoire', color: _memoire),
    _TestData(name: 'Arithmétique', tag: 'Mémoire', color: _memoire),
    _TestData(name: 'Balances', tag: 'Mémoire', color: _memoire),
    _TestData(name: 'Code', tag: 'Vitesse', color: _vitesse),
    _TestData(name: 'Recherche de symboles', tag: 'Vitesse', color: _vitesse),
    _TestData(name: 'Mémoire d\u2019images', tag: 'Vitesse', color: _vitesse),
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
            '12 sous-tests WAIS-IV',
            style: AppTextStyles.serif(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 24),
          ..._tests.asMap().entries.map((entry) {
            final test = entry.value;
            final isLast = entry.key == _tests.length - 1;
            return _TestRow(data: test, isLast: isLast);
          }),
        ],
      ),
    );
  }
}

class _TestRow extends StatelessWidget {
  final _TestData data;
  final bool isLast;

  const _TestRow({required this.data, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 13),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          Text(
            data.name,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          _TestTag(tag: data.tag, color: data.color),
        ],
      ),
    );
  }
}

class _TestTag extends StatelessWidget {
  final String tag;
  final Color color;

  const _TestTag({required this.tag, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        tag,
        style: GoogleFonts.dmMono(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class _TestData {
  final String name;
  final String tag;
  final Color color;

  const _TestData({required this.name, required this.tag, required this.color});
}
