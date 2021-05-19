import 'package:clarity/accounts/authentication_viewmodel.dart';
import 'package:clarity/app/app.locator.dart';
import 'package:clarity/app/app.router.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import 'create_account_view.form.dart';

class CreateAccountViewModel extends AuthenticationViewModel {
  final _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  CreateAccountViewModel()
      : super(
            successRoute: Routes.homeView); //todo this route must get an audit

  @override
  Future<FirebaseAuthenticationResult> runAuthentication() =>
      _firebaseAuthenticationService.createAccountWithEmail(
        email: emailValue,
        password: passwordValue,
      );
  // .whenComplete(() =>
  //     kAnalytics.logSignUp(signUpMethod: 'createAccountWithEmail')
  //     );

  void navigateBack() => navigationService.back();
}
