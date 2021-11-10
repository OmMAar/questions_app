import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:question_answer_app/data/app_server_constants.dart';
import 'package:question_answer_app/data/repo/question_repository.dart';
import 'package:question_answer_app/di/components/service_locator.dart';
import 'package:question_answer_app/models/questions/answer_item_model.dart';
import 'package:question_answer_app/models/questions/question_item_model.dart';
import 'package:question_answer_app/utils/database/database_error_util.dart';
import 'package:question_answer_app/utils/dio/dio_error_util.dart';
import 'package:question_answer_app/utils/dio/errors/base_error.dart';
import 'package:sqflite/sqflite.dart';

abstract class GetQuestionAnswerListState extends Equatable {}

class GetQuestionAnswerListUninitialized extends GetQuestionAnswerListState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetQuestionAnswerListUninitialized';
}

class GetQuestionAnswerListLoading extends GetQuestionAnswerListState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetQuestionAnswerListLoading';
}

class GetQuestionAnswerListSuccess extends GetQuestionAnswerListState {
  final List<AnswerItemModel> answers;
  final bool noMoreData;

  GetQuestionAnswerListSuccess({required this.answers, this.noMoreData = false});

  @override
  List<Object> get props => [answers];

  @override
  String toString() => 'GetQuestionAnswerListSuccess data :${answers.length}';
}

class GetQuestionAnswerListEmpty extends GetQuestionAnswerListState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetQuestionAnswerListEmpty';
}

class GetQuestionAnswerListFailure extends GetQuestionAnswerListState {
  final String error;
  final VoidCallback? callback;

  GetQuestionAnswerListFailure({
    required this.error,
    this.callback,
  });

  @override
  List<Object> get props => [error, callback!];

  @override
  String toString() => 'GetQuestionAnswerListFailure { error: $error }';
}

class GetQuestionAnswerListEvent extends Equatable {
  final bool loadMore;
  final int questionId;
  final CancelToken cancelToken;



  GetQuestionAnswerListEvent(
      {this.loadMore = false,
        required this.questionId,
      required this.cancelToken,});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetQuestionAnswerListEvent loadMore $loadMore';
}

class GetQuestionAnswerListBloc
    extends Bloc<GetQuestionAnswerListEvent, GetQuestionAnswerListState> {
  List<AnswerItemModel> answers = [];
  int page = 1;


  GetQuestionAnswerListBloc() : super(GetQuestionAnswerListUninitialized());

  @override
  Stream<GetQuestionAnswerListState> mapEventToState(
      GetQuestionAnswerListEvent event) async* {
    // repository instance
    QuestionRepository _repository = getIt<QuestionRepository>();

    try {
      if (event.loadMore) {
        this.page++;
        print('event.loadMore');
      } else {
        page = 1;
        yield GetQuestionAnswerListLoading();
      }

      Map<String, dynamic> queryParameters = {};
      queryParameters.putIfAbsent('order', () => "desc");
      queryParameters.putIfAbsent('sort', () => "activity");
      queryParameters.putIfAbsent('site', () => "stackoverflow");
      queryParameters.putIfAbsent('page', () => page);
      queryParameters.putIfAbsent('pagesize', () => AppServerConstants.PAGE_SIZE);
      queryParameters.putIfAbsent('pagesize', () => AppServerConstants.PAGE_SIZE);

      final result = await _repository.getAnswerListWithPaged(
          queryParameters: queryParameters,questionId: event.questionId, cancelToken: event.cancelToken,page:page,pageSize: AppServerConstants.PAGE_SIZE );

      if (result.items != null && result.items!.isNotEmpty) {
        if (event.loadMore) {
          List<AnswerItemModel> answerListTemp = List.from(this.answers);
          answerListTemp.addAll(result.items!);
          await Future.delayed(Duration(seconds: 3), () {});
          this.answers = answerListTemp;
        } else {
          await Future.delayed(Duration(seconds: 1), () {});
          this.answers = result.items!;
        }
        yield GetQuestionAnswerListSuccess(answers: this.answers);
      }
      else {
        if (event.loadMore) {
          page--;
        }

        if(result.items!.isEmpty&&this.answers.isEmpty){

          yield GetQuestionAnswerListEmpty();

        }else{
          print("bloc is here empty one");
    yield GetQuestionAnswerListSuccess(answers: this.answers,noMoreData: true);
        }

      }
    } catch (err) {
      if(err is DioError){
        yield GetQuestionAnswerListFailure(
          error: DioErrorUtil.handleError(err),
          callback: () {
            this.add(event);
          },
        );
      }else if(err is DatabaseException){
        yield GetQuestionAnswerListFailure(
          error: DataBaseErrorUtil.handleError(err),
          callback: () {
            this.add(event);
          },
        );
      }else {
        yield GetQuestionAnswerListFailure(
          error: err.toString(),
          callback: () {
            this.add(event);
          },
        );
      }
      // print('Caught error: $err');
      // yield GetQuestionAnswerListFailure(
      //   error: DioErrorUtil.handleError(err),
      //   callback: () {
      //     this.add(event);
      //   },
      // );
    }
  }
}
