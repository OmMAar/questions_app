// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:question_answer_app/blocs/mom/mom_list_bloc.dart';
// import 'package:question_answer_app/constants/app_constants.dart';
// import 'package:question_answer_app/models/mom_list/mom_item_model.dart';
// import 'package:question_answer_app/ui/home/widgets/items/item_home_mom_details_widget.dart';
// import 'package:question_answer_app/ui/home/widgets/items/item_mom_action_details_widget.dart';
// import 'package:question_answer_app/ui/mom_list/widgets/loading_widgets/mom_list_shimmer_widget.dart';
// import 'package:question_answer_app/utils/args/mom_filter_args.dart';
// import 'package:question_answer_app/utils/device/app_uitls.dart';
// import 'package:question_answer_app/utils/locale/app_localization.dart';
// import 'package:question_answer_app/widgets/my_classic_footer.dart';
//
// class MOMListWithPaginationWidget extends StatefulWidget {
//   final CancelToken cancelToken;
//   final MomFilterArgs filterArgs;
//   final double width;
//   final bool fromHome;
//   final Function() onUpdate;
//
//   const MOMListWithPaginationWidget({
//     required this.cancelToken,
//     required this.filterArgs,
//     required this.width,
//     required this.onUpdate,
//     this.fromHome = false,
//   });
//
//   @override
//   _MOMListWithPaginationWidgetState createState() =>
//       _MOMListWithPaginationWidgetState();
// }
//
// class _MOMListWithPaginationWidgetState
//     extends State<MOMListWithPaginationWidget> {
//   var _bloc = MOMListBloc();
//   GlobalKey _key = GlobalKey();
//   final _refresherController = RefreshController();
//   List<MomsItemModel> moms = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _bloc.add(MOMListEvent(
//         cancelToken: widget.cancelToken,
//         loadMore: false,
//         filterArgs: widget.filterArgs));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<MOMListBloc, MOMListState>(
//         bloc: _bloc,
//         listener: (context, state) async {
//           if (state is MOMListSuccess) {
//             moms = state.result;
//             _refresherController.loadComplete();
//             _refresherController.refreshCompleted();
//             if (state.noMoreData) {
//               AppUtils.showMessage(
//                   message: AppLocalizations.of(context)
//                       .translate('there_are_no_more_data'),
//                   context: context,
//                   title: "");
//             }
//           }
//           if (state is MOMListFailure) {
//             _refresherController.loadComplete();
//             _refresherController.refreshCompleted();
//             AppUtils.showErrorMessage(error: state.error, context: context);
//           }
//         },
//         child: BlocBuilder<MOMListBloc, MOMListState>(
//             bloc: _bloc,
//             builder: (context, state) {
//               return SmartRefresher(
//                 controller: _refresherController,
//                 enablePullUp: true,
//                 onRefresh: () {
//                   _update();
//                   _bloc.add(MOMListEvent(
//                       cancelToken: widget.cancelToken,
//                       loadMore: false,
//                       filterArgs: widget.filterArgs));
//                 },
//                 onLoading: _onLoading,
//                 header: MaterialClassicHeader(
//                   color: AppColors.mainColor,
//                 ),
//                 footer: MyClassicFooter(),
//                 child: _viewWidget(result: moms, state: state),
//               );
//             }));
//   }
//
//   Widget _viewWidget(
//       {required List<MomsItemModel> result, required MOMListState state}) {
//     return NotificationListener<ScrollEndNotification>(
//       onNotification: (scrollEnd) {
//         var metrics = scrollEnd.metrics;
//         if (metrics.atEdge) {
//           if (metrics.pixels == 0)
//             print('At top');
//           else {
//             _onLoading();
//             print('At bottom');
//           }
//         }
//         return true;
//       },
//       child: _buildListItem(result: result, state: state),
//     );
//   }
//
//   _buildListItem(
//       {required List<MomsItemModel> result, required MOMListState state}) {
//     return result.isNotEmpty
//         ? Container(
//             key: _key,
//             child: AnimationLimiter(
//               child: ListView.builder(
//                 padding: const EdgeInsets.only(
//                     left: AppDimens.space8,
//                     right: AppDimens.space8,
//                     top: AppDimens.space16),
//                 itemCount: result.length,
//                 shrinkWrap: true,
//                 physics: BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return AnimationConfiguration.staggeredList(
//                     position: index,
//                     duration: const Duration(milliseconds: 1000),
//                     delay: Duration(milliseconds: 500),
//                     child: SlideAnimation(
//                       verticalOffset: 50.0,
//                       child: FadeInAnimation(
//                         child: widget.fromHome
//                             ? ItemHomeMomDetailsWidget(
//                                 info: result[index],
//                                 onUpdateInfoChanged: widget.onUpdate,
//                               )
//                             : ItemActionDetailsWidget(
//                                 info: result[index],
//                                 onUpdateInfoChanged: widget.onUpdate,
//                           cancelToken:widget.cancelToken,
//                               ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           )
//         : state is MOMListLoading
//             ? Container(
//                 child: LoadingMOMListShimmerWidget(
//                   width: widget.width,
//                   height: double.infinity,
//                 ),
//               )
//             : Container(
//                 child: Center(
//                     child: Text(
//                         AppLocalizations.of(context).translate('no_data'))),
//               );
//   }
//
//   /// ====================== functions Section ======================================
//   void _onLoading() {
//     _bloc.add(MOMListEvent(
//         cancelToken: widget.cancelToken,
//         loadMore: true,
//         filterArgs: widget.filterArgs));
//   }
//
//   _update() {
//     if (mounted) {
//       WidgetsBinding.instance!.addPostFrameCallback((_) {
//         _bloc = MOMListBloc();
//         _key = GlobalKey();
//         moms = [];
//         _bloc.add(MOMListEvent(
//             cancelToken: widget.cancelToken,
//             loadMore: false,
//             filterArgs: widget.filterArgs));
//         setState(() {});
//       });
//     }
//   }
// }
