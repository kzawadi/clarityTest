import 'package:clarity/UIv2/pages/profile_services.dart';
import 'package:clarity/app/app.locator.dart';
import 'package:clarity/model/user_profile_model.dart';
import 'package:clarity/services/utility.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class HomeHeaderViewModel extends FutureViewModel<UserProfileModel> {
  final _profileServices = locator<ProfileServices>();
  final _authServices = locator<FirebaseAuthenticationService>();

  // UserProfileModel _t;
  // UserProfileModel get userData => _t;

  Future<UserProfileModel> getProfilesData() async {
    UserProfileModel c = await _profileServices.getProfileData(
        uuid: _authServices.currentUser.uid);
    // cprint(prettyJson(c, indent: 1) + "This is data from Viewmodels");

    return c;
  }

  @override
  Future<UserProfileModel> futureToRun() async => await getProfilesData();
}
