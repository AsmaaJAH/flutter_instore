//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/material.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/pin_code_provider.dart';
import 'package:instore/my_app.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:instore/control_layer/app_otp_strategy.dart';
import 'package:provider/provider.dart';

class PinCode extends StatefulWidget {
  const PinCode({super.key});
  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  late String pinCode;
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  late PinCodeProviderState pinCodeState;
  @override
  void initState() {
    super.initState();
    pinCodeState = kNavigatorKey.currentContext!.read<PinCodeProviderState>();
    _otpInteractor = OTPInteractor();
    _otpInteractor
        .getAppSignature()
        .then((value) => debugPrint('signature - $value'));

    controller = OTPTextEditController(
      codeLength: Variables.fiveInt,
      onCodeReceive: (code) =>
          debugPrint('Your Application receive code - $code'),
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{5})');
          debugPrint("OTP------>$code");
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [
          AppOtpStrategy(),
          //AppOtpStrategy(currentOTPcode: controller.text),
        ],
      );
  }

  @override
  Future<void> dispose() async {
    //don't dispose this controller now:
    await controller.stopListen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kScreenWidth * 0.25),
      child: PinCodeTextField(
        appContext: context,
        controller: controller,
        keyboardType: TextInputType.number,
        enablePinAutofill: false,
        textStyle: TextThemeManager.regularFont(
          fontColor: AppColors.commonGray,
          fontSize: Variables.double15,
        ),
        length: Variables.fiveInt,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(Variables.five),
          fieldHeight: kScreenWidth * 0.07,
          fieldWidth: kScreenWidth * 0.07,
          inactiveFillColor: AppColors.commonWhite,
          errorBorderColor: AppColors.red,
          activeFillColor: AppColors.commonWhite,
          selectedColor: AppColors.primary,
          selectedBorderWidth: Variables.five,
          borderWidth: Variables.one,
          selectedFillColor: AppColors.commonWhite,
          inactiveColor: AppColors.blackBorder,
          activeColor: AppColors.primary,
          disabledColor: AppColors.commonWhite,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: AppColors.commonWhite,
        enableActiveFill: true,
        onChanged: (value) {
          //dont notify listeners until it is completed:
          pinCodeState.pinCode = value;
        },
        onCompleted: (value) {
          //notify listeners when it is completed:
          pinCodeState.updatePinCode(value);
        },
      ),
    );
  }
}
