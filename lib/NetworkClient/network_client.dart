import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shiok_jobs_flutter/NetworkClient/app_excepton.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkClient {
  static final NetworkClient _instance = NetworkClient._internal();

  factory NetworkClient() {
    return _instance;
  }

  NetworkClient._internal();

  final Map<String, String> _headers = {};
  final _certFingerPrint = dotenv.env['SHA_FingerPrint'];

  void setHeaders(Map<String, String> headers) {
    _headers.addAll(headers);
  }

  Future<dynamic> get(String url) async {
    final response = await _sendRequest(url, method: 'GET');
    return _handleResponse(response);
  }

  Future<dynamic> post(String url, {required dynamic body}) async {
    final response = await _sendRequest(url, method: 'POST', body: body);
    return _handleResponse(response);
  }

  Future<http.Response> _sendRequest(String url,
      {String method = 'GET', dynamic body}) async {
    final uri = Uri.parse(url);
    final client = getClient([_certFingerPrint ?? '']);
    final request = http.Request(method, uri);
    request.headers.addAll(_headers);
    if (body is Map<String, dynamic>) {
      request.body = jsonEncode(body);
    } else if (body != null) {
      request.body = jsonEncode(body);
    }
    switch (request.method) {
      case 'GET':
        return await client.get(request.url, headers: request.headers);
      case 'POST':
        return await client.post(request.url,
            headers: request.headers, body: request.body);
      default:
        throw Exception('Method not supported');
    }
  }

  SecureHttpClient getClient(List<String> allowedSHAFingerprints) {
    final secureClient = SecureHttpClient.build(allowedSHAFingerprints);
    return secureClient;
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
