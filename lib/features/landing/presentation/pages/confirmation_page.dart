import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

class ConfirmationPage extends StatelessWidget {
  final int? placeNumber;
  final String prenom;

  const ConfirmationPage({
    super.key,
    this.placeNumber,
    required this.prenom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Success icon
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.accentDim,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Icon(
                  Icons.check,
                  size: 36,
                  color: AppColors.accent,
                ),
              )
                  .animate()
                  .scale(duration: 400.ms, curve: Curves.easeOut)
                  .fadeIn(duration: 300.ms),

              const SizedBox(height: 24),

              Text(
                prenom.isNotEmpty ? 'Bienvenue, $prenom !' : 'Inscription confirmée !',
                style: GoogleFonts.sourceSerif4(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.05),

              const SizedBox(height: 12),

              Text(
                'Votre place dans l\'accès anticipé Mentality est réservée.',
                style: GoogleFonts.dmSans(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              )
                  .animate(delay: 300.ms)
                  .fadeIn(duration: 400.ms),

              if (placeNumber != null) ...[
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Votre numéro de place',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '#${placeNumber.toString().padLeft(4, '0')}',
                        style: GoogleFonts.dmMono(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                )
                    .animate(delay: 400.ms)
                    .fadeIn(duration: 400.ms)
                    .scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOut),
              ],

              const SizedBox(height: 40),

              // What's next
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prochaines étapes',
                      style: GoogleFonts.sourceSerif4(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildStep(
                      '1',
                      'Accès en cours de déploiement',
                      'Nous vous préviendrons par email dès que la plateforme est disponible.',
                    ),
                    const SizedBox(height: 12),
                    _buildStep(
                      '2',
                      'Évaluation cognitive',
                      '12 sous-tests WAIS-IV adaptatifs, résultats instantanés.',
                    ),
                    const SizedBox(height: 12),
                    _buildStep(
                      '3',
                      'Votre profil cognitif',
                      'Score QI estimé + 4 indices composites + accompagnement IA.',
                    ),
                  ],
                ),
              )
                  .animate(delay: 500.ms)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 32),

              // Share button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    // Share link
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Lien copié : https://mentalite-site-web.pages.dev',
                          style: GoogleFonts.dmSans(fontSize: 13),
                        ),
                        backgroundColor: AppColors.textPrimary,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.share_outlined, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Partager avec mes proches',
                        style: GoogleFonts.dmSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .animate(delay: 600.ms)
                  .fadeIn(duration: 300.ms),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () => context.go('/'),
                child: Text(
                  '← Retour à l\'accueil',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(String number, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.accentDim,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.dmMono(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.accent,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: AppColors.textTertiary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
