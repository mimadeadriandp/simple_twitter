import 'package:flutter/material.dart';
import 'package:simple_twitter/app/misc/constants.dart';

class CommonLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.white,
      valueColor:
          new AlwaysStoppedAnimation<Color>(AppConstants.COLOR_PRIMARY_COLOR),
    );
  }
}

