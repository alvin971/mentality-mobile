import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';

class AppFooter extends StatefulWidget {
  const AppFooter({super.key});

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.footer,
      padding: EdgeInsets.fromLTRB(
        20,
        48,
        20,
        MediaQuery.of(context).padding.bottom + 48,
      ),
      child: Column(
        children: [
          RotationTransition(
            turns: _rotationController,
            child: const Icon(
              Icons.radio_button_unchecked,
              color: AppColors.accent,
              size: 28,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'mentality',
            style: GoogleFonts.sourceSerif4(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Évaluation cognitive · Gratuit · RGPD',
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: const Color(0xFF6B8070),
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
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
              color: const Color(0xFF4A5E52),
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
          color: AppColors.accent,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.accent.withValues(alpha: 0.4),
        ),
      ),
    );
  }

  Widget _dot() {
    return Text(
      ' · ',
      style: GoogleFonts.dmSans(
          fontSize: 12, color: const Color(0xFF4A5E52)),
    );
  }
}
