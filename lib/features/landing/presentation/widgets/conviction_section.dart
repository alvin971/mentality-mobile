import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ConvictionSection extends StatelessWidget {
  const ConvictionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.footer,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPullQuote(),
          const SizedBox(height: 24),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildPullQuote() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: AppColors.accent,
            width: 3,
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        'En France, un bilan neuropsychologique coûte entre 500\u202f€ et 1\u202f500\u202f€. Ce chiffre exclut des millions de personnes de la connaissance de soi.',
        style: AppTextStyles.serif(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: const Color(0xFFB0C4B8),
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Text(
      'Mentality rend cette évaluation accessible à tous, gratuitement. Parce que comprendre son fonctionnement cognitif, ses émotions, ses forces et ses fragilités ne devrait pas nécessiter des centaines d\'euros.',
      style: AppTextStyles.sans(
        fontSize: 15,
        color: const Color(0xFF8BA898),
        height: 1.65,
      ),
    );
  }
}
