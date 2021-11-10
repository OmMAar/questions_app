
import 'package:dio/dio.dart';
import 'package:question_answer_app/data/network/constants/endpoints.dart';
import 'package:question_answer_app/data/network/dio_client.dart';
import 'package:question_answer_app/models/user/user_info_response_model.dart';


class UserApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  UserApi(this._dioClient);
  Future<UserInfoResponseModel> getUserListWithPaged(
      {required Map<String, dynamic> queryParameters,
        required CancelToken cancelToken}) async {
    try {
      final res = await _dioClient.get(Endpoints.userList,
          queryParameters: queryParameters, cancelToken: cancelToken);
      return UserInfoResponseModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
