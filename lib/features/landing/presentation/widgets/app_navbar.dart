import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';

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
  bool _isMenuOpen = false;

  static const List<_NavLink> _links = [
    _NavLink(label: 'Les tests', anchor: 'tests'),
    _NavLink(label: 'Accompagnement', anchor: 'accompagnement'),
    _NavLink(label: 'Inscription', anchor: 'inscription'),
  ];

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
              ? const Color(0xE0FAF9F6)
              : Colors.transparent,
          child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      // Logo animé
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
                      const Spacer(),
                      // Bouton CTA vert
                      GestureDetector(
                        onTap: widget.onReserver,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Réserver',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Hamburger
                      GestureDetector(
                        onTap: () =>
                            setState(() => _isMenuOpen = !_isMenuOpen),
                        child: Icon(
                          _isMenuOpen ? Icons.close : Icons.menu,
                          size: 22,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Menu déroulant
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  height: _isMenuOpen ? _links.length * 48.0 : 0,
                  child: ClipRect(
                    child: Column(
                      children: _links
                          .map(
                            (link) => SizedBox(
                              height: 48,
                              child: InkWell(
                                onTap: () {
                                  setState(() => _isMenuOpen = false);
                                  widget.onReserver();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        link.label,
                                        style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                if (_isScrolled)
                  Container(
                    height: 1,
                    color: AppColors.accent.withValues(alpha: 0.1),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink {
  final String label;
  final String anchor;

  const _NavLink({required this.label, required this.anchor});
}
