//the whole app is true localized,so, use this constants only if u wanna change a specific-elemet localization from true to false:
class FalseLocalizations {
  const FalseLocalizations._();
//------------------------------------ appbars ---------------------------------------
  static const bool isAppBarLocalized = false;

//------------------------------------ buttons ---------------------------------------
  static const bool isButtonLocalized =
      false; //--->the app will use this default settings, if the below variables are not given or specified.

  static const bool isNegativeBtnTxtDialogLocalized = false;
  static const bool isPositiveBtnTxtDialogLocalized = false;
//----------------------------------- (Action-Reject) Dialog  ---------------------------------------
  static const bool isDialogTitleLocalized = false;
  static const bool isDialogContentLocalized = false;

//----------------------------------- Oerlay Builder  ---------------------------------------
  static const bool isOverlayTitleLocalized = false;
  static const bool isOverlayContentLocalized = false;

//----------------------------------- text form fields -------------------------------
  static const bool istextFormFieldLabelLocalized = false;
  static const bool istextFormFieldHintLocalized = false;

//------------------------------------ snackbars ------------------------------------
  static const bool isSnackBarLocalized = false;

//----------------------------------- Bottom Navigation Bar -------------------------
}
