import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class TestsSection extends StatefulWidget {
  const TestsSection({super.key});

  @override
  State<TestsSection> createState() => _TestsSectionState();
}

class _TestsSectionState extends State<TestsSection> {
  static const Color _verbal = Color(0xFF4D7C4A);
  static const Color _visuel = Color(0xFF5E7C6F);
  static const Color _memoire = Color(0xFF3D7A5C);
  static const Color _vitesse = Color(0xFF8A7C4A);

  static const List<_TabData> _tabs = [
    _TabData(label: 'Vitesse', color: _vitesse),
    _TabData(label: 'Mémoire', color: _memoire),
    _TabData(label: 'Raisonnement', color: _visuel),
    _TabData(label: 'Langage', color: _verbal),
  ];

  static const List<_TestData> _tests = [
    _TestData(
      name: 'Code',
      tab: 'Vitesse',
      color: _vitesse,
      description: 'Associer des symboles à des chiffres le plus rapidement possible. Mesure la vitesse de traitement et l\'attention.',
    ),
    _TestData(
      name: 'Recherche de symboles',
      tab: 'Vitesse',
      color: _vitesse,
      description: 'Identifier si un symbole cible est présent dans une série. Évalue la rapidité perceptuelle et l\'attention visuelle.',
    ),
    _TestData(
      name: 'Mémoire d\'images',
      tab: 'Vitesse',
      color: _vitesse,
      description: 'Mémoriser et reconnaître des images présentées brièvement. Teste la mémoire de travail visuelle.',
    ),
    _TestData(
      name: 'Empan de chiffres',
      tab: 'Mémoire',
      color: _memoire,
      description: 'Répéter des séquences de chiffres dans l\'ordre direct et inverse. Mesure la mémoire de travail auditive.',
    ),
    _TestData(
      name: 'Arithmétique',
      tab: 'Mémoire',
      color: _memoire,
      description: 'Résoudre des problèmes mathématiques mentalement. Évalue la concentration et la mémoire de travail numérique.',
    ),
    _TestData(
      name: 'Balances',
      tab: 'Mémoire',
      color: _memoire,
      description: 'Équilibrer des balances avec des poids différents. Mesure le raisonnement quantitatif et la mémoire de travail.',
    ),
    _TestData(
      name: 'Cubes',
      tab: 'Raisonnement',
      color: _visuel,
      description: 'Reproduire des motifs en 2D avec des cubes colorés. Évalue le raisonnement visuospatial et la coordination.',
    ),
    _TestData(
      name: 'Matrices',
      tab: 'Raisonnement',
      color: _visuel,
      description: 'Compléter des matrices visuelles abstraites. Mesure le raisonnement fluide et inductif.',
    ),
    _TestData(
      name: 'Puzzles visuels',
      tab: 'Raisonnement',
      color: _visuel,
      description: 'Reconstituer un puzzle à partir de pièces données. Teste l\'analyse perceptuelle et la synthèse visuelle.',
    ),
    _TestData(
      name: 'Similitudes',
      tab: 'Langage',
      color: _verbal,
      description: 'Trouver ce que deux concepts ont en commun. Évalue le raisonnement verbal et la pensée abstraite.',
    ),
    _TestData(
      name: 'Vocabulaire',
      tab: 'Langage',
      color: _verbal,
      description: 'Définir des mots de difficulté croissante. Mesure les connaissances lexicales et l\'expression verbale.',
    ),
    _TestData(
      name: 'Information',
      tab: 'Langage',
      color: _verbal,
      description: 'Répondre à des questions de culture générale. Évalue les connaissances générales acquises.',
    ),
  ];

  int _activeTab = 0;
  int? _expandedIndex;

  List<_TestData> get _filteredTests =>
      _tests.where((t) => t.tab == _tabs[_activeTab].label).toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '12 sous-tests WAIS-IV',
            style: AppTextStyles.serif(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explorez chaque dimension cognitive évaluée.',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          // Tabs
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final tab = _tabs[i];
                final isActive = _activeTab == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _activeTab = i;
                      _expandedIndex = null;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                )
                              ]
                            : null,
                      ),
                      child: Text(
                        tab.label,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 11.5,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                          color: isActive ? tab.color : AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          // Test list
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Column(
              key: ValueKey(_activeTab),
              children: List.generate(_filteredTests.length, (i) {
                final test = _filteredTests[i];
                final isExpanded = _expandedIndex == i;
                final isLast = i == _filteredTests.length - 1;
                return Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _expandedIndex = isExpanded ? null : i;
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isExpanded
                              ? test.color.withValues(alpha: 0.4)
                              : AppColors.border,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  test.name,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 18,
                                color: AppColors.textTertiary,
                              ),
                            ],
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            child: isExpanded
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: test.color.withValues(alpha: 0.2),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          test.description,
                                          style: GoogleFonts.dmSans(
                                            fontSize: 13,
                                            color: AppColors.textSecondary,
                                            height: 1.55,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabData {
  final String label;
  final Color color;

  const _TabData({required this.label, required this.color});
}

class _TestData {
  final String name;
  final String tab;
  final Color color;
  final String description;

  const _TestData({
    required this.name,
    required this.tab,
    required this.color,
    required this.description,
  });
}
