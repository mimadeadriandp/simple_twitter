import 'package:flutter/material.dart';
import 'package:simple_twitter/app/misc/constants.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final dynamic buttonText;
  final Color buttonTextColor;
  final Color buttonColor;
  final bool isDisabled, isAutoFocus;
  final double minWidth, height, fontSize, borderRadius;
  final FontWeight buttonTextWeight;
  final Color borderColor;
  final EdgeInsetsGeometry outerPadding;
  final double elevation;

  const CommonButton(
      {Key key,
      this.onPressed,
      @required this.buttonText,
      this.borderColor = Colors.transparent,
      this.isDisabled = false,
      this.isAutoFocus = false,
      this.minWidth = 88.0,
      this.height = 48.0,
      this.borderRadius = 30,
      this.outerPadding = const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
      this.fontSize = 14.0,
      this.buttonColor = AppConstants.COLOR_PRIMARY_COLOR,
      this.buttonTextColor = AppConstants.COLOR_WHITE,
      this.elevation,
      this.buttonTextWeight = FontWeight.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: outerPadding,
      child: ButtonTheme(
        minWidth: minWidth,
        height: height,
        child: ElevatedButton(
          autofocus: isAutoFocus,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(elevation),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: borderColor),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return AppConstants.COLOR_DISABLED_BUTTON.withOpacity(0.7);
                return buttonColor; // Use the component's default.
              },
            ),
          ),
          onPressed: isDisabled ? null : onPressed,
          child: buttonText is String
              ? Text(buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: buttonTextColor == null
                          ? AppConstants.COLOR_WHITE
                          : buttonTextColor,
                      fontWeight: buttonTextWeight,
                      fontFamily: 'MMC'))
              : buttonText,
        ),
      ),
    );
  }
}

