import 'package:clarity/accounts/authentication_viewmodel.dart';
import 'package:clarity/app/app.locator.dart';
import 'package:clarity/app/app.router.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import 'login_view.form.dart';

class LoginViewModel extends AuthenticationViewModel {
  final _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  LoginViewModel() : super(successRoute: Routes.homeView);

  @override
  Future<FirebaseAuthenticationResult> runAuthentication() =>
      _firebaseAuthenticationService.loginWithEmail(
        email: emailValue,
        password: passwordValue,
      );

  // void navigateToHallWay() =>
  //     navigationService.navigateTo(Routes.participantsView);

  void navigateToCreateAccount() =>
      navigationService.navigateTo(Routes.createAccountView);
}
