import 'dart:convert';
import 'dart:io';

import 'package:bluestack_demo/screens/apis/simplified_uri.dart';
import 'package:http/http.dart' as http;


class ApiBaseHelper {

  static final ApiBaseHelper _singleton = ApiBaseHelper._inter();

  factory ApiBaseHelper() {
    return _singleton;
  }

  ApiBaseHelper._inter();

  getApiCall({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Function(dynamic data)? onSuccess,
    Function(dynamic data)? onFailure,
    Function(bool loading)? loading,
  }) async {
    dynamic apiResponse;
    loading?.call(true);

    final Uri uri = SimplifiedUri.uri(url, queryParameters);

    try {
      final http.Response response = await http.get(
        uri,
        headers: headers,
      );

      try {
        apiResponse = _returnResponse(response: response);
        loading?.call(false);
        onSuccess?.call(apiResponse);
        return apiResponse;
      } catch (e) {
        apiResponse = json.decode(response.body.toString());
        loading?.call(false);
        onFailure?.call(apiResponse);
        return apiResponse;
      } finally {}
    } on SocketException {
      loading?.call(false);
      Map<String, String> jsonData = {'message': 'No Internet connection'};
      await Future.delayed(const Duration(seconds: 2));
      onFailure?.call(jsonData);
    }
  }

  postApiCall({
    required String url,
    Map<String, dynamic>? jsonData,
    Function(dynamic data)? onSuccess,
    Function(dynamic data)? onFailure,
    Function(bool loading)? loading,
    Map<String, String>? headers,
  }) async {
    dynamic apiResponse;
    loading?.call(true);

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(jsonData),
      );

      try {
        apiResponse = _returnResponse(response: response);
        onSuccess?.call(apiResponse);
        return apiResponse;
      } catch (e) {
        apiResponse = json.decode(response.body.toString());
        onFailure?.call(apiResponse);
        return apiResponse;
      } finally {
        loading?.call(false);
      }
    } on SocketException {
      Map<String, String> jsonData = {'message': 'No Internet connection'};
      await Future.delayed(const Duration(seconds: 2));
      onFailure?.call(jsonData);
      // throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse({required http.Response response}) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      default:
        return 'Error occurred while Communication with Server ';
    }
  }
}
