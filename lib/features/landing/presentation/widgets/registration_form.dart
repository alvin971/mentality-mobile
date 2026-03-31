import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../data/inscription_repository.dart';

class RegistrationForm extends StatefulWidget {
  final void Function(int? placeNumber, String prenom) onSuccess;

  const RegistrationForm({super.key, required this.onSuccess});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _prenomController = TextEditingController();
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  String _sourceReseau = 'TikTok';
  bool _acceptCgu = false;
  bool _loading = false;
  String? _errorMessage;

  late final InscriptionRepository _repo;

  static const _sources = [
    'TikTok',
    'Instagram',
    'YouTube',
    'Recommandation',
    'Autre',
  ];

  @override
  void initState() {
    super.initState();
    _repo = InscriptionRepository(Supabase.instance.client);
  }

  @override
  void dispose() {
    _prenomController.dispose();
    _nomController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptCgu) {
      setState(() => _errorMessage =
          'Veuillez accepter les conditions d\'utilisation.');
      return;
    }

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    HapticFeedback.lightImpact();

    final result = await _repo.inscrire(
      prenom: _prenomController.text,
      nom: _nomController.text,
      email: _emailController.text,
      telephone: _telephoneController.text,
      sourceReseauSocial: _sourceReseau,
    );

    setState(() => _loading = false);

    if (result.success) {
      HapticFeedback.mediumImpact();
      widget.onSuccess(result.placeNumber, _prenomController.text.trim());
    } else {
      setState(() => _errorMessage = result.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: AppTextStyles.serif(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  height: 1.25,
                  letterSpacing: -0.3,
                ),
                children: const [
                  TextSpan(text: 'Réserver mon '),
                  TextSpan(
                    text: 'accès gratuit',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Gratuit · Sans engagement · Données protégées RGPD',
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 28),

            // Prénom + Nom
            Row(
              children: [
                Expanded(
                    child: _buildField(_prenomController, 'Prénom *',
                        isRequired: true)),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildField(_nomController, 'Nom *',
                        isRequired: true)),
              ],
            ),
            const SizedBox(height: 14),

            _buildField(
              _emailController,
              'Email *',
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email requis';
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                  return 'Email invalide';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),

            _buildField(
              _telephoneController,
              'Téléphone *',
              isRequired: true,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: _sourceReseau,
              decoration: InputDecoration(
                labelText: 'Comment nous avez-vous connu ?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.accent, width: 1.5),
                ),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 14),
              ),
              style: GoogleFonts.dmSans(
                  fontSize: 14, color: AppColors.textPrimary),
              items: _sources
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _sourceReseau = v!),
            ),
            const SizedBox(height: 16),

            // CGU checkbox
            GestureDetector(
              onTap: () => setState(() => _acceptCgu = !_acceptCgu),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _acceptCgu ? AppColors.accent : AppColors.white,
                      border: Border.all(
                        color:
                            _acceptCgu ? AppColors.accent : AppColors.border,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: _acceptCgu
                        ? const Icon(Icons.check,
                            size: 14, color: AppColors.white)
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'J\'accepte les conditions d\'utilisation et la politique de confidentialité.',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0x15B83232),
                  border: Border.all(color: const Color(0x40B83232)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline,
                        size: 16, color: AppColors.danger),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: AppColors.danger,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _loading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.textTertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        'Réserver mon accès gratuit →',
                        style: GoogleFonts.dmSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 12),
            Center(
              child: Text(
                'Vos données sont protégées et ne seront jamais revendues.',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label, {
    bool isRequired = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        labelStyle:
            GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary),
      ),
      validator: validator ??
          (v) {
            if (isRequired && (v == null || v.trim().isEmpty)) {
              return 'Champ requis';
            }
            return null;
          },
    );
  }
}
