import 'package:flutter/material.dart';
import 'package:question_answer_app/constants/app_constants.dart';
import 'package:question_answer_app/constants/text_style.dart';
import 'package:question_answer_app/constants/colors.dart';
import 'package:question_answer_app/utils/locale/app_localization.dart';

class NetworkError extends StatelessWidget {
  final VoidCallback onPressed;

  const NetworkError({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   AppAssets.connectionError,
              //   width: 240,
              //   height: 240,
              // ),
              Text(
                AppLocalizations.of(context).translate('connection_err'),
                style: appTextStyle.smallTSBasic,
                textAlign: TextAlign.center,
              ),
              FlatButton(
                onPressed: onPressed,
                child: Text(
                  AppLocalizations.of(context).translate('retry'),
                  style: appTextStyle.smallTSBasic
                      .copyWith(color: AppColors.white),
                ),
                color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppRadius.radius6),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
