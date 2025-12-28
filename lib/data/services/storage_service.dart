import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/env.dart';

class StorageService {
  final _client = Supabase.instance.client;

  Future<String> uploadProfilePhoto(String uid, Uint8List bytes) async {
    final path = 'profiles/$uid/avatar.jpg'; //bikin nama file foto default

    await _client.storage
        .from(Env.storageProfileBucket)
        .uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(
            upsert: true,
            contentType: 'image/jpeg',
          ),
        );

    final publicUrl = _client.storage
        .from(Env.storageProfileBucket)
        .getPublicUrl(path);

    // 🚀 cache-busting
    return '$publicUrl?v=${DateTime.now().millisecondsSinceEpoch}';
  }
}
