//-------------------------- Flutter Packages Imports ----------------------------------


//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/data_layer/models/response_wrapper_model.dart';
import 'package:instore/data_layer/services/authentication_services.dart';

class AuthenticationRepository {
  final AuthenticationService _authenticationService = AuthenticationService();

  Future<ResponseWrapperModel?> login({ required
    bool isLoginAfterSignUp,
  }) async {
    final response = await _authenticationService.login(isLoginAfterSignUp: isLoginAfterSignUp);
    return response;
  }
    Future<ResponseWrapperModel?> signUp() async {
    final response = await _authenticationService.signUp();
    return response;
  }
    Future<ResponseWrapperModel?> sendVerificationCode() async {
    final response = await _authenticationService.sendVerificationCode();
    return response;
  }

    Future<ResponseWrapperModel?> verifyAccount() async {
    final response = await _authenticationService.verifyAccount();
    return response;
  }
  
  Future<ResponseWrapperModel?> forgetPassword() async {
    final response = await _authenticationService.forgetPassword();
    return response;
  }
}

