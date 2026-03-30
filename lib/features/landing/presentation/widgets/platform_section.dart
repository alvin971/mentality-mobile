import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class PlatformSection extends StatefulWidget {
  const PlatformSection({super.key});

  @override
  State<PlatformSection> createState() => _PlatformSectionState();
}

class _PlatformSectionState extends State<PlatformSection> {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  int _currentPage = 0;

  static const List<_CardData> _cards = [
    _CardData(
      title: 'Évaluation cognitive',
      subtitle:
          '12 sous-tests WAIS-IV adaptatifs pour mesurer 5 indices composites de l\u2019intelligence.',
      icon: Icons.psychology,
    ),
    _CardData(
      title: 'Accompagnement IA',
      subtitle:
          'Un compagnon psychologique disponible 24/7, non-directif, confidentiel.',
      icon: Icons.chat_bubble_outline,
    ),
    _CardData(
      title: 'Supervision clinique',
      subtitle:
          'Valid\u00e9 par des psychiatres, psychologues et neuropsychologues.',
      icon: Icons.verified_outlined,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  'Une plateforme de psychologie complète',
                  style: AppTextStyles.serif(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _cards.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 20 : 8,
                    right: index == _cards.length - 1 ? 20 : 8,
                  ),
                  child: _PlatformCard(data: _cards[index]),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildPageDots(),
        ],
      ),
    );
  }

  Widget _buildPageDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_cards.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.accent : AppColors.border,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

class _PlatformCard extends StatelessWidget {
  final _CardData data;

  const _PlatformCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 1),
        borderRadius: BorderRadius.circular(2),
        color: AppColors.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(data.icon, color: AppColors.accent, size: 28),
          const SizedBox(height: 14),
          Text(
            data.title,
            style: GoogleFonts.sourceSerif4(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.subtitle,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardData {
  final String title;
  final String subtitle;
  final IconData icon;

  const _CardData({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
