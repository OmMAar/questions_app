import 'package:question_answer_app/data/network/dio_client.dart';
import 'package:question_answer_app/data/network/rest_client.dart';


class HomeApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  HomeApi(this._dioClient, this._restClient);


}
