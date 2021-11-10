import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:question_answer_app/constants/strings.dart';

@immutable
abstract class ApplicationEvent extends Equatable {}

abstract class SetApplicationLanguageEvent extends ApplicationEvent {
  final String language;

  SetApplicationLanguageEvent(this.language);

  @override
  String toString() => 'SetApplicationLanguageEvent { language: $language }';

  @override
  List<Object> get props => [language];
}

class SetArabicLanguageEvent extends SetApplicationLanguageEvent {
  SetArabicLanguageEvent() : super(Strings.LANG_AR);
}

class SetEnglishLanguageEvent extends SetApplicationLanguageEvent {
  SetEnglishLanguageEvent() : super(Strings.LANG_EN);
}

class UserLogoutEvent extends ApplicationEvent {
  @override
  String toString() => 'UserLogoutEvent';

  @override
  List<Object> get props => [];
}

class SetUserInfoEvent extends ApplicationEvent {

  @override
  String toString() => 'SetUserInfoEvent';

  @override
  List<Object> get props => [];
}

