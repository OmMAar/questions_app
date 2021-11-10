import 'package:question_answer_app/data/network/apis/user_management/user_management_api.dart';
import 'package:question_answer_app/data/sharedpref/shared_preference_helper.dart';


class UserManagementRepository {
  // data source object
  // final UserManagementDataSource _managementDataSource;

  // api objects
  final UserManagementApi _managementApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  UserManagementRepository(
      this._managementApi, this._sharedPrefsHelper,);


}
