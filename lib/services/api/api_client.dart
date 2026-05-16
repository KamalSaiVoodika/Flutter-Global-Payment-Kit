import 'dart:developer';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import '../../constants/strings.dart';
import '../../main.dart';

class ApiClient {
  final String appBaseUrl;

  ApiClient({
    required this.appBaseUrl,
  });

  String? currentToken = prefs.getString(token);
  Map<String, String>? _mainHeaders = {
    'Accept': 'application/json',
  };

  void updateHeader(String token, String zoneID) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> getData(
      String uri, {
        Map<String, String>? headers,
        int? timeOut,
        String? baseUri,
      }) async {
    if (foundation.kDebugMode) {
      log('====> Http Call: ${baseUri ?? appBaseUrl}$uri\nToken: $currentToken');
    }
    http.Response response = await http
        .get(
      Uri.parse(baseUri ?? appBaseUrl + uri),
      headers: headers ?? _mainHeaders,
    )
        .timeout(
      Duration(seconds: timeOut ?? timeoutRequest),
      onTimeout: () {
        return http.Response(
            addedErrorMessage(), 500); // Replace 500 with your http code.
      },
    );
    response = handleResponse(response);
    if (foundation.kDebugMode) {
      log('====> Http Response: [${response.statusCode}] $uri\n${response.body}');
    }
    return response;
  }

  Future<http.Response> postData(
      String uri, {
        dynamic body,
        Map<String, String>? headers,
        int? timeOut,
        String? baseUri,
      }) async {
    if (foundation.kDebugMode) {
      log('====> Http Call: ${baseUri ?? appBaseUrl}$uri\nToken: $currentToken');
    }
    http.Response response = await http
        .post(
      Uri.parse(baseUri ?? appBaseUrl + uri),
      body: body,
      headers: headers ?? _mainHeaders,
    )
        .timeout(
      Duration(seconds: timeOut ?? timeoutRequest),
      onTimeout: () {
        return http.Response(
            addedErrorMessage(), 500); // Replace 500 with your http code.
      },
    );
    response = handleResponse(response);
    if (foundation.kDebugMode) {
      log('====> Http Response: [${response.statusCode}] $uri\n${response.body}');
    }
    return response;
  }

  ///Handel request response
  http.Response handleResponse(http.Response response) {
    http.Response _response = response;
    return _response;
  }

  String addedErrorMessage({String message = serverTimeoutMessage}) {
    return '{"error": "$message"}';
  }
}

