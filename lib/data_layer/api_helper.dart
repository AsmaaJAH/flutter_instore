//-------------------------- Flutter Packages Imports --------------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

//-------------------------- InStore App Imports --------------------------------------------------------------------------------------

import 'package:instore/constants/app_assistant_values/server_constants.dart';
import 'package:instore/control_layer/functions/api_assistant/assist_apihelper.dart';
import 'package:instore/data_layer/models/response_wrapper_model.dart';
import 'package:instore/my_app.dart';

//------------------ API Requests(1.POST --- 2.GET --- 3.DELETE --- 4.PUT ---- 5.PATCH )------------------------------------------------
class ApiHelper {
  static final ApiHelper _singleton = ApiHelper._internal();
  ApiHelper._internal();

  factory ApiHelper() {
    return _singleton;
  }
//=============================================================================================================
//---------------------------------- POST Request -------------------------------------------------------------
//=============================================================================================================
  Future<ResponseWrapperModel?> postRequest({
    required String extensionURI,
    required dynamic requestBody,
    Map<String, String>? customizedHeaders,
    String? authorizationToken,
    String? userType,
    bool isSnackBarErrorShown = false,
  }) async {
    await AssistApiHelper.getUpToDateHeaders();

    Map<String, String>? commonHeaders = {
      //'No time zone in postman APIs until now'
      //'Accept-Encoding': 'gzip, deflate, br',
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Content-type": "application/json",
      "Accept-Language": ServerConstants.currentLanguageCode,
      "Authorization": authorizationToken != null
          ? "Bearer $authorizationToken"
          : "Bearer ${ServerConstants.currentSharedPrefToken}",
      "Logged-As":
          userType ?? "customer", //--------> customer - vendor - and so on
    };

    try {
      Response response = await http.post(
        Uri.parse("${ServerConstants.baseUri}$extensionURI"),
        headers: customizedHeaders ?? commonHeaders,
        body: requestBody,
      );

      AssistApiHelper.printCurrentResults(
        requestType: "POST",
        headers: customizedHeaders ?? commonHeaders,
        requestBody: requestBody,
        extensionURI: extensionURI,
        response: response,
      );

      return AssistApiHelper.wrapUsingResponseModel(response);
    } catch (error) {
      debugPrint(
          '((--------------- error in POST request ----------------)) $error');

      //---------> Error from server, Navigate to main

      //-----------> show snack bar, if the developer choosed to do so:
      if (isSnackBarErrorShown && kNavigatorKey.currentContext != null) {
        //the below ignorance is because i handled it inside the function itself
        // ignore: use_build_context_synchronously
        AssistApiHelper.showUIErrorWarning(
          snackBarContext: kNavigatorKey.currentContext!,
        );
      }
    }
    return null;
  }
//===========================================================================================================
//---------------------------------- GET Request ------------------------------------------------------------
//===========================================================================================================

  Future<ResponseWrapperModel?> getRequest({
    String? authorizationToken,
    Map<String, String>? customizedHeaders,
    String? userType,
    required String extensionURI,
    bool isSnackBarErrorShown = false,

  }) async {
    await AssistApiHelper.getUpToDateHeaders();

    Map<String, String> commonHeaders = {
      //'No time zone in postman APIs until now'
      //'Accept-Encoding': 'gzip, deflate, br',
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Content-type": "application/json",
      "Accept-Language": ServerConstants.currentLanguageCode,
      "Authorization": authorizationToken != null
          ? "Bearer $authorizationToken"
          : "Bearer ${ServerConstants.currentSharedPrefToken}",
      "Logged-As":
          userType ?? "customer", //--------> customer - vendor - and so on
    };

    try {
      Response response = await http.get(
        Uri.parse("${ServerConstants.baseUri}$extensionURI"),
        headers: customizedHeaders ?? commonHeaders,
      );

      AssistApiHelper.printCurrentResults(
        requestType: "GET",
        headers: customizedHeaders ?? commonHeaders,
        extensionURI: extensionURI,
        response: response,
      );

      return AssistApiHelper.wrapUsingResponseModel(response);
    } catch (error) {
      debugPrint(
          '((--------------- error in GET request ----------------)) $error');

      //---------> Error from server, Navigate to main

      //-----------> show snack bar, if the developer choosed to do so:
      if (isSnackBarErrorShown && kNavigatorKey.currentContext != null) {
        //the below ignorance is because i handled it inside the function itself
        // ignore: use_build_context_synchronously
        AssistApiHelper.showUIErrorWarning(
          snackBarContext: kNavigatorKey.currentContext!,
        );
      }
    }
    return null;
  }

//============================================================================================================
//---------------------------------- DELETE Request ----------------------------------------------------------
//============================================================================================================

  Future<ResponseWrapperModel?> deleteRequest({
    String? authorizationToken,
    Map<String, String>? customizedHeaders,
    required String extensionURI,
    Map<String, dynamic>? model,
    bool isSnackBarErrorShown = false,
  }) async {
    await AssistApiHelper.getUpToDateHeaders();

    Map<String, String> commonHeaders = {
      //'No time zone in postman APIs until now'
      //'Accept-Encoding': 'gzip, deflate, br',
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Content-type": "application/json",
      "Accept-Language": ServerConstants.currentLanguageCode,
      "Authorization": authorizationToken != null
          ? "Bearer $authorizationToken"
          : "Bearer ${ServerConstants.currentSharedPrefToken}",
    };

    try {
      String? body = model != null
          ? AssistApiHelper.transformModelToApiBody(modelMap: model)
          : null;

      Response response = await http.delete(
        Uri.parse("${ServerConstants.baseUri}$extensionURI"),
        headers: customizedHeaders ?? commonHeaders,
        body: body,
      );

      AssistApiHelper.printCurrentResults(
        requestType: "DELETE",
        headers: customizedHeaders ?? commonHeaders,
        extensionURI: extensionURI,
        response: response,
      );

      return AssistApiHelper.wrapUsingResponseModel(response);
    } catch (error) {
      debugPrint(
          '((--------------- error in DELETE request ----------------)) $error');

      //---------> Error from server, Navigate to main

      //-----------> show snack bar, if the developer choosed to do so:
      if (isSnackBarErrorShown && kNavigatorKey.currentContext != null) {
        //the below ignorance is because i handled it inside the function itself
        // ignore: use_build_context_synchronously
        AssistApiHelper.showUIErrorWarning(
          snackBarContext: kNavigatorKey.currentContext!,
        );
      }
    }
    return null;
  }

//============================================================================================================
//---------------------------------- PUT Request ----------------------------------------------------------
//============================================================================================================

  Future<ResponseWrapperModel?> putRequest({
    String? authorizationToken,
    String? userType,
    required String extensionURI,
    required String requestBody,
    bool isSnackBarErrorShown = false,
    Map<String, String>? customizedHeaders,
  }) async {
    await AssistApiHelper.getUpToDateHeaders();

    Map<String, String> commonHeaders = {
      //'No time zone in postman APIs until now'
      //'Accept-Encoding': 'gzip, deflate, br',
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Content-type": "application/json",
      "Accept-Language": ServerConstants.currentLanguageCode,
      "Authorization": authorizationToken != null
          ? "Bearer $authorizationToken"
          : "Bearer ${ServerConstants.currentSharedPrefToken}",
      "Logged-As":
          userType ?? "customer", //--------> customer - vendor - and so on
    };

    try {
      Response response = await http.put(
        Uri.parse("${ServerConstants.baseUri}$extensionURI"),
        headers: customizedHeaders ?? commonHeaders,
        body: requestBody,
      );

      AssistApiHelper.printCurrentResults(
        requestType: "PUT",
        headers: customizedHeaders ?? commonHeaders,
        extensionURI: extensionURI,
        response: response,
        requestBody: requestBody,
      );
      return AssistApiHelper.wrapUsingResponseModel(response);
    } catch (error) {
      debugPrint(
          '((--------------- error in PUT request ----------------)) $error');

      //---------> Error from server, Navigate to main

      //-----------> show snack bar, if the developer choosed to do so:
      if (isSnackBarErrorShown && kNavigatorKey.currentContext != null) {
        //the below ignorance is because i handled it inside the function itself
        // ignore: use_build_context_synchronously
        AssistApiHelper.showUIErrorWarning(
          snackBarContext: kNavigatorKey.currentContext!,
        );
      }
    }
    return null;
  }

//============================================================================================================
//---------------------------------- PATCH Request ----------------------------------------------------------
//============================================================================================================

  Future<ResponseWrapperModel?> patchRequest({
    String? userType,
    required String extensionURI,
    required String requestBody,
    String? authorizationToken,
    bool isSnackBarErrorShown = false,
    Map<String, String>? customizedHeaders,
  }) async {
    await AssistApiHelper.getUpToDateHeaders();

    Map<String, String> commonHeaders = {
      //'No time zone in postman APIs until now'
      //'Accept-Encoding': 'gzip, deflate, br',
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Content-type": "application/json",
      "Accept-Language": ServerConstants.currentLanguageCode,
      "Authorization": authorizationToken != null
          ? "Bearer $authorizationToken"
          : "Bearer ${ServerConstants.currentSharedPrefToken}",
      "Logged-As":
          userType ?? "customer", //--------> customer - vendor - and so on
    };

    try {
      Response response = await http.patch(
        Uri.parse("${ServerConstants.baseUri}$extensionURI"),
        headers: customizedHeaders ?? commonHeaders,
        body: requestBody,
      );
      AssistApiHelper.printCurrentResults(
        requestType: "PATCH",
        headers: customizedHeaders ?? commonHeaders,
        extensionURI: extensionURI,
        response: response,
        requestBody: requestBody,
      );
      return AssistApiHelper.wrapUsingResponseModel(response);
    } catch (error) {
      debugPrint(
          '((--------------- error in PATCH request ----------------)) $error');

      //---------> Error from server, Navigate to main

      //-----------> show snack bar, if the developer choosed to do so:
      if (isSnackBarErrorShown && kNavigatorKey.currentContext != null) {
        //the below ignorance is because i handled it inside the function itself
        // ignore: use_build_context_synchronously
        AssistApiHelper.showUIErrorWarning(
          snackBarContext: kNavigatorKey.currentContext!,
        );
      }
    }
    return null;
  }
}
