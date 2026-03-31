import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class HeroSection extends StatelessWidget {
  final int signupCount;
  final VoidCallback onReserver;

  const HeroSection({
    super.key,
    required this.signupCount,
    required this.onReserver,
  });

  static const List<_StatData> _stats = [
    _StatData(value: '12', label: 'sous-tests\nWAIS-IV'),
    _StatData(value: '98%', label: 'taux de\ncomplétion'),
    _StatData(value: '5', label: 'indices\ncognitifs'),
    _StatData(value: '0\u202f€', label: 'pour\ntoujours'),
  ];

  @override
  Widget build(BuildContext context) {
    const totalPlaces = 10000;
    final progress = (signupCount / totalPlaces).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEyebrowBadge(),
          const SizedBox(height: 20),
          _buildTitle(),
          const SizedBox(height: 16),
          _buildSubtitle(),
          const SizedBox(height: 28),
          _buildStatsGrid(),
          const SizedBox(height: 28),
          _buildCTAButton(),
          const SizedBox(height: 20),
          _buildCounter(signupCount, totalPlaces, progress),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.04, duration: 400.ms, curve: Curves.easeOut);
  }

  Widget _buildEyebrowBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.accentDim,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        'Accès anticipé gratuit',
        style: GoogleFonts.dmSans(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.accent,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.serif(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        children: const [
          TextSpan(text: 'Votre santé mentale mérite une attention '),
          TextSpan(
            text: 'sérieuse',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'La première plateforme de psychologie complète et gratuite. Tests cognitifs WAIS-IV rigoureux, accompagnement IA et supervision clinique.',
      style: AppTextStyles.sans(
        fontSize: 15,
        color: AppColors.textSecondary,
        height: 1.65,
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 2.4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: _stats.map((s) => _StatCard(data: s)).toList(),
    );
  }

  Widget _buildCTAButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onReserver,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: Text(
          'Réserver mon accès gratuit →',
          style: GoogleFonts.dmSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildCounter(int count, int total, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: _formatNumber(count),
                style: GoogleFonts.dmMono(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              TextSpan(
                text: ' / 10\u202f000 ',
                style: GoogleFonts.dmMono(
                  fontSize: 14,
                  color: AppColors.textTertiary,
                ),
              ),
              TextSpan(
                text: 'places réservées',
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: AppColors.surface,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
          ),
        ),
      ],
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) {
      return '${n ~/ 1000}\u202f${(n % 1000).toString().padLeft(3, '0')}';
    }
    return n.toString();
  }
}

class _StatCard extends StatelessWidget {
  final _StatData data;

  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data.value,
            style: GoogleFonts.dmMono(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              data.label,
              style: GoogleFonts.dmSans(
                fontSize: 11,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
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
