import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AiSection extends StatelessWidget {
  const AiSection({super.key});

  static const List<_FeatureData> _features = [
    _FeatureData(
      title: '\u2014 Écoute active non-directive',
      description:
          'Une présence bienveillante qui vous accompagne sans jugement ni prescription.',
    ),
    _FeatureData(
      title: '\u2014 Confidentialité absolue',
      description:
          'Vos échanges sont chiffrés et jamais utilisés pour l\u2019entraînement de modèles.',
    ),
    _FeatureData(
      title: '\u2014 Orientation professionnelle',
      description:
          'Si nécessaire, l\u2019IA vous oriente vers des professionnels de santé adaptés.',
    ),
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
            'Un compagnon psychologique IA',
            style: AppTextStyles.serif(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 28),
          ..._features.map((f) => _FeatureItem(data: f)),
          const SizedBox(height: 28),
          _buildChatMockup(),
        ],
      ),
    );
  }

  Widget _buildChatMockup() {
    return Column(
      children: [
        _AiMessage(
          text: 'Comment vous sentez-vous aujourd\u2019hui\u00a0?',
        ),
        const SizedBox(height: 8),
        _UserMessage(
          text: 'J\u2019ai du mal à me concentrer depuis quelques semaines.',
        ),
        const SizedBox(height: 8),
        _AiMessage(
          text:
              'Je comprends. Pouvez-vous me décrire ces difficultés plus précisément\u00a0?',
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final _FeatureData data;

  const _FeatureItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            style: GoogleFonts.dmSans(
              fontSize: 15,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.description,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _AiMessage extends StatelessWidget {
  final String text;

  const _AiMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.circular(2),
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(2),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _UserMessage extends StatelessWidget {
  final String text;

  const _UserMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: const BoxDecoration(
          color: AppColors.accentDim,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.zero,
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(2),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            color: AppColors.textPrimary,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _FeatureData {
  final String title;
  final String description;

  const _FeatureData({required this.title, required this.description});
}
