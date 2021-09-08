import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:simple_twitter/app/misc/constants.dart';

class FailDialog extends StatelessWidget {
  final String title;
  final String content;
  final String onConfirmText;
  final VoidCallback onConfirm;

  const FailDialog(
      {Key key, this.title, this.content, this.onConfirmText, this.onConfirm})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double scaleWidth = MediaQuery.of(context).size.width / 360;
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 260 * scaleWidth,
        height: 300 * scaleWidth,
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 40 * scaleWidth,
              left: 0,
              child: Container(
                width: 260 * scaleWidth,
                height: 260 * scaleWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 55 * scaleWidth,
                      left: 0 * scaleWidth,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            24 * scaleWidth, 0, 24 * scaleWidth, 0),
                        width: 260 * scaleWidth,
                        height: 50 * scaleWidth,
                        // color: Colors.green,
                        child: AutoSizeText(
                          title ?? "",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: AppConstants.COLOR_GREYED_TEXT),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 85 * scaleWidth,
                      left: 0 * scaleWidth,
                      // right: 30 * scaleWidth,
                      child: Container(
                        width: 260 * scaleWidth,
                        height: 120 * scaleWidth,
                        padding: EdgeInsets.fromLTRB(
                            24 * scaleWidth, 0, 24 * scaleWidth, 0),
                        alignment: Alignment.center,
                        child: ListView(
                          children: <Widget>[
                            AutoSizeText(
                              content ?? "",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppConstants.COLOR_GREYED_TEXT),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 220 * scaleWidth,
                      right: 30 * scaleWidth,
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            onConfirm();
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            height: 30 * scaleWidth,
                            width: 90 * scaleWidth,
                            child: AutoSizeText(
                              onConfirmText ?? "",
                              maxFontSize: 16,
                              minFontSize: 8,
                              style: TextStyle(
                                color: AppConstants.COLOR_PRIMARY_COLOR,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0 * scaleWidth,
              left: 0 * scaleWidth,
              child: Container(
                width: 260 * scaleWidth,
                height: 80 * scaleWidth,
                alignment: Alignment.center,
                child: Center(
                  child: Image(
                    image: AssetImage(
                        'lib/app/ui/assets/icons/icon_event_fail.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
