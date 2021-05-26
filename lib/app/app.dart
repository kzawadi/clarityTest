// import 'package:clarity/UI/Home/home_page.dart';
import 'package:clarity/UI/home.dart';
import 'package:clarity/UI/login.dart';
import 'package:clarity/UI/room_view_widget.dart';
import 'package:clarity/UIv2/pages/floor_ViewModel.dart';
import 'package:clarity/UIv2/pages/floor_page.dart';
import 'package:clarity/UIv2/pages/home_ViewModel.dart';
import 'package:clarity/UIv2/pages/home_page.dart';
// import 'package:clarity/UI/room_view_widgetv1.dart';
import 'package:clarity/accounts/login/login_view.dart';
import 'package:clarity/accounts/sign_up/create_account_view.dart';
import 'package:clarity/services/audio_services.dart';
import 'package:clarity/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: HomeView),
    CupertinoRoute(page: Login),
    CupertinoRoute(page: LoginView),
    CupertinoRoute(page: RoomViewMin),
    CupertinoRoute(page: CreateAccountView),
    CupertinoRoute(page: HomePage),
    CupertinoRoute(page: FloorPage),
    CupertinoRoute(page: StartUpView, initial: true)
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: Audio),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    // LazySingleton(classType: FloorViewModel),
    Singleton(classType: HomeViewmodel),

    // LazySingleton(classType: ProfileServices),
    Singleton(classType: FirebaseAuthenticationService),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
