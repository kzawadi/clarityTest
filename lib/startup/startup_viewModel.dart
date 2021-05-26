import 'package:clarity/app/app.locator.dart';
import 'package:clarity/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

// "BUSINESS LOGIC" AND VIEW STATE

class StartUpViewModel extends BaseViewModel {
  final FirebaseAuthenticationService _authenticationService =
      locator<FirebaseAuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<bool> isUserLoggedIn() async {
    var user = _authenticationService.firebaseAuth.currentUser;
    return user != null;
  }

  Future handleStartUpLogic() async {
    await isUserLoggedIn().then((v) {
      if (v) {
        _navigationService.replaceWith(Routes.floorPage);
      } else {
        _navigationService.replaceWith(Routes.loginView);
      }
    });
    // await isUserLoggedIn().then((v) {
    //   if (v) {
    //     _navigationService.replaceWith(Routes.participantsView);
    //   } else {
    //     _navigationService.replaceWith(Routes.loginView);
    //   }
    // });

    // var x = await _authenticationService.firebaseAuth.currentUser;

    // if (hasLoggedInUser != null) {
    //   _navigationService.navigateTo(Routes.participantsView);
    // } else {
    //   _navigationService.navigateTo(Routes.loginView);
    // }
  }
}
