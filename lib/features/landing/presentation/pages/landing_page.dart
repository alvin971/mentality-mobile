import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/inscription_repository.dart';
import '../widgets/app_navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/conviction_section.dart';
import '../widgets/platform_section.dart';
import '../widgets/cognitive_profile_section.dart';
import '../widgets/tests_section.dart';
import '../widgets/ai_section.dart';
import '../widgets/roadmap_section.dart';
import '../widgets/team_section.dart';
import '../widgets/ethics_section.dart';
import '../widgets/app_footer.dart';
import '../widgets/registration_form.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  late final InscriptionRepository _repo;
  int _signupCount = 1200;

  @override
  void initState() {
    super.initState();
    _repo = InscriptionRepository(Supabase.instance.client);
    _fetchCount();
  }

  Future<void> _fetchCount() async {
    try {
      final count = await _repo.fetchSignupCount();
      if (mounted) setState(() => _signupCount = count);
    } catch (_) {}
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openRegistrationForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.92,
        child: RegistrationForm(
          onSuccess: (placeNumber, prenom) {
            Navigator.of(context).pop();
            context.go('/confirmation', extra: {
              'placeNumber': placeNumber,
              'prenom': prenom,
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // Pas de BottomAppBar — on utilise un Stack pour le FAB pleine largeur
      body: Stack(
        children: [
          // Contenu scrollable
          RefreshIndicator(
            onRefresh: _fetchCount,
            color: AppColors.accent,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Espace pour la navbar flottante
                const SliverToBoxAdapter(child: SizedBox(height: 72)),

                // Hero
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: HeroSection(
                      signupCount: _signupCount,
                      onReserver: _openRegistrationForm,
                    ),
                  ),
                ),

                // Stats — grille 2×2 native
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
                    child: const StatsSection(),
                  ),
                ),

                // Conviction
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
                    child: const ConvictionSection(),
                  ),
                ),

                // Plateforme — PageView carousel
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: PlatformSection(),
                  ),
                ),

                // Profil cognitif
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
                    child: const CognitiveProfileSection(),
                  ),
                ),

                // Tests WAIS-IV
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
                    child: const TestsSection(),
                  ),
                ),

                // IA
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
                    child: const AiSection(),
                  ),
                ),

                // Roadmap
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
                    child: const RoadmapSection(),
                  ),
                ),

                // Équipe
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: const TeamSection(),
                  ),
                ),

                // Charte éthique
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
                    child: const EthicsSection(),
                  ),
                ),

                // Footer minimal — pas de footer web
                const SliverToBoxAdapter(child: AppFooter()),
              ],
            ),
          ),

          // Navbar flottante en haut
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavbar(
              onReserver: _openRegistrationForm,
              scrollController: _scrollController,
            ),
          ),

          // CTA sticky en bas — pattern app mobile natif
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _StickyCtaBar(onReserver: _openRegistrationForm),
          ),
        ],
      ),
    );
  }
}

/// Barre CTA sticky — style app mobile (pas de FAB rond, pleine largeur).
class _StickyCtaBar extends StatelessWidget {
  final VoidCallback onReserver;

  const _StickyCtaBar({required this.onReserver});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: const Border(
          top: BorderSide(color: AppColors.border),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16, 12, 16, bottomPadding + 12),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onReserver,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.textPrimary,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            elevation: 0,
          ),
          child: Text(
            'Réserver mon accès gratuit',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
