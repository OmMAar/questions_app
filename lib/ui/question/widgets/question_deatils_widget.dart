import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:question_answer_app/common/users/get_list_of_answer_with_pagination.dart';
import 'package:question_answer_app/constants/app_constants.dart';
import 'package:question_answer_app/models/questions/question_item_model.dart';
import 'package:question_answer_app/ui/home/widgets/item_question.dart';

class QuestionDetailsWidget extends StatefulWidget {
  final QuestionItemModel question;
  final double width;
  final double height;
  const QuestionDetailsWidget({required this.question,required this.width,required this.height});
  @override
  _QuestionDetailsWidgetState createState() => _QuestionDetailsWidgetState();
}

class _QuestionDetailsWidgetState extends State<QuestionDetailsWidget> {
  var _cancelToken = CancelToken();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          ItemQuestionWidget(question:widget.question),
          Divider(
            height: 10,
            color: AppColors.mainColor,
          ),
          Expanded(child: ListOfAnswerWithPaginationWidget(
            width: widget.width,
            questionId: widget.question.questionId!,
            cancelToken: _cancelToken,
          ))
        ],
      ),
    );
  }
  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
