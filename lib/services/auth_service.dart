import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _supabaseService = SupabaseService.client;

  Future<String?> ambilRole(String idUser) async {
    try {
      final data = await _supabaseService
          .from('users')
          .select('role')
          .eq('id_user', idUser)
          .single();
      return data['role'] as String?;
    } catch (e) {
      debugPrint('Error ambil role $e');
      return null;
    }
  }

  Future<AuthResponse> signIn(String email, String password) async {
    final response = await _supabaseService.auth
        .signInWithPassword(email: email, password: password);

    if (response.user != null) {
      String? role = await ambilRole(response.user!.id);

      if (role != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_role', role);
      }
    }
    return response;
  }
}
