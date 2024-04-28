import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureRepository {
  final storage = const FlutterSecureStorage();

  Future<String> getSecureToken() async {
    // get secure token from local storage
    var token = await storage.read(key: 'access_token');

    if (token != null) {
      return token;
    } else {
      return '';
    }
  }

  Future<void> saveSecureToken(String token) async {
    // save secure token to local storage
    await storage.write(key: 'access_token', value: token);
  }

  Future<void> deleteSecureToken() async {
    // delete secure token from local storage
    await storage.delete(key: 'access_token');
  }
}
