import 'package:flutter/material.dart';
import 'package:question_answer_app/utils/locale/app_localization.dart';

import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  bool? isFromVerificationPage;

  RequiredValidator({this.isFromVerificationPage});

  @override
  String getMessage(BuildContext? context) {
    if (isFromVerificationPage != null && isFromVerificationPage!) return '*';
    return AppLocalizations.of(context!).translate('v_required');
  }

  @override
  bool validate(String value) {
    return value != null && value.isNotEmpty;
  }
}
