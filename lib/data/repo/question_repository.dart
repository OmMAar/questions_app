import 'dart:async';
import 'package:dio/dio.dart';
import 'package:question_answer_app/data/local/db/answer/answer_database.dart';
import 'package:question_answer_app/data/local/db/question/question_database.dart';

import 'package:question_answer_app/data/network/apis/question/question_api.dart';
import 'package:question_answer_app/data/sharedpref/shared_preference_helper.dart';
import 'package:question_answer_app/models/questions/answer_info_response_model.dart';
import 'package:question_answer_app/models/questions/answer_item_model.dart';
import 'package:question_answer_app/models/questions/question_info_response_model.dart';
import 'package:question_answer_app/models/questions/question_item_model.dart';

class QuestionRepository {
  // data source object
   final QuestionDatabase _questionDatabase;
   final AnswerDatabase _answerDatabase;

  // api objects
  final QuestionApi _questionApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  QuestionRepository(this._questionApi, this._sharedPrefsHelper,this._questionDatabase,this._answerDatabase);

  // Future<QuestionInfoResponseModel> geQuestionListWithPaged(
  //     {required Map<String, dynamic> queryParameters,required CancelToken cancelToken}) async {
  //
  //   var _result = await _questionApi.geQuestionListWithPaged(
  //       queryParameters: queryParameters,cancelToken: cancelToken);
  //   // if(_result.items!=null && _result.items!.isNotEmpty){
  //   //   for(QuestionItemModel q in _result.items!){
  //   //    await _questionDataSource.insert(q);
  //   //   }
  //   // }
  //   return _result;
  // }

   Future<QuestionInfoResponseModel> geQuestionListWithPaged(
       {required int page, required int pageSize,required Map<String, dynamic> queryParameters,required CancelToken cancelToken}) async {
     List<QuestionItemModel> result = [];

     int? dataBaseCount = await _questionDatabase.getCount();
     print("database count :$dataBaseCount");
     if (dataBaseCount != null && dataBaseCount < (pageSize * page)) {
       var _weatherInfo =  await _questionApi.geQuestionListWithPaged(
           queryParameters: queryParameters,cancelToken: cancelToken);
       if (_weatherInfo.items != null && _weatherInfo.items!.isNotEmpty) {
         for (QuestionItemModel e in _weatherInfo.items!) {
           await _questionDatabase.create(e);
         }
         print("==================================");
         print("result from api");
         print("==================================");
         result = _weatherInfo.items ?? [];
       }
     } else {
       print("==================================");
       print("result from database");
       print("==================================");
       result =
           await _questionDatabase.getPagingItems(page: page, pageSize: pageSize) ??
               [];
       print("==================================");
       print("result getPagingItems length :  ${result.length}");
       print("==================================");
     }
     // _weatherInfo.hits!.map((e) async{
     //   await  _itemDatabase.create(e);
     // });

     return QuestionInfoResponseModel(items: result);
   }



  // Future<AnswerInfoResponseModel> getAnswerListWithPaged(
  //     {required Map<String, dynamic> queryParameters,required int questionId,required CancelToken cancelToken}) async {
  //   var _result = await _questionApi.getAnswerListWithPaged(
  //       queryParameters: queryParameters,questionId:questionId,cancelToken: cancelToken);
  //   return _result;
  // }

   Future<AnswerInfoResponseModel> getAnswerListWithPaged(
       {required int page, required int pageSize,required int questionId,required Map<String, dynamic> queryParameters,required CancelToken cancelToken}) async {
     List<AnswerItemModel> result = [];

     int? dataBaseCount = await _answerDatabase.getCount(questionId);
     print("database count :$dataBaseCount");
     if (dataBaseCount != null && dataBaseCount == 0) {
       var _weatherInfo =  await _questionApi.getAnswerListWithPaged(
           queryParameters: queryParameters,cancelToken: cancelToken,questionId: questionId);
       if (_weatherInfo.items != null && _weatherInfo.items!.isNotEmpty) {
         for (AnswerItemModel e in _weatherInfo.items!) {
           await _answerDatabase.create(e);
         }
         print("==================================");
         print("result from api");
         print("==================================");
         result = _weatherInfo.items ?? [];
       }
     } else {
       print("==================================");
       print("result from database");
       print("==================================");
       result =
           await _answerDatabase.getPagingItems(page: page, pageSize: pageSize,questionId: questionId) ??
               [];
       print("==================================");
       print("result getPagingItems length :  ${result.length}");
       print("==================================");
     }
     // _weatherInfo.hits!.map((e) async{
     //   await  _itemDatabase.create(e);
     // });

     return AnswerInfoResponseModel(items: result);
   }

   // Theme: -----------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}