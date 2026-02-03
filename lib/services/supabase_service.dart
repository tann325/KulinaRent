import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String _supabaseUrl = 'https://kotaupxynvdlnnurwqqt.supabase.co';
  static const String _supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtvdGF1cHh5bnZkbG5udXJ3cXF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgzNDc2NTQsImV4cCI6MjA4MzkyMzY1NH0.OEdd_wwMMXl42kFpLQ-Q3bC3MoOwuX9EnQy_kl0H2xY';

  static Future<void> init() async {
    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}