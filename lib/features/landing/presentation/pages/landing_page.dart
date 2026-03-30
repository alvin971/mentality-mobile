import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/inscription_repository.dart';
import '../widgets/app_navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/urgency_bar.dart';
import '../widgets/stats_section.dart';
import '../widgets/conviction_section.dart';
import '../widgets/platform_section.dart';
import '../widgets/cognitive_profile_section.dart';
import '../widgets/tests_section.dart';
import '../widgets/ai_section.dart';
import '../widgets/roadmap_section.dart';
import '../widgets/team_section.dart';
import '../widgets/ethics_section.dart';
import '../widgets/cta_section.dart';
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
    } catch (_) {
      // fallback to default
    }
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
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _fetchCount,
            color: AppColors.accent,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Spacer for navbar
                const SliverToBoxAdapter(child: SizedBox(height: 64)),

                // Hero
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                    child: HeroSection(
                      signupCount: _signupCount,
                      onReserver: _openRegistrationForm,
                    ),
                  ),
                ),

                // Urgency bar
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: UrgencyBar(),
                  ),
                ),

                // Stats
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
                    child: const StatsSection(),
                  ),
                ),

                // §01 Conviction
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
                    child: const ConvictionSection(),
                  ),
                ),

                // §02 Platform
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 56),
                    child: PlatformSection(),
                  ),
                ),

                // §03 Cognitive Profile
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
                    child: const CognitiveProfileSection(),
                  ),
                ),

                // §04 Tests
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
                    child: const TestsSection(),
                  ),
                ),

                // §05 AI
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
                    child: const AiSection(),
                  ),
                ),

                // §06 Roadmap
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
                    child: const RoadmapSection(),
                  ),
                ),

                // §07 Team
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 56),
                    child: const TeamSection(),
                  ),
                ),

                // §08 Ethics
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
                    child: const EthicsSection(),
                  ),
                ),

                // CTA final
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
                    child: CtaSection(onReserver: _openRegistrationForm),
                  ),
                ),

                // Footer
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 56),
                    child: AppFooter(),
                  ),
                ),

                // Bottom spacing for FAB
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ),

          // Floating Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavbar(
              onReserver: _openRegistrationForm,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),

      // Sticky bottom CTA
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _openRegistrationForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              elevation: 4,
              shadowColor: AppColors.accent.withValues(alpha: 0.3),
            ),
            child: const Text(
              'Réserver mon accès gratuit →',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
