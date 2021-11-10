
import 'package:aad_oauth/model/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:question_answer_app/blocs/application/application_bloc.dart';
import 'package:question_answer_app/blocs/application/application_events.dart';
import 'package:question_answer_app/common/animation/animation_column_widget.dart';
import 'package:question_answer_app/common/widgets/base_body.dart';
import 'package:question_answer_app/common/widgets/horizontal_padding.dart';
import 'package:question_answer_app/common/widgets/vertical_padding.dart';
import 'package:question_answer_app/constants/app_assets.dart';
import 'package:question_answer_app/constants/app_constants.dart';
import 'package:question_answer_app/main.dart';
import 'package:question_answer_app/ui/user_management/widgets/button_user_management_widget.dart';
import 'package:question_answer_app/ui/user_management/widgets/user_management_text_title_widget.dart';
import 'package:question_answer_app/utils/args/external_info_args.dart';
import 'package:question_answer_app/utils/device/app_uitls.dart';
import 'package:question_answer_app/utils/device/device_utils.dart';
import 'package:question_answer_app/utils/locale/app_localization.dart';
import 'package:question_answer_app/utils/routes/routes.dart';
import 'package:question_answer_app/utils/validators/base_validator.dart';
import 'package:question_answer_app/utils/validators/email_validator.dart';
import 'package:question_answer_app/utils/validators/required_validator.dart';
import 'package:question_answer_app/widgets/textfield/normal_form_field.dart';
import '../../../constants/app_constants.dart';
import '../../../data/app_server_constants.dart';
import '../../../utils/device/app_uitls.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthC = DeviceUtils.getScaledWidth(context, 1);
    double heightC = DeviceUtils.getScaledHeight(context, 1);
    return LoginContentPage(
      width: widthC,
      height: heightC,
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
  var _cancelToken = CancelToken();
  // var _bloc = SignInBloc();

  final formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email = "";
  String _password = "";

  bool _emailValidation = false;
  bool _passwordValidation = false;

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();

  bool _isExternalSigningIn = false;


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
    // oauth.setWebViewScreenSizeFromMedia(MediaQuery.of(context));

    AppBar appBar = AppBar(
      // title: TopLoginLogoWidget(),
      backgroundColor: AppColors.transparent,
      brightness: Brightness.light,
      toolbarHeight: 0,
      elevation: 0,
    );

    double widthC = widget.width;
    double heightC = widget.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return  Scaffold(
      primary: true,
      backgroundColor: AppColors.transparent,
      appBar: appBar,
      body: _buildBody(height: heightC, width: widthC),
    );
  }

  /// -------------------------------body methods-------------------------------
  Widget _buildBody({required double width, required double height}) {
    return BaseBody(
      portraitWidget: _portraitWidget(height: height, width: width),
      landscapeWidget: _landscapeWidget(height: height, width: width),
      isSafeAreaTop: true,
    );
  }

  /// ------------------------------portrait view-------------------------------
  Widget _portraitWidget({required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(
          left: AppDimens.space16, right: AppDimens.space16),
      alignment: AlignmentDirectional.center,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: AnimationColumnWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            duration: Duration(milliseconds: 1000),
            verticalOffset: 50,
            children: [
              SizedBox(
                height: kToolbarHeight,
              ),
              VerticalPadding(
                percentage: 0.15,
              ),

              VerticalPadding(
                percentage: 0.15,
              ),
              Container(
                height: 45,
                child: NormalFormField(
                  hintText: AppLocalizations.of(context).translate('email'),
                  style: appTextStyle.smallTSBasic
                      .copyWith(color: AppColors.black),
                  textAlign: TextAlign.start,
                  prefixIcon: Container(
                    width: 25,
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          end: AppDimens.space8),
                      child: Icon(
                        Icons.email_outlined,
                        size: 15,
                      ),
                    ),
                  ),
                  controller: _emailController,
                  onChanged: (value) {
                    setState(() {
                      _emailValidation = true;
                      _email = value;
                    });
                  },
                  validator: (value) {
                    return BaseValidator.validateValue(
                      context,
                      value!,
                      [RequiredValidator(), EmailValidator()],
                      _emailValidation,
                    );
                  },
                  focusNode: _emailNode,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passNode);
                  },
                ),
              ),
              VerticalPadding(
                percentage: 0.02,
              ),
              Container(
                height: 45,
                child: NormalFormField(
                  hintText: AppLocalizations.of(context).translate('password'),
                  style: appTextStyle.smallTSBasic
                      .copyWith(color: AppColors.black),
                  textAlign: TextAlign.start,
                  prefixIcon: Container(
                    width: 25,
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          end: AppDimens.space8),
                      child:Icon(
                        Icons.lock_outline,
                        size: 15,
                      ),
                    ),
                  ),
                  isSecure: true,
                  suffixIcon: InkWell(
                    onTap: () {
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: AppDimens.space8, top: AppDimens.space6),
                      child: Text(
                        "${AppLocalizations.of(context).translate('forget')}?",
                        style: appTextStyle.smallTSBasic
                            .copyWith(color: AppColors.mainColor),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _passwordValidation = true;
                      _password = value;
                    });
                  },
                  controller: _passwordController,
                  validator: (value) {
                    return BaseValidator.validateValue(
                      context,
                      value!,
                      [RequiredValidator()],
                      _passwordValidation,
                    );
                  },
                  focusNode: _passNode,
                  textInputAction: TextInputAction.next,
                ),
              ),
              VerticalPadding(
                percentage: 0.15,
              ),
              ButtonUserManagementWidget(
                width: width,
                child: Text(
                  AppLocalizations.of(context).translate("login_btn_sign_in"),
                  style: appTextStyle.normalTSBasic
                      .copyWith(color: AppColors.white),
                ),
                backgroundColor: AppColors.mainColor,
                height: 55,
                borderRadius: 10.0,
                borderColor: AppColors.white,
                onPressed: () async{
                  await Future.delayed(Duration(milliseconds: 750), () {});
                  Navigator.of(context).pushReplacementNamed(Routes.mainRootPage);
                },
              ),
              VerticalPadding(
                percentage: 0.02,
              ),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          .translate("login_not_have_account_txt"),
                      style: appTextStyle.minTSBasic
                          .copyWith(color: AppColors.mainGray),
                    ),
                    // HorizontalPadding(percentage: .01,)
                    InkWell(
                      // splashColor: AppColors.mainColor,
                      onTap: () {

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimens.space8),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("login_btn_sign_up"),
                          style: appTextStyle.smallTSBasic.copyWith(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              VerticalPadding(
                percentage: 0.02,
              ),

            ],
          ),
        ),
      ),
    );
  }

  /// ---------------------------landscape view---------------------------------
  Widget _landscapeWidget({required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(
          left: AppDimens.space16, right: AppDimens.space16),
      alignment: AlignmentDirectional.center,
      child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }

  ///



  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // _bloc.close();
    _cancelToken.cancel();

    _passNode.dispose();
    _passwordController.dispose();
    _emailController.dispose();

    super.dispose();
  }
}