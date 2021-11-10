// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
// import 'package:question_answer_app/data/app_server_constants.dart';
// import 'package:question_answer_app/data/repo/user_repository.dart';
// import 'package:question_answer_app/di/components/service_locator.dart';
// import 'package:question_answer_app/models/user/user_model.dart';
// import 'package:question_answer_app/utils/args/user_filter_args.dart';
// import 'package:question_answer_app/utils/dio/dio_error_util.dart';
// import 'package:question_answer_app/utils/dio/errors/base_error.dart';
//
// abstract class GetUserListState extends Equatable {}
//
// class GetUserListUninitialized extends GetUserListState {
//   @override
//   List<Object> get props => [];
//
//   @override
//   String toString() => 'GetUserListUninitialized';
// }
//
// class GetUserListLoading extends GetUserListState {
//   @override
//   List<Object> get props => [];
//
//   @override
//   String toString() => 'GetUserListLoading';
// }
//
// class GetUserListSuccess extends GetUserListState {
//   final List<UserModel> users;
//   final bool noMoreData;
//
//   GetUserListSuccess({required this.users, this.noMoreData = false});
//
//   @override
//   List<Object> get props => [users];
//
//   @override
//   String toString() => 'GetUserListSuccess data :${users.length}';
// }
//
// class GetUserListEmpty extends GetUserListState {
//   @override
//   List<Object> get props => [];
//
//   @override
//   String toString() => 'GetUserListEmpty';
// }
//
// class GetUserListFailure extends GetUserListState {
//   final BaseError error;
//   final VoidCallback? callback;
//
//   GetUserListFailure({
//     required this.error,
//     this.callback,
//   });
//
//   @override
//   List<Object> get props => [error, callback!];
//
//   @override
//   String toString() => 'GetUserListFailure { error: $error }';
// }
//
// class GetUserListEvent extends Equatable {
//   final bool loadMore;
//   final CancelToken cancelToken;
//
//
//
//   GetUserListEvent(
//       {this.loadMore = false,
//       required this.cancelToken,});
//
//   @override
//   List<Object> get props => [];
//
//   @override
//   String toString() => 'GetUserListEvent loadMore $loadMore';
// }
//
// class GetUserListBloc
//     extends Bloc<GetUserListEvent, GetUserListState> {
//   List<UserModel> users = [];
//   int page = 1;
//
//
//   GetUserListBloc() : super(GetUserListUninitialized());
//
//   @override
//   Stream<GetUserListState> mapEventToState(
//       GetUserListEvent event) async* {
//     // repository instance
//     UserRepository _repository = getIt<UserRepository>();
//
//     try {
//       if (event.loadMore) {
//         this.page++;
//         print('event.loadMore');
//       } else {
//         page = 1;
//         yield GetUserListLoading();
//       }
//
//       Map<String, dynamic> queryParameters = {};
//       queryParameters.putIfAbsent('page', () => page);
//
//
//       final result = await _repository.getUserListWithPaged(
//           queryParameters: queryParameters, cancelToken: event.cancelToken);
//
//       if (result.data != null && result.data!.isNotEmpty) {
//         if (event.loadMore) {
//           List<UserModel> userListTemp = List.from(this.users);
//           userListTemp.addAll(result.data!);
//           await Future.delayed(Duration(seconds: 3), () {});
//           this.users = userListTemp;
//         } else {
//           await Future.delayed(Duration(seconds: 1), () {});
//           this.users = result.data!;
//         }
//         yield GetUserListSuccess(users: this.users);
//       }
//       else {
//         if (event.loadMore) {
//           page--;
//         }
//         print("bloc is here");
//         if(result.data!.isEmpty&&this.users.isEmpty){
//           print("bloc is here empty both");
//           yield GetUserListEmpty();
//
//         }else{
//           print("bloc is here empty one");
//     yield GetUserListSuccess(users: this.users,noMoreData: true);
//         }
//
//       }
//     } catch (err) {
//       print('Caught error: $err');
//       yield GetUserListFailure(
//         error: DioErrorUtil.handleError(err),
//         callback: () {
//           this.add(event);
//         },
//       );
//     }
//   }
// }
