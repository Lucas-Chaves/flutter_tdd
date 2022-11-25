import 'dart:convert';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response = await client.post(
      Uri(path: url),
      headers: headers,
      body: jsonBody,
    );
    return _handleResponse(response);
  }

  Map _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? {} : jsonDecode(response.body);
      case 204:
        return {};
      case 400:
        return throw HttpError.badRequest;
      case 401:
        return throw HttpError.unauthorized;
      case 403:
        return throw HttpError.forbidden;
      case 404:
        return throw HttpError.notFound;
      default:
        return throw HttpError.serverError;
    }
  }
}
