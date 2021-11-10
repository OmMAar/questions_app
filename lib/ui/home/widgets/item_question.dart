import 'package:flutter/material.dart';
import 'package:question_answer_app/common/widgets/horizontal_padding.dart';
import 'package:question_answer_app/common/widgets/vertical_padding.dart';
import 'package:question_answer_app/constants/app_constants.dart';
import 'package:question_answer_app/models/questions/owner_item_model.dart';
import 'package:question_answer_app/models/questions/question_item_model.dart';
import 'package:question_answer_app/ui/question/args/question_details_args.dart';
import 'package:question_answer_app/utils/device/app_uitls.dart';
import 'package:question_answer_app/utils/routes/routes.dart';
import 'package:question_answer_app/widgets/image/image_network_circle.dart';

class ItemQuestionWidget extends StatefulWidget {
  final QuestionItemModel question;

  const ItemQuestionWidget({required this.question});

  @override
  _ItemQuestionWidgetState createState() => _ItemQuestionWidgetState();
}

class _ItemQuestionWidgetState extends State<ItemQuestionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(Routes.questionDetailsPage,arguments: QuestionDetailsArgs(question: widget.question));
      },
      child: Container(
        padding: const EdgeInsets.all(AppDimens.space8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HorizontalPadding(
              percentage: 0.02,
            ),
            Container(
              // padding: const EdgeInsets.all(AppDimens.space12),
              child: Column(
                children: [
                  _buildCountTitleWidget(
                    title: "votes",
                    count: widget.question.score ?? 0,
                  ),
                  VerticalPadding(
                    percentage: 0.02,
                  ),
                  _buildCountTitleWidget(
                    title: "answers",
                    count: widget.question.answerCount ?? 0,
                  ),
                  VerticalPadding(
                    percentage: 0.02,
                  ),
                  _buildCountTitleWidget(
                    title: "view",
                    count: widget.question.viewCount ?? 0,
                  ),
                ],
              ),
            ),
            HorizontalPadding(
              percentage: 0.02,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "${widget.question.title ?? ""}",
                      style: appTextStyle.middleTSBasic.copyWith(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  VerticalPadding(
                    percentage: 0.007,
                  ),
                  Container(
                    child: _buildListOfTags(tags: widget.question.tags ?? []),
                  ),
                  VerticalPadding(
                    percentage: 0.015,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(
                            "stackoverflow",
                            style: appTextStyle.minTSBasic.copyWith(
                                color: AppColors.blueBackground,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                          ),
                          onPressed: () {
                            AppUtils.launchURL(widget.question.link ?? "");
                          },
                        ),
                        Expanded(
                            child:
                                _buildOwnerWidget(owner: widget.question.owner))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            HorizontalPadding(
              percentage: 0.02,
            ),
          ],
        ),
      ),
    );
  }

  _buildCountTitleWidget({required String title, required int count}) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              count.toString(),
              style: appTextStyle.smallTSBasic.copyWith(
                  color: AppColors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Text(
              title,
              style: appTextStyle.minTSBasic.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildListOfTags({required List<String> tags}) {
    Wrap body = new Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: []);

    body.children.addAll(tags.map((item) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.space2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppRadius.radius8)),
                  color: AppColors.mainColor.withOpacity(0.2),
                  border: Border.all(
                      color: AppColors.mainColor.withOpacity(0.2), width: 0.5)),
              padding: EdgeInsets.symmetric(
                  vertical: AppDimens.space4, horizontal: AppDimens.space12),
              margin: EdgeInsets.all(AppDimens.space4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item,
                    style: appTextStyle.smallTSBasic.copyWith(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }));
    return Column(
      children: [
        VerticalPadding(
          percentage: 0.01,
        ),
        Container(width: double.infinity, child: body),
      ],
    );
  }

  _buildOwnerWidget({OwnerItemModel? owner}) {
    return Container(
      width: double.infinity,
      alignment: AlignmentDirectional.centerEnd,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageNetworkCircleWidget(
            imageUrl: owner?.profileImage ?? "",
            imageWidth: 30,
            imageHeight: 30,
            imageBorderRadius: AppRadius.radius8,
          ),
          HorizontalPadding(
            percentage: 0.01,
          ),
          Container(
            width: 70,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    owner?.displayName ?? "",
                    style: appTextStyle.minTSBasic.copyWith(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      _buildIconCount(count:  owner?.reputation?.toString() ,icon:  Icons.circle,iconColor: AppColors.lightGrey,),
                      HorizontalPadding(percentage: 0.02,),
                      _buildIconCount(count:  owner?.acceptRate?.toString() ,icon:  Icons.circle,iconColor: AppColors.darkGreen,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _buildIconCount({required IconData icon,required Color iconColor, String? count}){
    return AppUtils.notNullOrEmpty(count)?
    Container(
      child: Row(
        children: [
          Icon(
            icon,
            size: 10,
            color: iconColor,
          ),
          Text(
            count??"",
            style: appTextStyle.minTSBasic.copyWith(
              color: AppColors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ) : Container();
  }
}
