import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:question_answer_app/common/animation/animation_column_widget.dart';
import 'package:question_answer_app/common/widgets/base_body.dart';
import 'package:question_answer_app/common/widgets/horizontal_padding.dart';
import 'package:question_answer_app/common/widgets/vertical_padding.dart';
import 'package:question_answer_app/constants/app_assets.dart';
import 'package:question_answer_app/constants/app_constants.dart';
import 'package:question_answer_app/ui/user_management/widgets/button_user_management_widget.dart';
import 'package:question_answer_app/ui/user_management/widgets/user_management_text_title_widget.dart';
import 'package:question_answer_app/utils/device/device_utils.dart';
import 'package:question_answer_app/utils/locale/app_localization.dart';
import 'package:question_answer_app/utils/routes/routes.dart';


class MainLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthC = DeviceUtils.getScaledWidth(context, 1);
    double heightC = DeviceUtils.getScaledHeight(context, 1);
    return Container(
      width: widthC,
      height: heightC,
      child: Stack(
        fit: StackFit.expand,
        children: [
          LoginContentPage(
            height: heightC,
            width: widthC,
          )
        ],
      ),
    );
  }
}

class LoginContentPage extends StatefulWidget {
  final double width;
  final double height;

  const LoginContentPage({required this.width, required this.height});

  @override
  _LoginContentPageState createState() => _LoginContentPageState();
}

class _LoginContentPageState extends State<LoginContentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Sign In"),
      backgroundColor: AppColors.transparent,
      brightness: Brightness.dark,
      elevation: 0,
    );

    double widthC = widget.width;
    double heightC = widget.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      primary: true,
      backgroundColor: AppColors.transparent,
      appBar: appBar,
      body: _buildBody(height: heightC, width: widthC),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody({required double width, required double height}) {
    return BaseBody(
      portraitWidget: _portraitWidget(height: height, width: width),
      landscapeWidget: _landscapeWidget(height: height, width: width),
      isSafeAreaTop: true,
    );
  }

  // portrait view:--------------------------------------------------------------
  Widget _portraitWidget({required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(
          left: AppDimens.space16, right: AppDimens.space16),
      alignment: AlignmentDirectional.center,
      child: SingleChildScrollView(
        child: AnimationColumnWidget(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          duration: Duration(milliseconds: 1000),
          verticalOffset: 50,
          children: [
            VerticalPadding(
              percentage: 0.03,
            ),

            ButtonUserManagementWidget(
              width: width,
              child: Text(
                AppLocalizations.of(context).translate("login_btn_sign_in"),
                style: appTextStyle.smallTSBasic.copyWith(
                    color: AppColors.black, fontWeight: FontWeight.bold),
              ),
              backgroundColor: AppColors.white,
              height: 45,
              borderColor: AppColors.white,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.mainRootPage);
              },
            ),
            VerticalPadding(
              percentage: 0.02,
            ),
            ButtonUserManagementWidget(
              width: width,
              backgroundColor: AppColors.white.withOpacity(0.3),
              height: 45,
              child: Text(
                AppLocalizations.of(context).translate("login_btn_sign_up"),
                style: appTextStyle.smallTSBasic.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.bold),
              ),
              borderColor: AppColors.white,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.mainRootPage);
              },
            ),
            VerticalPadding(
              percentage: 0.04,
            ),



            VerticalPadding(
              percentage: 0.2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _landscapeWidget({required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(
          left: AppDimens.space16, right: AppDimens.space16),
      alignment: AlignmentDirectional.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            VerticalPadding(
              percentage: 0.03,
            ),
            Container(
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        UserManagementTextTitleWidget(
                          title: AppLocalizations.of(context)
                              .translate("login_text_1"),
                        ),
                        UserManagementTextTitleWidget(
                          title: AppLocalizations.of(context)
                              .translate("login_text_2"),
                          style: appTextStyle.subLargeTSBasic.copyWith(
                              color: AppColors.white,
                              height: 1.4,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                  ),
                  HorizontalPadding(
                    percentage: 0.2,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          ButtonUserManagementWidget(
                            width: width,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("login_btn_sign_in"),
                              style: appTextStyle.smallTSBasic.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: AppColors.white,
                            height: 45,
                            borderColor: AppColors.white,
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(Routes.mainRootPage);
                            },
                          ),
                          VerticalPadding(
                            percentage: 0.02,
                          ),
                          ButtonUserManagementWidget(
                            width: width,
                            backgroundColor: AppColors.white.withOpacity(0.3),
                            height: 45,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("login_btn_sign_up"),
                              style: appTextStyle.smallTSBasic.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            borderColor: AppColors.white,
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(Routes.mainRootPage);
                            },
                          ),
                          VerticalPadding(
                            percentage: 0.04,
                          ),
                          UserManagementTextTitleWidget(
                            title: AppLocalizations.of(context)
                                .translate("sign_in_with"),
                            alignment: AlignmentDirectional.center,
                            style: appTextStyle.smallTSBasic.copyWith(
                                color: AppColors.white,
                                height: 1.4,
                                fontWeight: FontWeight.normal),
                          ),
                          VerticalPadding(
                            percentage: 0.05,
                          ),

                        ],
                      )),
                ],
              ),
            ),
            VerticalPadding(
              percentage: 0.2,
            ),
          ],
        ),
      ),
    );
  }



  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
  }
}
