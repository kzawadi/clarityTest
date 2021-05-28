import 'package:clarity/UIv2/pages/profile_services.dart';
import 'package:clarity/app/app.locator.dart';
import 'package:clarity/model/user_profile_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class AppBarViewmodel extends FutureViewModel<UserProfileModel> {
  final _profileServices = locator<ProfileServices>();
  final _authServices = locator<FirebaseAuthenticationService>();

  // UserProfileModel _t;
  // UserProfileModel get userData => _t;

  Future<UserProfileModel> getProfilesData() async {
    return await _profileServices.getProfileData(
        uuid: _authServices.currentUser.uid);
  }

  @override
  Future<UserProfileModel> futureToRun() => getProfilesData();
}
