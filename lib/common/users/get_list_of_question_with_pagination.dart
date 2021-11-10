import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:question_answer_app/blocs/question/get_question_list_bloc.dart';
import 'package:question_answer_app/models/questions/question_item_model.dart';
import 'package:question_answer_app/models/user/user_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:question_answer_app/constants/app_constants.dart';
import 'package:question_answer_app/ui/home/widgets/item_question.dart';
import 'package:question_answer_app/utils/device/app_uitls.dart';
import 'package:question_answer_app/utils/locale/app_localization.dart';
import 'package:question_answer_app/widgets/my_classic_footer.dart';

class ListOfQuestionWithPaginationWidget extends StatefulWidget {
  final CancelToken cancelToken;
  final double width;

  const ListOfQuestionWithPaginationWidget({
    required this.cancelToken,
    required this.width,
  });

  @override
  _ListOfQuestionWithPaginationWidgetState createState() =>
      _ListOfQuestionWithPaginationWidgetState();
}

class _ListOfQuestionWithPaginationWidgetState
    extends State<ListOfQuestionWithPaginationWidget> {
  var _bloc = GetQuestionListBloc();
  GlobalKey _key = GlobalKey();
  final _refresherController = RefreshController();

  List<QuestionItemModel> questions = [];
  @override
  void initState() {
    super.initState();
    _bloc.add(GetQuestionListEvent(
        cancelToken: widget.cancelToken,
        loadMore: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetQuestionListBloc, GetQuestionListState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is GetQuestionListSuccess) {
            questions = state.questions;
            _refresherController.loadComplete();
            _refresherController.refreshCompleted();

            print("bloc is here empty page");
            if (state.noMoreData) {
              print("bloc is here empty one noMoreData");
              AppUtils.showMessage(
                  message: AppLocalizations.of(context)
                      .translate('there_are_no_more_data'),
                  context: context,
                  title: "");
            }
          }
          if (state is GetQuestionListEmpty) {

            _refresherController.loadComplete();
            _refresherController.refreshCompleted();
            AppUtils.showMessage(
                message: AppLocalizations.of(context)
                    .translate('there_are_no_more_data'),
                context: context,
                title: "");
          }
          if (state is GetQuestionListFailure) {
            _refresherController.loadComplete();
            _refresherController.refreshCompleted();
            AppUtils.showErrorMessage(error: state.error, context: context);
          }
        },
        child: BlocBuilder<GetQuestionListBloc, GetQuestionListState>(
            bloc: _bloc,
            builder: (context, state) {
              return SmartRefresher(
                controller: _refresherController,
                enablePullUp: true,
                onRefresh: () {
                  _update();
                  _bloc.add(GetQuestionListEvent(
                      cancelToken: widget.cancelToken,
                      loadMore: false));
                },
                onLoading: _onLoading,
                header: MaterialClassicHeader(
                  color: AppColors.mainColor,
                ),
                footer: MyClassicFooter(),
                child: _viewWidget(result: questions, state: state),
              );
            }));
  }

  Widget _viewWidget(
      {required List<QuestionItemModel> result,
      required GetQuestionListState state}) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        var metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          if (metrics.pixels == 0)
            print('At top');
          else {
            _onLoading();
            print('At bottom');
          }
        }
        return true;
      },
      child: _buildListItem(result: result, state: state),
    );
  }

  _buildListItem(
      {required List<QuestionItemModel> result,
      required GetQuestionListState state}) {
    return result.isNotEmpty
        ? Container(
            // padding: const EdgeInsets.symmetric(horizontal: AppDimens.space20),
            child: ListView.separated(
              itemCount: result.length,
              shrinkWrap: true,
              separatorBuilder: (context,index){
                return Divider();
              },
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ItemQuestionWidget(question: questions[index]);
              },
            ))
        : state is GetQuestionListLoading
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimens.space20),
                child:Center(child: SpinKitRing(color: AppColors.mainColor,),))
            : state is GetQuestionListEmpty
                ? Container(
                    child: Center(
                        child: Text(
                            AppLocalizations.of(context).translate('no_data'))),
                  )
                : Container();
  }

  /// ====================== functions Section ======================================
  void _onLoading() {
    _bloc.add(GetQuestionListEvent(
        cancelToken: widget.cancelToken,
        loadMore: true));
  }

  _update() {
    if (mounted) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _bloc = GetQuestionListBloc();
        _key = GlobalKey();
        questions = [];
        _bloc.add(GetQuestionListEvent(
            cancelToken: widget.cancelToken,
            loadMore: false));
        setState(() {});
      });
    }
  }
}
