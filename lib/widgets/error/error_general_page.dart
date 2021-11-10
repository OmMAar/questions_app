import 'package:question_answer_app/common/widgets/network_err.dart';
import 'package:question_answer_app/common/widgets/unexpected_err.dart';
import 'package:question_answer_app/constants/app_constants.dart';
import 'package:question_answer_app/utils/dio/errors/base_error.dart';
import 'package:flutter/material.dart';
import 'package:question_answer_app/utils/dio/errors/connection_error.dart';

class ErrorGeneralPage extends StatelessWidget {
  final BaseError error;
  final VoidCallback? callback;

  const ErrorGeneralPage({required this.error,this.callback});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBGColor,
      body: Center(
          child: error is ConnectionError
              ? NetworkError(
              onPressed: callback??(){})
              : UnexpectedError(
              onPressed: callback??(){})),
    );
  }
}
