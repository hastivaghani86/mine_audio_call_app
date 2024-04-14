import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_color.dart';

// ignore: non_constant_identifier_names
Widget AppTextField({
  TextEditingController? controller,
  TextStyle? hintStyle,
  String? hintText,
  Widget? prefixIcon,
  EdgeInsets? contentPadding,
  TextInputType? textInputType,
  Color? bgColor,
  // double? lcPadding,
  // double? tcPadding,
  // double? rcPadding,
  // double? bcPadding,
  String? labelText,
  String? counterText,
  bool needValidation = false,
  bool? urlValidation = false,
  bool? specialCharacterHideValidation = false,
  bool? onlyAlphabetValidation = false,
  bool? isActive = false,
  String? validationMessage,
  double? horizontal,
  iconButton,
  Widget? prefixButton,
  double? vertical,
  bool readyOnly = false,
  Function? onPressed,
  bool showBfBorder = true,
  bool showBeBorder = true,
  bool titleTextBold = false,
  bool labelTextBold = false,
  bool fillColor = false,
  bool textAlign = false,
  bool isEmailValidation = false,
  bool isPhoneValidation = false,
  bool withCountryCode = false,
  double? labelFontSize,
  double? textSize,
  Color? fbColor,
  Color? ebColor,
  Color? labelTextColor,
  Color? textColor,
  int? maxLength = 32,
  int? maxLines,
  FocusNode? focusNode,
  List<TextInputFormatter>? inputFormatters,
  bool? isPassWordValidation = false,
  bool? isLoginPinValidation = false,
  bool? confirmPassValidation = false,
  String? preText,
  bool obscureText = false,
  Function(String?)? onChangedValue,
  Function(String?)? onSubmited,
  TextInputAction? textInputAction,
  bool upperCaseTextFormatter = true,
  TextCapitalization textCapitalization = TextCapitalization.words,
  bool autofocus = false,
  double borderRadius = 13,
  AutovalidateMode? autovalidateMode,
}) {
  // ignore: prefer_typing_uninitialized_variables
  // var maskFormatterForNumber;
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    child: SizedBox(
      // height: 56,
      child: TextFormField(
        autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
        autofocus: autofocus,
        onChanged: onChangedValue,
        onFieldSubmitted: onSubmited,
        obscureText: obscureText,
        controller: controller,
        focusNode: focusNode,
        keyboardType: textInputType ?? TextInputType.text,
        textAlign: textAlign ? TextAlign.right : TextAlign.start,
        textInputAction: textInputAction ?? TextInputAction.done,
        textCapitalization: textCapitalization,
        style: TextStyle(
          color: AppColor.black,
          fontWeight: titleTextBold ? FontWeight.bold : FontWeight.normal,
          fontSize: textSize ?? 16,
        ),
        maxLines: maxLines,
        decoration: InputDecoration(
          errorMaxLines: 3,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: contentPadding ??
              const EdgeInsets.only(
                left: 15,
                top: 0,
                right: 0,
                bottom: 0,
              ),
          fillColor: fillColor ? AppColor.grey : (bgColor ?? AppColor.whiteF9F9F9),
          focusedBorder: showBfBorder
              ? OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1.1,
              color: AppColor.greyDBDBDB,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          )
              : UnderlineInputBorder(
            borderSide: const BorderSide(
              width: 1.1,
              color: AppColor.greyDBDBDB,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: showBeBorder
              ? OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1.1,
              color: AppColor.greyDBDBDB,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          )
              : UnderlineInputBorder(
            borderSide: const BorderSide(
              width: 1.1,
              color: AppColor.greyDBDBDB,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          counterText: counterText == "" ? null : "",
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: iconButton,
          label: labelText == null
              ? const SizedBox()
              : Container(
            padding: const EdgeInsets.only(
              left: 4,
              right: 4,
              bottom: 4,
            ),
            decoration: BoxDecoration(
                color: isActive == true || controller!.text.isNotEmpty ? Colors.white : Colors.white,
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              labelText,
              style: TextStyle(
                color: labelTextColor ?? Colors.white,
                /*  backgroundColor:
                          isActive == true ? AppColor.red : AppColor.transparent,*/
                fontWeight: labelTextBold ? FontWeight.w400 : FontWeight.normal,
                fontSize: labelFontSize ?? 12,
              ),
            ),
          ),
          // labelText: labelText,
          /*labelStyle: TextStyle(
            color: labelTextColor ?? AppColor.greyText,
            backgroundColor: isActive == true ? AppColor.red : AppColor.transparent,
            fontWeight: labelTextBold ? FontWeight.w400 : FontWeight.normal,
            fontSize: labelFontSize ?? 12,
          ),*/
          hintText: hintText,
          hintStyle: hintStyle ??
              const TextStyle(
                color: AppColor.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
        // inputFormatters: inputFormatters ?? [],
        inputFormatters: //numberTextFormatter
        // ? <TextInputFormatter>[maskFormatterForNumber]
        // :
        /*upperCaseTextFormatter
                ? <TextInputFormatter>[UpperCaseTextFormatter()]
                : */
        inputFormatters ?? <TextInputFormatter>[],
        onTap: onPressed as void Function()?,
        maxLength: maxLength,
        readOnly: readyOnly,
        validator: needValidation
            ? isLoginPinValidation!
            ? (value) {
          if (value!.isEmpty) {
            return "$validationMessage is required !";
          } else if (value.trim().isEmpty) {
            return "Please Enter Confirm PIN!";
          } else if (value.length < 4) {
            return "Please enter minimum 4 character";
          } else if (preText != "") {
            if (value.trim() != preText) {
              return confirmPassValidation! ? "Enter Password is not match" : "Enter PIN is not Match";
            } else {
              return null;
            }
          } else {
            return null;
          }
        }
            : isPassWordValidation!
            ? (value) {
          if (value!.isEmpty) {
            return '$validationMessage is required !';
          } else if (value.length < 8) {
            return 'Your password is must contain atleast 8 character!';
          } else if (!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
              .hasMatch(value)) {
            return 'Your password must contain minimum 8 characters, at least one uppercase letter, one lowercase letter, one number and one special character';
          }
          return null;
        }
            : urlValidation!
            ? (value) {
          if (value!.isEmpty) {
            return '$validationMessage is required !';
          } else if (!RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+').hasMatch(value)) {
            return 'Please enter valid URL';
          }
          return null;
        }
            : specialCharacterHideValidation!
            ? (value) {
          if (value!.isEmpty) {
            return '$validationMessage is required !';
          } else if (!RegExp(r'^[\ a-zA-Z0-9]+$').hasMatch(value.trim())) {
            return "Please enter a valid name";
          }
          return null;
        }
            : onlyAlphabetValidation!
            ? (value) {
          if (value!.isEmpty) {
            return '$validationMessage is required !';
          } else if (!RegExp(r"^[A-Za-z ]+$").hasMatch(value.trim())) {
            return "Please enter a valid name";
          }
          return null;
        }
            : isEmailValidation
            ? (value) {
          if (value!.isEmpty) {
            return '$validationMessage is required !';
          } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        }
            : isPhoneValidation
            ? (value) {
          int length = withCountryCode ? /*12*/ 10 : 10;
          if (value!.length != length) {
            return 'Please Enter a Valid $length-Digit Mobile Number';
          } else if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
            return "Please enter a valid number";
          } else {
            return null;
          }
        }
            : (value) {
          if (value!.isEmpty) {
            return "$validationMessage is required !";
          } else if (value.trim().isEmpty) {
            return "Please enter a valid name!";
          } else {
            return null;
          }
        }
            : null,
      ),
    ),
  );
}
