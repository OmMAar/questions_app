import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:question_answer_app/constants/app_constants.dart';
import 'package:question_answer_app/stores/language/language_store.dart';

class LinearIndicatorWithLabel extends StatefulWidget {
  final double value;
  final Color color;
  final double value2;
  final Color color2;
  final double value3;
  final Color color3;

  const LinearIndicatorWithLabel(
      {required this.value, required this.color, required this.value3, required this.color3, required this.value2, required this.color2,});

  @override
  _LinearIndicatorWithLabelState createState() =>
      _LinearIndicatorWithLabelState();
}

class _LinearIndicatorWithLabelState extends State<LinearIndicatorWithLabel> {
  late LanguageStore _languageStore;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      //   borderRadius: BorderRadius.only(
      //     bottomRight: Radius.circular(AppRadius.radius20),
      //     topRight: Radius.circular(AppRadius.radius20),
      //   ),
      //   //
      // ),
      width: double.infinity,
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        removeTop: true,
        child: SfLinearGauge(
            interval: 20,
            animateAxis: true,
            animateRange: true,
            labelPosition: LinearLabelPosition.outside,
            tickPosition: LinearElementPosition.outside,
            showTicks: false,
            onGenerateLabels: () {
              return <LinearAxisLabel>[

                LinearAxisLabel(
                    text: '${widget.value.toString()}%', value: widget.value),
                LinearAxisLabel(
                    text: '${widget.value2.toString()}%', value: widget.value2),
                LinearAxisLabel(
                    text: '${widget.value3.toString()}%', value: widget.value3),

              ];
            },

            axisLabelStyle: appTextStyle.sub3MinTSBasic,
            minorTicksPerInterval: 4,
            useRangeColorForAxis: true,
            axisTrackStyle: const LinearAxisTrackStyle(
                thickness: 4.0, color: Colors.transparent),
            ranges: <LinearGaugeRange>[
              LinearGaugeRange(
                startValue: 0.0,
                midValue: 0,
                endValue: widget.value,
                startWidth: 5,
                edgeStyle: LinearEdgeStyle.startCurve,
                midWidth: 5,
                endWidth: 5,
                position: LinearElementPosition.cross,
                color: widget.color,
              ),
              LinearGaugeRange(
                startValue: widget.value,
                midValue: 0,
                endValue: widget.value2,
                startWidth: 5,
                edgeStyle: LinearEdgeStyle.bothFlat,
                midWidth: 5,
                endWidth: 5,
                position: LinearElementPosition.cross,
                color: widget.color2,

              ),
              LinearGaugeRange(
                startValue: widget.value2,
                midValue: 0,
                endValue: widget.value3,
                startWidth: 5,
                edgeStyle: LinearEdgeStyle.endCurve,
                midWidth: 5,
                endWidth: 5,
                position: LinearElementPosition.cross,
                color: widget.color3,
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.mainGray,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              _languageStore.getLanguage() == "ar" ? AppRadius
                                  .radius20 : 0.0),
                          bottomRight: Radius.circular(
                              _languageStore.getLanguage() == "ar"
                                  ? 0.0
                                  : AppRadius.radius20),
                          topLeft: Radius.circular(
                              _languageStore.getLanguage() == "ar" ? AppRadius
                                  .radius20 : 0.0),
                          topRight: Radius.circular(
                              _languageStore.getLanguage() == "ar"
                                  ? 0.0
                                  : AppRadius.radius20),
                        ),
                    ),
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(end: 0.5, top: 0.5,bottom: 0.5),
                      decoration: BoxDecoration(
                        color: AppColors.white,

                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              _languageStore.getLanguage() == "ar" ? AppRadius
                                  .radius20 : 0.0),
                          bottomRight: Radius.circular(
                              _languageStore.getLanguage() == "ar"
                                  ? 0.0
                                  : AppRadius.radius20),
                          topLeft: Radius.circular(
                              _languageStore.getLanguage() == "ar" ? AppRadius
                                  .radius20 : 0.0),
                          topRight: Radius.circular(
                              _languageStore.getLanguage() == "ar"
                                  ? 0.0
                                  : AppRadius.radius20),
                        ), // BorderRadius

                      ), // BoxDecoration
                    ),
                ),
              ),
            ]),
      ),
    );
  }
}
