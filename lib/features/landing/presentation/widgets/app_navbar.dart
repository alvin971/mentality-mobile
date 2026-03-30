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
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: _isScrolled
              ? ImageFilter.blur(sigmaX: 12, sigmaY: 12)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            color: _isScrolled
                ? const Color(0xBFD7E8D2)
                : Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  _buildLogo(),
                  const Spacer(),
                  _buildCTA(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: RotationTransition(
            turns: _rotationController,
            child: const Icon(
              Icons.radio_button_unchecked,
              color: AppColors.accent,
              size: 22,
            ),
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
      ],
    );
  }

  Widget _buildCTA() {
    return ElevatedButton(
      onPressed: widget.onReserver,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.textPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: const Text('Réserver'),
    );
  }
}
