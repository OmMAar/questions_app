
import 'package:dio/dio.dart';
import 'package:question_answer_app/data/network/constants/endpoints.dart';
import 'package:question_answer_app/data/network/dio_client.dart';
import 'package:question_answer_app/models/questions/answer_info_response_model.dart';
import 'package:question_answer_app/models/questions/question_info_response_model.dart';
import 'package:question_answer_app/models/user/user_info_response_model.dart';


class QuestionApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  QuestionApi(this._dioClient);
  Future<QuestionInfoResponseModel> geQuestionListWithPaged(
      {required Map<String, dynamic> queryParameters,
        required CancelToken cancelToken}) async {
    try {
      final res = await _dioClient.get(Endpoints.questionList,
          queryParameters: queryParameters, cancelToken: cancelToken);
      return QuestionInfoResponseModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  Future<AnswerInfoResponseModel> getAnswerListWithPaged(
      {required Map<String, dynamic> queryParameters,
        required int questionId,
        required CancelToken cancelToken}) async {
    try {
      final res = await _dioClient.get(Endpoints.questionList+"/$questionId/answers",
          queryParameters: queryParameters, cancelToken: cancelToken);
      return AnswerInfoResponseModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
