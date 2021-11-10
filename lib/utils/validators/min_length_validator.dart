import 'package:flutter/material.dart';
import 'package:question_answer_app/utils/locale/app_localization.dart';
import 'base_validator.dart';

class MinLengthValidator extends BaseValidator {
  final int minLength;

  MinLengthValidator({required this.minLength, this.isFromVerificationPage});

  bool? isFromVerificationPage;

  @override
  String getMessage(BuildContext? context) {
    if (isFromVerificationPage != null && isFromVerificationPage!) return '*';
    return '${AppLocalizations.of(context!).translate('v_min_length_1')} '
        '$minLength '
        '${AppLocalizations.of(context).translate('v_min_length_2')}';
  }

  @override
  bool validate(String value) {
    return value.length >= minLength;
  }
}
