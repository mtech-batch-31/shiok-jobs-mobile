import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shiok_jobs_flutter/NetworkClient/app_excepton.dart';

class NetworkClient {
  static final NetworkClient _instance = NetworkClient._internal();

  factory NetworkClient() {
    return _instance;
  }

  NetworkClient._internal();

  final Map<String, String> _headers = {};

  void setHeaders(Map<String, String> headers) {
    _headers.addAll(headers);
  }

  Future<dynamic> get(String url) async {
    final response = await _sendRequest(url, method: 'GET');
    return _handleResponse(response);
  }

  Future<dynamic> post(String url, {required Map<String, dynamic> body}) async {
    final response = await _sendRequest(url, method: 'POST', body: body);
    return _handleResponse(response);
  }

  Future<http.Response> _sendRequest(String url,
      {String method = 'GET', Map<String, dynamic>? body}) async {
    final uri = Uri.parse(url);
    final request = http.Request(method, uri);
    if (body != null) {
      request.body = jsonEncode(body);
    }
    final streamedResponse = await http.Client().send(request);
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        debugPrint(responseJson);
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
