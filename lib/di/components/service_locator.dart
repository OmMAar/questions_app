import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:question_answer_app/data/local/db/answer/answer_database.dart';
import 'package:question_answer_app/data/local/db/base/base_database.dart';
import 'package:question_answer_app/data/local/db/question/question_database.dart';
// import 'package:question_answer_app/data/local/datasources/question/question_datasource.dart';
import 'package:question_answer_app/data/network/apis/question/question_api.dart';
import 'package:question_answer_app/data/repo/question_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:question_answer_app/data/local/datasources/app/app_datasource.dart';
// import 'package:question_answer_app/data/local/datasources/home/home_datasource.dart';
// import 'package:question_answer_app/data/local/datasources/user/user_datasource.dart';
// import 'package:question_answer_app/data/local/datasources/user_management/user_management_datasource.dart';
import 'package:question_answer_app/data/network/apis/app/app_api.dart';
import 'package:question_answer_app/data/network/apis/home/home_api.dart';
import 'package:question_answer_app/data/network/apis/user/user_api.dart';
import 'package:question_answer_app/data/network/apis/user_management/user_management_api.dart';
import 'package:question_answer_app/data/network/dio_client.dart';
import 'package:question_answer_app/data/network/rest_client.dart';
import 'package:question_answer_app/data/repo/home_repository.dart';
import 'package:question_answer_app/data/repo/repository.dart';
import 'package:question_answer_app/data/repo/user_management_repository.dart';
import 'package:question_answer_app/data/repo/user_repository.dart';
import 'package:question_answer_app/data/sharedpref/shared_preference_helper.dart';
import 'package:question_answer_app/di/module/local_module.dart';
import 'package:question_answer_app/di/module/network_module.dart';
import 'package:question_answer_app/stores/error/error_store.dart';
import 'package:question_answer_app/stores/form/form_store.dart';
import 'package:question_answer_app/stores/language/language_store.dart';
import 'package:question_answer_app/stores/theme/theme_store.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  getIt.registerFactory(() => FormStore());
  getIt.registerFactory(() => BaseDatabase());
  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------

  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(AppApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(HomeApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(UserManagementApi(getIt<DioClient>()));
  getIt.registerSingleton(UserApi(getIt<DioClient>()));
  getIt.registerSingleton(QuestionApi(getIt<DioClient>()));

  // data sources
  getIt.registerSingleton(QuestionDatabase( getIt.get<BaseDatabase>()));
  getIt.registerSingleton(AnswerDatabase( getIt.get<BaseDatabase>()));
  // data sources
  // getIt.registerSingleton(AppDataSource(await getIt.getAsync<Database>()));
  // getIt.registerSingleton(HomeDataSource(await getIt.getAsync<Database>()));
  // getIt.registerSingleton(UserManagementDataSource(await getIt.getAsync<Database>()));
  // getIt.registerSingleton(UserDataSource(await getIt.getAsync<Database>()));
  // getIt.registerSingleton(QuestionDataSource(await getIt.getAsync<Database>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<AppApi>(),
    getIt<SharedPreferenceHelper>(),
    // getIt<AppDataSource>(),
  ));

  getIt.registerSingleton(UserManagementRepository(
    getIt<UserManagementApi>(),
    getIt<SharedPreferenceHelper>(),
    // getIt<UserManagementDataSource>(),
  ));


  getIt.registerSingleton(UserRepository(
    getIt<UserApi>(),
    getIt<SharedPreferenceHelper>(),
    // getIt<UserDataSource>(),
  ));

  getIt.registerSingleton(HomeRepository(
    getIt<HomeApi>(),
    getIt<SharedPreferenceHelper>(),
    // getIt<HomeDataSource>(),
  ));
  getIt.registerSingleton(QuestionRepository(
    getIt<QuestionApi>(),
    getIt<SharedPreferenceHelper>(),
    getIt<QuestionDatabase>(),
    getIt<AnswerDatabase>(),
  ));


  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
}
