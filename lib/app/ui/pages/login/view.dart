import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:simple_twitter/app/infrastructures/app_component.dart';
import 'package:simple_twitter/app/ui/pages/login/controller.dart';
import 'package:simple_twitter/app/ui/res/generated/i18n.dart';
import 'package:simple_twitter/app/ui/widgets/common_text_input.dart';
import 'package:simple_twitter/app/ui/widgets/loading.dart';

class LoginPage extends View {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState(
      AppComponent.getInjector().getDependency<AuthController>());
}

class _LoginPageState extends ViewState<LoginPage, AuthController>
    with WidgetsBindingObserver {
  _LoginPageState(AuthController controller) : super(controller);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget buildPage() {
    double scaleWidth = MediaQuery.of(context).size.width / 360;
    return new Scaffold(
      key: globalKey,
      body: ListView(
        shrinkWrap: true,
        reverse: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.accessibility_new_rounded,
                        size: 40,
                        color: Colors.green[400],
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 150 * scaleWidth,
                        child: AutoSizeText(
                          "Twitter-an",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  CommonTextInput(
                    elevation: 0,
                    isPassword: false,
                    isDense: true,
                    isError: false,
                    isFilled: controller.isUsernameFilled,
                    controller: controller.userNameInput,
                    placeholder: S.of(context).username,
                    helperText: "Email can't be empty",
                    helperStyle: TextStyle(color: Colors.red),
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person_outline,
                          size: 25,
                        )),
                  ),
                  //SizedBox(height: 20),
                  CommonTextInput(
                    isPassword: true,
                    isDense: true,
                    isFilled: controller.isPasswordFilled,
                    textObscured: controller.isObscured,
                    onVisibilityPressed: () {
                      controller.toggleVisibility();
                    },
                    isError: false,
                    controller: controller.passwordInput,
                    placeholder: S.of(context).password,
                    helperText: "Password can't be empty",
                    helperStyle: TextStyle(color: Colors.red),
                    elevation: 0,
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.vpn_key,
                          size: 25,
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        controller.validateLogin();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: Container(
                        alignment: Alignment.center,
                        height: 35 * scaleWidth,
                        width: 250 * scaleWidth,
                        child: AutoSizeText(
                          "LOGIN",
                          style: TextStyle(fontSize: 24),
                        ),
                      )),
                  TextButton(
                      onPressed: () {
                        controller.validateSignUp();
                      
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: Container(
                        alignment: Alignment.center,
                        height: 35 * scaleWidth,
                        width: 250 * scaleWidth,
                        child: AutoSizeText(
                          "Sign Up",
                          style: TextStyle(fontSize: 16,
                          color: Colors.green),
                        ),
                      ))
                ],
              ),
              controller.isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withOpacity(0.2),
                      child: Center(child: CommonLoading()))
                  : Center()
            ],
          )
        ],
      ),
    );
  }

}
