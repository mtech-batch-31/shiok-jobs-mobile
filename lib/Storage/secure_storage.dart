import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<String?> readAccessToken() async {
  return await storage.read(key: 'access_token');
}

Future<void> writeAccessToken(String token) async {
  await storage.write(key: 'access_token', value: token);
}
