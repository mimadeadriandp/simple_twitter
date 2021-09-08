import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_twitter/app/misc/constants.dart';

class CommonTextInput extends StatelessWidget {
  final TextStyle textStyle, textInputStyle, helperStyle;
  final bool isError, isDense, isFilled;
  final String errorText, helperText;
  final TextEditingController _controller;
  final FormFieldValidator<String> validator;
  final String placeholder;
  final bool isPassword;
  final double elevation;
  final Widget prefixIcon, suffixIcon;
  final bool textObscured;
  final Function onVisibilityPressed;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry outerPadding, innerPadding;
  final String labelText;
  final String initialValue;
  final bool isEnable;
  final String dropDownValue;

  const CommonTextInput(
      {Key key,
      @required TextEditingController controller,
      this.textStyle,
      this.textInputStyle,
      this.helperStyle,
      this.helperText,
      this.onVisibilityPressed,
      this.keyboardType,
      this.innerPadding = const EdgeInsets.symmetric(vertical: 15),
      this.textObscured = true,
      this.isError = false,
      this.isFilled = true,
      this.errorText,
      this.validator,
      this.initialValue,
      this.isDense = false,
      this.elevation = 4.0,
      this.outerPadding = const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
      this.prefixIcon = const Icon(Icons.person),
      this.suffixIcon = const Icon(
        Icons.error_outline,
        size: 40,
        color: Color.fromRGBO(255, 0, 0, 1.0),
      ),
      this.placeholder,
      this.labelText,
      this.isEnable = true,
      this.dropDownValue = "Private",
      this.isPassword = false})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        key: key,
        padding: outerPadding,
        child: Column(
          children: <Widget>[
            Material(
              elevation: elevation,
              shadowColor: AppConstants.COLOR_BLACK,
              borderRadius: BorderRadius.circular(10.0),
              child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(150),
                ],
                enabled: isEnable,
                initialValue: initialValue,

                // initialValue: initialValue,
                controller: _controller,
                keyboardType: keyboardType,
                obscureText: _showPassword(),
                validator: validator,
                style: textInputStyle,
                decoration: new InputDecoration(
                    labelText: labelText,
                    hintText: placeholder,
                    hintStyle: textStyle,
                    helperText: isFilled ? "" : helperText,
                    helperStyle: isFilled ? null : helperStyle,
                    isDense: isDense,
                    prefixIcon: prefixIcon,
                    contentPadding: innerPadding,
                    suffix: isError && isPassword
                        ? Icon(
                            Icons.error_outline,
                            size: 25,
                            color: Color.fromRGBO(255, 0, 0, 1.0),
                          )
                        : null,
                    suffixIcon: _suffixIcon(),
                    fillColor: isEnable
                        ? Color.fromRGBO(250, 250, 250, 1.0)
                        : AppConstants.COLOR_DISABLED_BUTTON,
                    // fillColor: Colors.black38,
                    filled: true,
                    focusedBorder: new UnderlineInputBorder(
                        // borderRadius: BorderRadius.circular(10.0),
                        borderSide: new BorderSide(
                            color: isError
                                ? AppConstants.COLOR_RED
                                : AppConstants.COLOR_PRIMARY_COLOR,
                            width: 3.0)),
                    disabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black38)),
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: isFilled
                                ? Colors.black38
                                : AppConstants.COLOR_RED,
                            width: 1.0))),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                child: isError
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            isError ? errorText : '',
                            style: TextStyle(
                                color: AppConstants.COLOR_RED,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.000005)),
          ],
        ));
  }

  Widget _suffixIcon() {
    if (isPassword) {
      return IconButton(
        onPressed: isPassword ? onVisibilityPressed : null,
        icon: textObscured
            ? Icon(
                Icons.visibility_off
              )
            : Icon(
                Icons.visibility,
              ),
      );
    }
    return isError ? suffixIcon : null;
  }

  bool _showPassword() {
    if (isPassword) {
      return textObscured;
    }
    return false;
  }
}
