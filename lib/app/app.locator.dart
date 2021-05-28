// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../UIv2/pages/home_ViewModel.dart';
import '../UIv2/pages/profile_services.dart';
import '../services/audio_services.dart';
import '../services/doctors/doctor_services.dart';

final locator = StackedLocator.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => Audio());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => ProfileServices());
  locator.registerLazySingleton(() => DoctorServices());
  locator.registerSingleton(HomeViewmodel());
  locator.registerSingleton(FirebaseAuthenticationService());
}
