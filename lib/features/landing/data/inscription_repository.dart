import 'package:supabase_flutter/supabase_flutter.dart';

class InscriptionResult {
  final bool success;
  final String? errorMessage;
  final int? placeNumber;

  const InscriptionResult({
    required this.success,
    this.errorMessage,
    this.placeNumber,
  });
}

class InscriptionRepository {
  final SupabaseClient _client;

  InscriptionRepository(this._client);

  Future<int> fetchSignupCount() async {
    final response = await _client
        .from('inscriptions_anticipees')
        .select('id')
        .count(CountOption.exact);
    return response.count;
  }

  Future<InscriptionResult> inscrire({
    required String prenom,
    required String nom,
    required String email,
    required String telephone,
    required String sourceReseauSocial,
  }) async {
    try {
      final response = await _client
          .from('inscriptions_anticipees')
          .insert({
            'prenom': prenom.trim(),
            'nom': nom.trim(),
            'email': email.trim().toLowerCase(),
            'telephone': telephone.trim(),
            'source_reseau_social': sourceReseauSocial,
          })
          .select('id')
          .single();

      final placeNumber = response['id'] as int?;
      return InscriptionResult(success: true, placeNumber: placeNumber);
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        return const InscriptionResult(
          success: false,
          errorMessage: 'Cet email est déjà inscrit à l\'accès anticipé.',
        );
      }
      return InscriptionResult(
        success: false,
        errorMessage: 'Une erreur est survenue. Veuillez réessayer.',
      );
    } catch (_) {
      return const InscriptionResult(
        success: false,
        errorMessage: 'Une erreur est survenue. Veuillez réessayer.',
      );
    }
  }
}
