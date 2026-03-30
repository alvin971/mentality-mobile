import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'urgency_bar.dart';

class HeroSection extends StatelessWidget {
  final int signupCount;
  final VoidCallback onReserver;

  const HeroSection({
    super.key,
    required this.signupCount,
    required this.onReserver,
  });

  @override
  Widget build(BuildContext context) {
    const totalPlaces = 10000;
    final progress = (signupCount / totalPlaces).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge accès anticipé + urgency
        Row(
          children: [
            _buildEyebrowBadge(),
            const SizedBox(width: 10),
            const UrgencyBadge(),
          ],
        ),
        const SizedBox(height: 20),
        _buildTitle(),
        const SizedBox(height: 16),
        _buildSubtitle(),
        const SizedBox(height: 28),
        _buildCounter(signupCount, totalPlaces, progress),
        // Pas de bouton ici — le FAB sticky en bas s'en charge
      ],
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
    return Text(
      'Votre santé mentale mérite une attention sérieuse',
      style: AppTextStyles.serif(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.5,
        height: 1.2,
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
                text: ' / 10 000 ',
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
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: AppColors.surface,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
          ),
        ),
      ],
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) {
      return '${n ~/ 1000} ${(n % 1000).toString().padLeft(3, '0')}';
    }
    return n.toString();
  }
}
