import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/env.dart';

class StorageService {
  final _client = Supabase.instance.client;

  Future<String?> uploadProfilePhoto(String uid, Uint8List bytes, String filename) async {
    final path = 'uploads/$filename';
    await _client.storage
        .from(Env.storageProfileBucket)
        .uploadBinary(path, bytes, fileOptions: const FileOptions(upsert: true));
    final publicUrl = _client.storage.from(Env.storageProfileBucket).getPublicUrl(path);
    return publicUrl;
  }
}