import 'package:flutter/material.dart';
import 'package:question_answer_app/constants/app_constants.dart';
import 'package:question_answer_app/ui/question/args/question_details_args.dart';
import 'package:question_answer_app/ui/question/widgets/question_deatils_widget.dart';
import 'package:question_answer_app/utils/device/device_utils.dart';

class QuestionDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as QuestionDetailsArgs;
    AppBar appBar = AppBar(
      title: Text("Answers",style: appTextStyle.middleTSBasic.copyWith(color: AppColors.white),),
      centerTitle: true,
      backgroundColor: AppColors.mainColor,
      iconTheme: IconThemeData(color: AppColors.white),
      brightness: Brightness.dark,
      elevation: 0,
    );

    double widthC = DeviceUtils.getScaledWidth(context, 1);
    double heightC = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        appBar: appBar,
        body: QuestionDetailsWidget(
          question: args.question,
          height: heightC,
          width: widthC,
        ));
  }
}
