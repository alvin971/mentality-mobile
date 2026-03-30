import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  static const List<_LinkGroup> _linkGroups = [
    _LinkGroup(
      heading: 'Plateforme',
      links: ['Accueil', 'Les tests', 'Accompagnement', 'Résultats'],
    ),
    _LinkGroup(
      heading: 'Légal',
      links: [
        'Politique de confidentialité',
        'CGU',
        'Mentions légales',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.footer,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLogoRow(),
          const SizedBox(height: 8),
          _buildTagline(),
          const SizedBox(height: 28),
          _buildDivider(),
          const SizedBox(height: 28),
          _buildLinks(),
          const SizedBox(height: 28),
          _buildDivider(),
          const SizedBox(height: 20),
          _buildCopyright(),
        ],
      ),
    );
  }

  Widget _buildLogoRow() {
    return Text(
      'mentality',
      style: GoogleFonts.sourceSerif4(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTagline() {
    return Text(
      'La première plateforme de psychologie complète et gratuite',
      style: GoogleFonts.dmSans(
        fontSize: 13,
        color: const Color(0xFF7A9488),
        height: 1.5,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.1),
      thickness: 1,
      height: 1,
    );
  }

  Widget _buildLinks() {
    return Wrap(
      spacing: 32,
      runSpacing: 24,
      children: _linkGroups.map((group) => _LinkGroupWidget(group: group)).toList(),
    );
  }

  Widget _buildCopyright() {
    return Center(
      child: Text(
        '\u00a9 2026 Mentality \u2014 Tous droits réservés',
        textAlign: TextAlign.center,
        style: GoogleFonts.dmSans(
          fontSize: 12,
          color: const Color(0xFF3D5248),
        ),
      ),
    );
  }
}

class _LinkGroupWidget extends StatelessWidget {
  final _LinkGroup group;

  const _LinkGroupWidget({required this.group});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.heading,
          style: GoogleFonts.dmSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.4),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        ...group.links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: Colors.white.withValues(alpha: 0.6),
                textStyle: GoogleFonts.dmSans(fontSize: 13),
              ),
              child: Text(link),
            ),
          ),
        ),
      ],
    );
  }
}

class _LinkGroup {
  final String heading;
  final List<String> links;

  const _LinkGroup({required this.heading, required this.links});
}
