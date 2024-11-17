import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  //------------------------get api response---------------------/

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        'X-RapidAPI-Key': '8cf4ab2473mshcad20779c42f299p1f81c7jsn667be24666a7',
        'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com'
      }).timeout(
        const Duration(seconds: 60),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet");
    }

    return responseJson;
  }

//-----------------------get post api response-------------------//
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      Response response = await post(
        Uri.parse(url),
        body: json.encode(data),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          'Accept': '*/*',
          "content-type": "application/json",

          //------------//
        },
      ).timeout(
        const Duration(seconds: 60),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  //--------------------------Put api response-------------------//

  @override
  Future getPutApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      Response response = await put(
        Uri.parse(url),
        body: data,
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          'Accept': '*/*',
          // "content-type": "application/json"
        },
      ).timeout(
        const Duration(seconds: 60),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  //-----------------------------------------------------------//

  //--------------------------Delete api response-------------------//
  @override
  Future getDeleteApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      Response response = await delete(
        Uri.parse(url),
        body: data,
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          'Accept': '*/*',
          // "content-type": "application/json"
        },
      ).timeout(
        const Duration(seconds: 60),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(
          response.body.toString(),
        );
      case 404:
        throw UnauthorisedException(
          response.body.toString(),
        );
      default:
        throw FetchDataException(
          "Error occured while communicating with server with status code${response.statusCode}",
        );
    }
  }
}
