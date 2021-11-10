import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:question_answer_app/blocs/main/root_page_bloc.dart';
import 'package:question_answer_app/constants/app_constants.dart';
import 'package:question_answer_app/ui/home/pages/home_page.dart';
import 'package:question_answer_app/utils/locale/app_localization.dart';
import 'package:question_answer_app/utils/routes/routes.dart';

class MainRootPage extends StatefulWidget {
  @override
  _MainRootPageState createState() => _MainRootPageState();
}

class _MainRootPageState extends State<MainRootPage>
    with SingleTickerProviderStateMixin {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  late TabController tabController;
  DateTime? currentBackPressTime;

  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) setState(() {});
    });
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RootPageBloc, RootPageState>(
      listener: (context, state) {
        if (state is PageIndexState) {
          if (state.pageIndex != null) {
            tabController.index = state.pageIndex;
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBGColor,
        bottomNavigationBar: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(
              left: AppDimens.space16,
              right: AppDimens.space16,
              bottom: AppDimens.space16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.radius8),
                bottomLeft: Radius.circular(AppRadius.radius8),
                topRight: Radius.circular(AppRadius.radius8),
                bottomRight: Radius.circular(AppRadius.radius8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.radius8),
                bottomLeft: Radius.circular(AppRadius.radius8),
                topRight: Radius.circular(AppRadius.radius8),
                bottomRight: Radius.circular(AppRadius.radius8),
              ),
              child: Container(
                color: AppColors.white,
                child: Container(
                  height: 50,
                  child: TabBar(
                    controller: tabController,
                    indicatorColor: AppColors.white,
                    indicatorPadding: EdgeInsets.all(0.0),
                    labelPadding: EdgeInsets.all(0.0),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      _buildTabItem(
                          text: "",
                          icon: Icons.home_outlined,
                          page: PagesEnum.PAGE_1),
                      _buildTabItem(
                          text: "",
                          icon: Icons.collections,
                          page: PagesEnum.PAGE_2),
                      _buildTabItem(
                          text: "",
                          icon: Icons.search,
                          page: PagesEnum.PAGE_3),
                      _buildTabItem(
                          text: "",
                          icon: Icons.more_horiz_outlined,
                          page: PagesEnum.PAGE_4),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: _onWillPop,
          child: Container(
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                HomeScreen(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget _buildTabItem(
      {required String text,
      required IconData icon,
      required PagesEnum page,
      Color? svgColor,
      double? iconSize}) {
    bool isSelected = (page.index == tabController.index);

    final iconColor = isSelected ? AppColors.mainColor : AppColors.mainGray;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: iconSize ?? 18,
      height: iconSize ?? 18,
      child: Center(
        child: Icon(
          icon,
          color: svgColor ?? iconColor,
          size: iconSize ?? 18,
        ),
      ),
    );
  }

  Widget _buildTabItem2(
      {required String text,
      required String iconPath,
      Color? svgColor,
      double? iconSize}) {
    // bool isSelected = (page.index == tabController.index);
    //
    // final iconColor = isSelected ? AppColors.mainColor : AppColors.mainGray;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: iconSize ?? 18,
      height: iconSize ?? 18,
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          color: svgColor,
          width: iconSize ?? 18,
          height: iconSize ?? 18,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    if (checkIndex()) return Future.value(false);

    if (tabController.index != PagesEnum.PAGE_1.index) {
      tabController.animateTo(0);
      return Future.value(false);
    }
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('tab_to_exit'),
          backgroundColor: AppColors.mainColor,
          textColor: AppColors.white);
      return Future.value(false);
    }
    SystemNavigator.pop();
    return Future.value(true);
  }

  bool checkIndex() {
    if (tabController.index == 0) return false;
    // botNavBar.onTap(0);
    tabController.animateTo(0);
    return true;
  }
}

enum PagesEnum {
  PAGE_1,
  PAGE_2,
  PAGE_3,
  PAGE_4,
}
