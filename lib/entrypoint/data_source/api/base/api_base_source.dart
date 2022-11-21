import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

// Constantes

import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppConstants;
import 'package:app_mercury_flutter/entrypoint/data_source/api/base/index.dart'
    show ApiBaseStrings;
// Enumeraciones
import 'package:app_mercury_flutter/entrypoint/data_source/api/base/enums/index.dart'
    show HttpMethodsEnum, TypeResponseEnum;

// Strings para los errores

// Modelos

// Utilidades
import 'package:app_mercury_flutter/core/index.dart'
    show
        MyConnectivity,
        MySingletonSharedPreferences,
        RefrescarTokenDomain,
        RefrescarTokenPresenter,
        Resultado;

class ApiSource {
  final String? baseUrl;
  final http.Client client;
  final MyConnectivity connectivity;
  final MySingletonSharedPreferences singletonSharedPreferences;

  ApiSource(
    this.baseUrl,
    this.client,
    this.connectivity,
    this.singletonSharedPreferences,
  );

  Future<Resultado<T>> getApi<T>(
    String url,
    T Function(dynamic value) mapperFunction, {
    Map<String, String>? headers,
    TypeResponseEnum typeResponse = TypeResponseEnum.dataInBody,
  }) async {
    try {
      var isConnected = await connectivity.isConnected();
      if (!isConnected) {
        return Resultado<T>.error(message: ApiBaseStrings.internetNotAvailable);
      }

      headers = getHeaders(headers);
      var response = await client
          .get(Uri.parse(url), headers: headers)
          .timeout(AppConstants.DURACION_CONSUMO_APIS);

      return await _manageResponse<T>(response, url, mapperFunction,
          HttpMethodsEnum.get, null, typeResponse);
    } catch (ex) {
      log(ex.toString(), name: 'responseError', error: ex);
      return Resultado<T>.error(message: ApiBaseStrings.defaultError);
    }
  }

  Future<Resultado<T>> postApi<T>(
    String url,
    Map<String, dynamic>? body,
    T Function(dynamic value) mapperFunction, {
    Map<String, String>? headers,
    TypeResponseEnum typeResponse = TypeResponseEnum.dataInBody,
    String? xBody,
    String? autorization,
  }) async {
    try {
      var isConnected = await connectivity.isConnected();
      if (!isConnected) {
        return Resultado<T>.error(message: ApiBaseStrings.internetNotAvailable);
      }

      headers = getHeaders(headers, xBody: xBody, authorization: autorization);
      log(json.encode(body), name: 'requestBody');

      http.Response response = await client
          .post(Uri.parse(url),
              body: body != null ? json.encode(body) : null, headers: headers)
          .timeout(AppConstants.DURACION_CONSUMO_APIS);

      return await _manageResponse<T>(response, url, mapperFunction,
          HttpMethodsEnum.post, body, typeResponse);
    } catch (ex) {
      log(ex.toString(), name: 'responseError', error: ex);
      return Resultado<T>.error(message: ApiBaseStrings.defaultError);
    }
  }

  Future<Resultado<T>> putApi<T>(
    String url,
    Map<String, dynamic>? body,
    T Function(dynamic value) mapperFunction, {
    Map<String, String>? headers,
    TypeResponseEnum typeResponse = TypeResponseEnum.dataInBody,
  }) async {
    try {
      var isConnected = await connectivity.isConnected();
      if (!isConnected) {
        return Resultado<T>.error(message: ApiBaseStrings.internetNotAvailable);
      }
      headers = getHeaders(headers);
      log(json.encode(body), name: 'requestBody');
      var response = await client
          .put(Uri.parse(url), body: json.encode(body), headers: headers)
          .timeout(AppConstants.DURACION_CONSUMO_APIS);
      return await _manageResponse<T>(response, url, mapperFunction,
          HttpMethodsEnum.put, body, typeResponse);
    } catch (ex) {
      log(ex.toString(), name: 'responseError', error: ex);
      return Resultado<T>.error(message: ApiBaseStrings.defaultError);
    }
  }

  Future<Resultado<T>> deleteApi<T>(
    String url,
    T Function(dynamic value) mapperFunction, {
    Map<String, String>? headers,
    TypeResponseEnum typeResponse = TypeResponseEnum.dataInBody,
  }) async {
    try {
      var isConnected = await connectivity.isConnected();
      if (!isConnected) {
        return Resultado<T>.error(message: ApiBaseStrings.internetNotAvailable);
      }
      headers = getHeaders(headers);
      var response = await client
          .delete(Uri.parse(url), headers: headers)
          .timeout(AppConstants.DURACION_CONSUMO_APIS);
      return await _manageResponse<T>(response, url, mapperFunction,
          HttpMethodsEnum.delete, null, typeResponse);
    } catch (ex) {
      log(ex.toString(), name: 'responseError', error: ex);
      return Resultado<T>.error(message: ApiBaseStrings.defaultError);
    }
  }

  Future<Resultado<T>> _manageResponse<T>(
    http.Response response,
    String url,
    T Function(dynamic value) mapperFunction,
    HttpMethodsEnum method,
    Map<String, dynamic>? body,
    TypeResponseEnum typeResponse,
  ) async {
    try {
      _logResponse(response);
      if (response.statusCode == 200) {
        Map? responseMap = _decodeJson(response.body);
        return _decodeBodyWithTypeResponse<T>(
          typeResponse,
          responseMap,
          mapperFunction,
        );
      }
      if (response.statusCode == 401) {
        return await _refreshToken<T>(() {
          switch (method) {
            case HttpMethodsEnum.post:
              return postApi<T>(url, body, mapperFunction);
            case HttpMethodsEnum.put:
              return putApi<T>(url, body, mapperFunction);
            case HttpMethodsEnum.delete:
              return deleteApi<T>(url, mapperFunction);
            default: // HttpMethodsEnum.GET
              return getApi<T>(url, mapperFunction);
          }
        });
      }
      return _manageError<T>(response);
    } on Exception catch (ex) {
      log('No fue posible procesar la respuesta - ${ex.toString()}',
          name: '_manageResponse');
      return Resultado.error(message: ApiBaseStrings.defaultError);
    }
  }

  void _logResponse(
    http.Response response,
  ) {
    log(response.request!.url.toString(), name: 'url');
    log(response.request!.method, name: 'method');
    log(response.request!.headers.toString(), name: 'headers');
    log(response.statusCode.toString(), name: 'statusCode');
    log(response.body, name: 'responseBody');
  }

  Resultado<T> _decodeBodyWithTypeResponse<T>(
    TypeResponseEnum typeResponse,
    Map? responseMap,
    T Function(dynamic value) mapperFunction,
  ) {
    dynamic body;
    String? statusCodeResponse;
    switch (typeResponse) {
      case TypeResponseEnum.dataInBody:
        body = _getPropertyFromMap(responseMap!, 'body');
        statusCodeResponse = responseMap.containsKey('statusCode')
            ? responseMap['statusCode']
            : 'OK';
        break;

      case TypeResponseEnum.dataInResponse:
        body = _getPropertyFromMap(responseMap!, 'response');

        statusCodeResponse =
            responseMap.containsKey('codigo') ? responseMap['codigo'] : 'OK';
        break;

      case TypeResponseEnum.data:
        body = responseMap;
        statusCodeResponse = 'OK';
        break;
    }

    T? mapperFunctionApply;

    if (body != null) {
      mapperFunctionApply = mapperFunction(body);
    }

    return Resultado<T>.success(
      mapperFunctionApply,
      statusCodeResponse,
    );
  }

  Resultado<T> _manageError<T>(http.Response response) {
    if (response.statusCode >= 500) {
      return Resultado<T>.error(message: ApiBaseStrings.defaultError);
    } else {
      return _errorFromMap(response);
    }
  }

  Resultado<T> _errorFromMap<T>(http.Response response) {
    try {
      Map<String, dynamic>? body =
          (response.body.isNotEmpty) ? jsonDecode(response.body) : null;
      if (body != null) {
        String? description = body['description'];
        description = description ?? ApiBaseStrings.defaultError;
        int? code =
            body.containsKey('statusCodeValue') ? body['statusCodeValue'] : 0;
        return Resultado<T>.error(message: description, code: code);
      } else {
        return Resultado<T>.error(
            message: ApiBaseStrings.defaultError, code: response.statusCode);
      }
    } catch (ex) {
      log(ex.toString(), name: 'error');
      return Resultado<T>.error(
          message: ApiBaseStrings.defaultError, code: response.statusCode);
    }
  }

  Future<Resultado<T>> _refreshToken<T>(
      Future<Resultado<T>> Function() function) async {
    var url = '$baseUrl/${AppConstants.APP_SUCURSAL}/login/refrescar-token';
    log(url, name: 'refrescar-token');

    var data = RefrescarTokenPresenter();
    data.tokenActual = getToken();
    Map<String, String?> headers = getHeaders(null);

    http.Response response = await client
        .post(Uri.parse(url),
            body: json.encode(data.toJson()),
            headers: headers as Map<String, String>?)
        .timeout(AppConstants.DURACION_CONSUMO_APIS);

    if (_validarGuardarToken(response)) {
      return function();
    } else {
      singletonSharedPreferences.$logoutController!.add(true);
      return Resultado<T>.unauthorized(
          message: ApiBaseStrings.unauthorized, code: 401);
    }
  }

  bool _validarGuardarToken(http.Response response) {
    if (response.statusCode == 200) {
      RefrescarTokenDomain? refrescarTokenDomain = response.body.trim().isEmpty
          ? null
          : RefrescarTokenDomain.fromJson(
              _decodeJson(response.body),
            );
      return _validarTokenRefrescado(refrescarTokenDomain);
    } else {
      return false;
    }
  }

  bool _validarTokenRefrescado(RefrescarTokenDomain? refrescarTokenDomain) {
    if ((refrescarTokenDomain != null && refrescarTokenDomain.refrescado!)) {
      saveToken(refrescarTokenDomain.token);
      return true;
    } else {
      return false;
    }
  }

  dynamic _decodeJson(String body) {
    try {
      return json.decode(body);
    } catch (ex) {
      log(ex.toString(), name: 'decodeJson');
      return body;
    }
  }

  dynamic _getPropertyFromMap(Map jsonResponse, String key) {
    try {
      if (jsonResponse.containsKey(key)) {
        return jsonResponse[key];
      } else {
        return jsonResponse;
      }
    } catch (ex) {
      log(ex.toString(), name: '_getPropertyFromMap');
      return jsonResponse;
    }
  }

  Map<String, String> getHeaders(Map<String, String>? headers,
      {String? xBody, String? authorization}) {
    headers = headers ?? <String, String>{};
    headers = setHeaderToken(headers);
    headers = setHeaderCurrentPage(headers);
    headers[HttpHeaders.contentTypeHeader] = "application/json; charset=utf-8";
    headers[HttpHeaders.acceptCharsetHeader] = "charset=UTF-8";
    headers[HttpHeaders.acceptHeader] = "application/json; charset=UTF-8";
    // headers['X-Body'] = xBody ?? '';
    // headers['Authorization'] = authorization ?? '';

    return headers;
  }

  Map<String, String> setHeaderToken(Map<String, String> headers) {
    var token = getToken();
    if (token != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    return headers;
  }

  Map<String, String> setHeaderCurrentPage(Map<String, String> headers) {
    var currentPage = getCurrentPage();
    if (currentPage != null) {
      headers["X-Auditoria-Url"] = currentPage;
    }
    return headers;
  }

  void saveToken(String? token) {
    singletonSharedPreferences.token = token;
  }

  String? getToken() {
    return singletonSharedPreferences.token;
  }

  String? getCurrentPage() {
    return singletonSharedPreferences.paginaActual;
  }
}
