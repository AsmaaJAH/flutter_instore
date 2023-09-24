//-------------------------- Flutter Packages Imports ----------------------------------

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_assistant_values/server_constants.dart';
import 'package:instore/control_layer/functions/user_current_status.dart';
import 'package:instore/data_layer/models/response_wrapper_model.dart';
import 'package:instore/my_app.dart';
import 'package:instore/presentation_layer/app_snack_bar.dart';

class AssistApiHelper {
  const AssistApiHelper._();
//---------------------------------- getUpToDateHeaders -----------------------------------

  static Future getUpToDateHeaders() async {
    if (kNavigatorKey.currentContext != null) {
      return;
    } else if (!kNavigatorKey.currentContext!.mounted) {
      return;
    } else {
      await UserCurrentStatus.getToken();
      await UserCurrentStatus.getAppCurrentLanguageCode(
          kNavigatorKey.currentContext!);
    }
  }

//---------------------------------- printCurrentResults -----------------------------------

  static printCurrentResults(
      {required String requestType, //POST, GET, PUT, PATCH, DELETE
      dynamic requestBody,
      Map<String, String>? headers,
      required String extensionURI,
      required Response response}) {
    debugPrint(
        "((-------------------------- $requestType URL---------------------)) ${ServerConstants.baseUri}$extensionURI");
    if (headers != null) {
      debugPrint(
        "((------------------------$requestType Headers---------------------)) $headers",
      );
    }
    if (requestBody != null) {
      debugPrint(
          "((-------------------$requestType Request-Body ---------------------))  $requestBody");
    }
    debugPrint(
        "((------------------- response statusCode in $requestType request---------------------))  ${response.statusCode}");
    debugPrint(
        "((-------------response body in $requestType request ---------------------)) ${response.body}");
  }
//---------------------------------- getDecodedResponse -----------------------------------

  static dynamic getDecodedResponse({required String data, String? label}) {
    //decode
    var responseBody = json.decode(data);
    //print
    log(
      responseBody.toString(),
      name: label ?? "(( ----------- Response: ----------))",
    );
    //return
    return responseBody;
  }
//---------------------------------- wrapUsingResponseModel -----------------------------------

  static Future<ResponseWrapperModel> wrapUsingResponseModel(
      Response response) {
    return Future.value(
      response.statusCode < 300
          ? ResponseWrapperModel(
              isSucceeded: true,
              statusCode: response.statusCode,
              responseBody: getDecodedResponse(
                  data: response.body,
                  label: '(( --------- Network API Response:----------))'),
            )
          : ResponseWrapperModel(
              isSucceeded: false,
              statusCode: response.statusCode,
              error: extractTheErrorWrapper(response),
            ),
    );
  }
//---------------------------------- extract The "ErrorWrapper" -----------------------------------

  static ErrorWrapper? extractTheErrorWrapper(Response response) {
    try {
      final Map<String, dynamic> errorMap = json.decode(response.body);
      log("${errorMap['error']}", name: "Error");
      log("${errorMap["message"]}", name: "message");
      if (errorMap['error'] is String) {
        return ErrorWrapper(
            error: errorMap['error'], message: errorMap['message']);
      } else if (errorMap["message"] != null) {
        return ErrorWrapper(
            error: errorMap['message'], message: errorMap['message']);
      }
      return ErrorWrapper(
          error: errorMap['error'], message: errorMap['message']);
    } catch (error) {
      log("------- ***--***---*** -------", name: "Error catch");
      log("((----------***--------  Response Request -------***---------)) ${response.request}");
      return const ErrorWrapper(
          error: 'Parsing error during excuting extractErrorWrapper function',
          message:
              'Parsing error during excuting extractErrorWrapper function');
    }
  }
//---------------------------------- show UI Error Warning -----------------------------------

  static void showUIErrorWarning({required BuildContext snackBarContext}) {
    // ignore: use_build_context_synchronously
    if (!snackBarContext.mounted) {
      return;
    }
    AppSnackBar(
            isError: true,
            context: snackBarContext,
            message: "Something went wrong, please try again later!")
        .showAppSnackBar();
  }

  //---------------------------------- transformModelToApiBody -----------------------------------

  static String transformModelToApiBody(
      {required Map<String, dynamic> modelMap, String? label}) {
    final body = json.encode(modelMap);
    log(body,
        name: label ??
            "(( ----------- Your Model After Transforming It To Network Request Body: ----------))");
    return body;
  }

//------------------------------------- getFCMToken -------------------------------------------------------
  static Future<String?> getFCMToken() async {
    var firebaseMessaging = FirebaseMessaging.instance;
    String? token;
    try {
      token = await firebaseMessaging.getToken();
    } catch (error) {
      token = "";
    }
    return token;
  }
}
