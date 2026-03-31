import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AiSection extends StatelessWidget {
  const AiSection({super.key});

  static const List<_FeatureData> _features = [
    _FeatureData(
      title: 'Écoute active non-directive',
      description:
          'Une présence bienveillante qui vous accompagne sans jugement ni prescription.',
    ),
    _FeatureData(
      title: 'Confidentialité absolue',
      description:
          'Vos échanges sont chiffrés et jamais utilisés pour l\'entraînement de modèles.',
    ),
    _FeatureData(
      title: 'Orientation professionnelle',
      description:
          'Si nécessaire, l\'IA vous oriente vers des professionnels de santé adaptés.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.footer,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Un compagnon psychologique IA',
            style: AppTextStyles.serif(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: -0.3,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          ..._features.map((f) => _FeatureItem(data: f)),
          const SizedBox(height: 28),
          _buildChatMockup(context),
        ],
      ),
    );
  }

  Widget _buildChatMockup(BuildContext context) {
    return Column(
      children: [
        _AiMessage(
          text: 'Comment vous sentez-vous aujourd\'hui\u00a0?',
        ),
        const SizedBox(height: 8),
        _UserMessage(
          text: 'J\'ai du mal à me concentrer depuis quelques semaines.',
        ),
        const SizedBox(height: 8),
        _AiMessage(
          text:
              'Je comprends. Pouvez-vous me décrire ces difficultés plus précisément\u00a0?',
        ),
        const SizedBox(height: 12),
        const Align(
          alignment: Alignment.centerLeft,
          child: _TypingIndicator(),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(Icons.check, size: 14, color: AppColors.accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  data.description,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: const Color(0xFF8BA898),
                    height: 1.55,
                  ),
                ),
              ],
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
        decoration: BoxDecoration(
          color: const Color(0xFF1A2E24),
          border: Border.all(
            color: AppColors.accent.withValues(alpha: 0.12),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            color: const Color(0xFFB0C4B8),
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
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.35),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.zero,
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            color: Colors.white,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2E24),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.12),
          width: 1,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.zero,
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          return Padding(
            padding: EdgeInsets.only(right: i < 2 ? 4 : 0),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFF6B9E7A),
                shape: BoxShape.circle,
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .moveY(
                  begin: 0,
                  end: -4,
                  duration: 500.ms,
                  delay: Duration(milliseconds: i * 150),
                  curve: Curves.easeInOut,
                ),
          );
        }),
      ),
    );
  }
}

class _FeatureData {
  final String title;
  final String description;

  const _FeatureData({required this.title, required this.description});
}
