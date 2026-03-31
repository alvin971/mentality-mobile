import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/inscription_repository.dart';
import '../widgets/app_navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/conviction_section.dart';
import '../widgets/platform_section.dart';
import '../widgets/cognitive_profile_section.dart';
import '../widgets/tests_section.dart';
import '../widgets/ai_section.dart';
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
  final GlobalKey _formKey = GlobalKey();
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

  void _scrollToForm() {
    final ctx = _formKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _fetchCount,
            color: AppColors.accent,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Espace pour la navbar flottante
                const SliverToBoxAdapter(child: SizedBox(height: 72)),

                // Hero — stats 2x2 inline + CTA vert
                SliverToBoxAdapter(
                  child: HeroSection(
                    signupCount: _signupCount,
                    onReserver: _scrollToForm,
                  ),
                ),

                // Problem — fond sombre
                const SliverToBoxAdapter(child: ConvictionSection()),

                // Pillars — 3 cartes verticales
                const SliverToBoxAdapter(child: PlatformSection()),

                // Profil cognitif + règle de score
                const SliverToBoxAdapter(child: CognitiveProfileSection()),

                // Tests WAIS-IV avec onglets
                const SliverToBoxAdapter(child: TestsSection()),

                // Chat IA — fond sombre
                const SliverToBoxAdapter(child: AiSection()),

                // Formulaire inline
                SliverToBoxAdapter(
                  child: RegistrationForm(
                    key: _formKey,
                    onSuccess: (placeNumber, prenom) {
                      context.go('/confirmation', extra: {
                        'placeNumber': placeNumber,
                        'prenom': prenom,
                      });
                    },
                  ),
                ),

                // Charte éthique — accordéon
                const SliverToBoxAdapter(child: EthicsSection()),

                // Footer — fond sombre + logo animé
                const SliverToBoxAdapter(child: AppFooter()),
              ],
            ),
          ),

          // Navbar flottante
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavbar(
              onReserver: _scrollToForm,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
