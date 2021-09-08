import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_twitter/app/infrastructures/contracts/base_controller.dart';
import 'package:simple_twitter/app/infrastructures/event/error.dart';
import 'package:simple_twitter/app/ui/pages/pages.dart';

class AuthController extends BaseController {

  bool _isErrorUserName = false, _isObscured = true;

  TextEditingController _userNameInput = new TextEditingController();
  TextEditingController _passwordInput = new TextEditingController();

  bool isUsernameFilled = true;
  bool isPasswordFilled = true;

  bool isDisposed = false;

  TextEditingController get userNameInput => _userNameInput;
  TextEditingController get passwordInput => _passwordInput;
  bool get isErrorUserName => _isErrorUserName;
  bool get isObscured => _isObscured;


  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthController() : super() {
    _passwordInput.addListener(_onPasswordInputChange);
    _userNameInput.addListener(_onUsernameInputChange);
  }

  @override
  void initListeners() async {
    super.initListeners();
  }

  Future<String> login({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("SUKSES SIGN IIIN");
      goToHomePage();
      return "Signed In";
    } on FirebaseAuthException catch (e) {
        eventBus.fire(ErrorEvent(
          title: "Login Failed",
          content: e.message,
          confirmText: "OK",
          onConfirm: () {
            dismissLoading();
            Navigator.of(getContext(), rootNavigator: true).pop();
            // Navigator.pop(getContext());
          }));
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("SIGNUP SUKSES");
      goToHomePage();
      return "Signed Up SUKSES";
    } on FirebaseAuthException catch (e) {
      eventBus.fire(ErrorEvent(
          title: "Login Failed",
          content: e.message,
          confirmText: "OK",
          onConfirm: () {
            dismissLoading();
            Navigator.of(getContext(), rootNavigator: true).pop();
          }));

      return e.message;
    }
  }


  void validateLogin() {
    if (userNameInput.text == "" && passwordInput.text != "") {
      isUsernameFilled = false;
    } else if (userNameInput.text != "" && passwordInput.text == "") {
      isPasswordFilled = false;
    } else if (userNameInput.text == "" && passwordInput.text == "") {
      isUsernameFilled = false;
      isPasswordFilled = false;
    } else {
      if (super.internetAvailable) {
        submitLogin();
      } else if (!isDisposed) {
        super.eventBus.fire(ErrorEvent(
            title: "No Internet Connection",
            content:
                "Check your internet connection, turn on mobile data or switch wifi.",
            confirmText: "OK",
            onConfirm: () {
              dismissLoading();
              Navigator.of(getContext(), rootNavigator: true).pop();
            }));
      }
    }
    refreshUI();
  }
  void validateSignUp() {
    if (userNameInput.text == "" && passwordInput.text != "") {
      isUsernameFilled = false;
    } else if (userNameInput.text != "" && passwordInput.text == "") {
      isPasswordFilled = false;
    } else if (userNameInput.text == "" && passwordInput.text == "") {
      isUsernameFilled = false;
      isPasswordFilled = false;
    } else {
      if (super.internetAvailable) {
        submitSignUp();
      } else if (!isDisposed) {
        super.eventBus.fire(ErrorEvent(
            title: "No Internet Connection",
            content:
                "Check your internet connection, turn on mobile data or switch wifi.",
            confirmText: "OK",
            onConfirm: () {
              dismissLoading();
              Navigator.of(getContext(), rootNavigator: true).pop();
            }));
      }
    }
    refreshUI();
  }

  void submitLogin() {
    showLoading();
    login(email: userNameInput.text, password: passwordInput.text);
  }
  void submitSignUp(){
    showLoading();
    signUp(email: userNameInput.text, password: passwordInput.text);
  }

  void goToHomePage() {
    Navigator.pushReplacementNamed(getContext(), Pages.home);
    dismissLoading();
    refreshUI();
  }


  void _onUsernameInputChange() {
    if (userNameInput.text != "") {
      isUsernameFilled = true;
      refreshUI();
    }
  }

  void _onPasswordInputChange() {
    if (passwordInput.text != "") {
      isPasswordFilled = true;
      refreshUI();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  void toggleVisibility() {
    _isObscured = !_isObscured;
    refreshUI();
  }
}

class ErrorMessage {
  String userId = '';
  bool isValid() {
    return userId.isEmpty ? true : false;
  }
}
