import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:question_answer_app/common/widgets/unexpected_err.dart';
import 'package:question_answer_app/data/app_server_constants.dart';
import 'package:question_answer_app/data/repo/question_repository.dart';
import 'package:question_answer_app/di/components/service_locator.dart';
import 'package:question_answer_app/models/questions/question_item_model.dart';
import 'package:question_answer_app/utils/database/database_error_util.dart';
import 'package:question_answer_app/utils/dio/dio_error_util.dart';
import 'package:question_answer_app/utils/dio/errors/base_error.dart';
import 'package:question_answer_app/utils/dio/errors/unknown_error.dart';
import 'package:sqflite/sqflite.dart';

abstract class GetQuestionListState extends Equatable {}

class GetQuestionListUninitialized extends GetQuestionListState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetQuestionListUninitialized';
}

class GetQuestionListLoading extends GetQuestionListState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetQuestionListLoading';
}

class GetQuestionListSuccess extends GetQuestionListState {
  final List<QuestionItemModel> questions;
  final bool noMoreData;

  GetQuestionListSuccess({required this.questions, this.noMoreData = false});

  @override
  List<Object> get props => [questions];

  @override
  String toString() => 'GetQuestionListSuccess data :${questions.length}';
}

class GetQuestionListEmpty extends GetQuestionListState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetQuestionListEmpty';
}

class GetQuestionListFailure extends GetQuestionListState {
  final String error;
  final VoidCallback? callback;

  GetQuestionListFailure({
    required this.error,
    this.callback,
  });

  @override
  List<Object> get props => [error, callback!];

  @override
  String toString() => 'GetQuestionListFailure { error: $error }';
}

class GetQuestionListEvent extends Equatable {
  final bool loadMore;
  final CancelToken cancelToken;



  GetQuestionListEvent(
      {this.loadMore = false,
      required this.cancelToken,});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetQuestionListEvent loadMore $loadMore';
}

class GetQuestionListBloc
    extends Bloc<GetQuestionListEvent, GetQuestionListState> {
  List<QuestionItemModel> questions = [];
  int page = 1;


  GetQuestionListBloc() : super(GetQuestionListUninitialized());

  @override
  Stream<GetQuestionListState> mapEventToState(
      GetQuestionListEvent event) async* {
    // repository instance
    QuestionRepository _repository = getIt<QuestionRepository>();

    try {
      if (event.loadMore) {
        this.page++;
        print('event.loadMore');
      } else {
        page = 1;
        yield GetQuestionListLoading();
      }

      Map<String, dynamic> queryParameters = {};
      queryParameters.putIfAbsent('order', () => "desc");
      queryParameters.putIfAbsent('sort', () => "activity");
      queryParameters.putIfAbsent('site', () => "stackoverflow");
      queryParameters.putIfAbsent('page', () => page);
      queryParameters.putIfAbsent('pagesize', () => AppServerConstants.PAGE_SIZE);


      final result = await _repository.geQuestionListWithPaged(
          queryParameters: queryParameters, cancelToken: event.cancelToken,page:page,pageSize: AppServerConstants.PAGE_SIZE  );

      if (result.items != null && result.items!.isNotEmpty) {
        if (event.loadMore) {
          List<QuestionItemModel> questionListTemp = List.from(this.questions);
          questionListTemp.addAll(result.items!);
          await Future.delayed(Duration(seconds: 3), () {});
          this.questions = questionListTemp;
        } else {
          await Future.delayed(Duration(seconds: 1), () {});
          this.questions = result.items!;
        }
        yield GetQuestionListSuccess(questions: this.questions);
      }
      else {
        if (event.loadMore) {
          page--;
        }

        if(result.items!.isEmpty&&this.questions.isEmpty){

          yield GetQuestionListEmpty();

        }else{
          print("bloc is here empty one");
    yield GetQuestionListSuccess(questions: this.questions,noMoreData: true);
        }

      }
    } catch (err) {
      if(err is DioError){
        yield GetQuestionListFailure(
          error: DioErrorUtil.handleError(err),
          callback: () {
            this.add(event);
          },
        );
      }else if(err is DatabaseException){
        yield GetQuestionListFailure(
          error: DataBaseErrorUtil.handleError(err),
          callback: () {
            this.add(event);
          },
        );
      }else {
        yield GetQuestionListFailure(
          error: err.toString(),
          callback: () {
            this.add(event);
          },
        );
      }
      // print('Caught error: $err');
      // yield GetQuestionListFailure(
      //   error: DioErrorUtil.handleError(err),
      //   callback: () {
      //     this.add(event);
      //   },
      // );
    }
  }
}
