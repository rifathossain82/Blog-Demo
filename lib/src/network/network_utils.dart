import 'dart:convert';
import 'dart:io';
import 'package:blog_with_provider_demo/src/services/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class Network {
  static const String _noInternetMessage = "Please check your connection!";

  static getRequest({required String api, params}) async {
    if(!await hasInternet){
      throw _noInternetMessage;
    }

    kPrint("\nYou hit: $api");
    kPrint("Request Params: $params");

    Response response = await get(
      Uri.parse(api).replace(queryParameters: params),
    );
    return response;
  }

  static postRequest({required String api, body}) async {
    if(!await hasInternet){
      throw _noInternetMessage;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    var headers = {
      'Accept': 'application/json',
    };

    Response response = await post(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }

  static multiPartRequest({required String api, methodName, body, File? file, String fieldName = 'file'}) async {
    if(!await hasInternet){
      throw _noInternetMessage;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    var request = MultipartRequest(
      methodName.toUpperCase(),
      Uri.parse(api),
    );

    if (body != null) {
      request.fields.addAll((body));
    }
    if (file != null) {
      request.files.add(await MultipartFile.fromPath(
        fieldName,
        file.path,
        contentType: MediaType(
          mime(file.path)!.split('/')[0],
          mime(file.path)!.split('/')[1],
        ),
      ));
    }
    kPrint('Request Files: ${request.files}');
    kPrint('Headers: ${request.headers}');
    kPrint('Request Fields: ${request.fields}');

    StreamedResponse streamedResponse = await request.send();
    Response response = await Response.fromStream(streamedResponse);
    return response;
  }

  static handleResponse(Response response) async {
    try {
      if(!await hasInternet){
        throw _noInternetMessage;
      }

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        kPrint('SuccessCode: ${response.statusCode}');
        kPrint('SuccessResponse: ${response.body}');

        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return response.body;
        }
      } else if (response.statusCode == 401) {
        throw 'Unauthenticated';
      } else if (response.statusCode == 500) {
        throw "Server Error";
      } else {
        kPrint('ErrorCode: ${response.statusCode}');
        kPrint('ErrorResponse: ${response.body}');

        String msg = "Something went wrong";
        if (response.body.isNotEmpty) {
          msg = json.decode(response.body)['errors'];
        }

        throw msg;
      }
    } on SocketException catch (e) {
      throw _noInternetMessage;
    } on FormatException catch (e) {
      throw "Bad response format";
    } catch (e) {
      throw e.toString();
    }
  }
}