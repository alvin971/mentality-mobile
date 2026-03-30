import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';

/// Navbar style app mobile — logo seul, pas de bouton "Réserver" en haut.
/// Le CTA est dans le FAB sticky en bas (pattern iOS/Android natif).
class AppNavbar extends StatefulWidget {
  final VoidCallback onReserver;
  final ScrollController scrollController;

  const AppNavbar({
    super.key,
    required this.onReserver,
    required this.scrollController,
  });

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 10;
    if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: _isScrolled
            ? ImageFilter.blur(sigmaX: 16, sigmaY: 16)
            : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: _isScrolled
              ? const Color(0xE0FAF9F6) // fond quasi-opaque au scroll
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                // Logo animé — centré visuellement
                RotationTransition(
                  turns: _rotationController,
                  child: const Icon(
                    Icons.radio_button_unchecked,
                    color: AppColors.accent,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'mentality',
                  style: GoogleFonts.sourceSerif4(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                // Pas de bouton à droite — le FAB en bas gère le CTA
              ],
            ),
          ),
        ),
      ),
    );
  }
}
