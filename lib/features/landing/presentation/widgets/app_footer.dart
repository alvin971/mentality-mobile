import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';

/// Footer natif mobile — discret, centré, sans colonnes de liens.
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.fromLTRB(
        20,
        32,
        20,
        MediaQuery.of(context).padding.bottom + 96,
      ),
      child: Column(
        children: [
          Container(height: 1, color: AppColors.border),
          const SizedBox(height: 28),
          Text(
            'mentality',
            style: GoogleFonts.sourceSerif4(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Évaluation cognitive · Gratuit · RGPD',
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppColors.textTertiary,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            children: [
              _legalLink('Confidentialité'),
              _dot(),
              _legalLink('CGU'),
              _dot(),
              _legalLink('Contact'),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '© 2026 Mentality',
            style: GoogleFonts.dmMono(
              fontSize: 11,
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _legalLink(String label) {
    return GestureDetector(
      onTap: () => HapticFeedback.selectionClick(),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 12,
          color: AppColors.textTertiary,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.border,
        ),
      ),
    );
  }

  Widget _dot() {
    return Text(
      ' · ',
      style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.border),
    );
  }
}
