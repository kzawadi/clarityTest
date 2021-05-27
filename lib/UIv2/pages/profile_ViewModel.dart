import 'dart:io';

import 'package:clarity/UIv2/pages/profile_services.dart';
import 'package:clarity/app/app.locator.dart';
import 'package:clarity/app/app.router.dart';
import 'package:clarity/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends FutureViewModel {
  final _navigationServices = locator<NavigationService>();
  final _profileServices = locator<ProfileServices>();

  File _image;
  File get imagePicked => _image;

  String get dummyProfilePic =>
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80';
  navigateToEdit() {
    _navigationServices.navigateTo(Routes.profileEditingPage);
    cprint("navigationg to edit profiles");
  }

  initialize() {
    cprint("model initializationa");
  }

  @override
  Future futureToRun() {
    return Future.delayed(Duration(seconds: 3));
  }

  Future<void> openImage(BuildContext context) async {
    _profileServices.openImagePicker(context, (file) async {
      _image = file;
      notifyListeners();
    });
    // notifyListeners();
  }
}
