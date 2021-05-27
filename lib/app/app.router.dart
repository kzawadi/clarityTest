// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../UI/home.dart';
import '../UI/login.dart';
import '../UI/room_view_widget.dart';
import '../UIv2/pages/detail_page.dart';
import '../UIv2/pages/floor_page.dart';
import '../UIv2/pages/home_page.dart';
import '../UIv2/pages/profile_edit_page.dart';
import '../accounts/login/login_view.dart';
import '../accounts/sign_up/create_account_view.dart';
import '../startup/startup_view.dart';

class Routes {
  static const String homeView = '/home-view';
  static const String login = '/Login';
  static const String loginView = '/login-view';
  static const String roomViewMin = '/room-view-min';
  static const String createAccountView = '/create-account-view';
  static const String homePage = '/home-page';
  static const String floorPage = '/floor-page';
  static const String profileEditingPage = '/profile-editing-page';
  static const String profilePage = '/profile-page';
  static const String startUpView = '/';
  static const all = <String>{
    homeView,
    login,
    loginView,
    roomViewMin,
    createAccountView,
    homePage,
    floorPage,
    profileEditingPage,
    profilePage,
    startUpView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.login, page: Login),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.roomViewMin, page: RoomViewMin),
    RouteDef(Routes.createAccountView, page: CreateAccountView),
    RouteDef(Routes.homePage, page: HomePage),
    RouteDef(Routes.floorPage, page: FloorPage),
    RouteDef(Routes.profileEditingPage, page: ProfileEditingPage),
    RouteDef(Routes.profilePage, page: ProfilePage),
    RouteDef(Routes.startUpView, page: StartUpView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    Login: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const Login(),
        settings: data,
      );
    },
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => LoginView(key: args.key),
        settings: data,
      );
    },
    RoomViewMin: (data) {
      var args = data.getArgs<RoomViewMinArguments>(
        orElse: () => RoomViewMinArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => RoomViewMin(key: args.key),
        settings: data,
      );
    },
    CreateAccountView: (data) {
      var args = data.getArgs<CreateAccountViewArguments>(
        orElse: () => CreateAccountViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => CreateAccountView(key: args.key),
        settings: data,
      );
    },
    HomePage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => HomePage(),
        settings: data,
      );
    },
    FloorPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const FloorPage(),
        settings: data,
      );
    },
    ProfileEditingPage: (data) {
      var args = data.getArgs<ProfileEditingPageArguments>(
        orElse: () => ProfileEditingPageArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ProfileEditingPage(key: args.key),
        settings: data,
      );
    },
    ProfilePage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const ProfilePage(),
        settings: data,
      );
    },
    StartUpView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LoginView arguments holder class
class LoginViewArguments {
  final Key key;
  LoginViewArguments({this.key});
}

/// RoomViewMin arguments holder class
class RoomViewMinArguments {
  final Key key;
  RoomViewMinArguments({this.key});
}

/// CreateAccountView arguments holder class
class CreateAccountViewArguments {
  final Key key;
  CreateAccountViewArguments({this.key});
}

/// ProfileEditingPage arguments holder class
class ProfileEditingPageArguments {
  final Key key;
  ProfileEditingPageArguments({this.key});
}
