import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  static const List<_TeamMember> _members = [
    _TeamMember(
      initials: 'DR',
      name: 'Dr. Martin',
      title: 'Psychiatre',
      quote:
          'Une évaluation cognitive rigoureuse est la base de toute prise en charge efficace.',
    ),
    _TeamMember(
      initials: 'PS',
      name: 'Dr. Bernard',
      title: 'Psychologue clinicienne',
      quote:
          'La validation clinique de chaque item garantit la fiabilité des résultats.',
    ),
    _TeamMember(
      initials: 'NP',
      name: 'Dr. Rousseau',
      title: 'Neuropsychologue',
      quote:
          'L\u2019approche adaptative respecte le rythme de chaque individu.',
    ),
    _TeamMember(
      initials: 'RC',
      name: 'Dr. Petit',
      title: 'Chercheur en psychométrie',
      quote:
          'La calibration IRT assure la précision des scores à tous les niveaux.',
    ),
  ];

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
                Text(
                  '§07',
                  style: AppTextStyles.mono(
                    fontSize: 11,
                    letterSpacing: 2,
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Supervisé cliniquement',
                  style: AppTextStyles.serif(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Chaque item est validé par des professionnels de santé mentale certifiés.',
                  style: GoogleFonts.dmSans(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _members.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < _members.length - 1 ? 12 : 0,
                  ),
                  child: _TeamCard(member: _members[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  final _TeamMember member;

  const _TeamCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 1),
        borderRadius: BorderRadius.circular(2),
        color: AppColors.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(2),
              ),
              alignment: Alignment.center,
              child: Text(
                member.initials,
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            member.name,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            member.title,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              '\u201c${member.quote}\u201d',
              style: GoogleFonts.sourceSerif4(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamMember {
  final String initials;
  final String name;
  final String title;
  final String quote;

  const _TeamMember({
    required this.initials,
    required this.name,
    required this.title,
    required this.quote,
  });
}
