import 'package:flutter/material.dart';
import 'package:question_answer_app/common/widgets/horizontal_padding.dart';
import 'package:question_answer_app/common/widgets/vertical_padding.dart';
import 'package:question_answer_app/constants/app_constants.dart';
import 'package:question_answer_app/models/questions/answer_item_model.dart';
import 'package:question_answer_app/models/questions/owner_item_model.dart';
import 'package:question_answer_app/models/questions/question_item_model.dart';
import 'package:question_answer_app/utils/device/app_uitls.dart';
import 'package:question_answer_app/widgets/image/image_network_circle.dart';

class ItemAnswerWidget extends StatefulWidget {
  final AnswerItemModel answer;

  const ItemAnswerWidget({required this.answer});

  @override
  _ItemAnswerWidgetState createState() => _ItemAnswerWidgetState();
}

class _ItemAnswerWidgetState extends State<ItemAnswerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  count: widget.answer.score ?? 0,
                  isAccepted:  widget.answer.isAccepted??false
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
                _buildOwnerWidget(owner: widget.answer.owner),
                VerticalPadding(
                  percentage: 0.007,
                ),


              ],
            ),
          ),
          HorizontalPadding(
            percentage: 0.02,
          ),
        ],
      ),
    );
  }

  _buildCountTitleWidget({required String title, required int count,bool isAccepted = false}) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              count.toString(),
              style:isAccepted ? appTextStyle.middleTSBasic.copyWith(
                  color: AppColors.darkGreen, fontWeight: FontWeight.bold) : appTextStyle.smallTSBasic.copyWith(
                  color: AppColors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Text(
              title,
              style:isAccepted ? appTextStyle.smallTSBasic.copyWith(
                color: AppColors.darkGreen,
              )
                  :appTextStyle.minTSBasic.copyWith(
                color: AppColors.black,
              ),
            ),
          ),

          isAccepted? Icon(Icons.check,color: AppColors.darkGreen,size: 14,):Container()
        ],
      ),
    );
  }


  _buildOwnerWidget({OwnerItemModel? owner}) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HorizontalPadding(
            percentage: 0.01,
          ),
          ImageNetworkCircleWidget(
            imageUrl: owner?.profileImage ?? "",
            imageWidth: 35,
            imageHeight: 35,
            imageBorderRadius: AppRadius.radius8,
          ),
          HorizontalPadding(
            percentage: 0.01,
          ),
          Expanded(
            child: Container(

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      owner?.displayName ?? "",
                      style: appTextStyle.smallTSBasic.copyWith(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    child: Row(
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
