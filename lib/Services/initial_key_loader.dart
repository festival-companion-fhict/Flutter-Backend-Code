// ignore: file_names
// lib/services/initial_key_loader.dart
import 'secure_storage.dart';

class InitialKeyLoader {
  static const String _apiKeyKey = 'api_key';

  /// Call once on app start to seed the key if the storage is empty.
  static Future<void> seedIfEmpty() async {
    final storage = SecureStorage();
    final existing = await storage.read(key: _apiKeyKey);
    if (existing == null) {
      // 👉 **Replace** the line below with the real static key you got from Azure
      const rawKey = 'YOUR_API_KEY_HERE';
      await storage.write(key: _apiKeyKey, value: rawKey);
    }
  }
}