// import 'package:clarity/UI/Home/home_page.dart';
import 'package:clarity/UI/home.dart';
import 'package:clarity/UI/login.dart';
import 'package:clarity/UI/room_view_widget.dart';
import 'package:clarity/UIv2/pages/app_barViewModel.dart';
import 'package:clarity/UIv2/pages/app_bar_view.dart';
import 'package:clarity/UIv2/pages/detail_page.dart';
import 'package:clarity/UIv2/pages/doctors/doctor_ViewModel.dart';
import 'package:clarity/UIv2/pages/doctors/doctor_page.dart';
import 'package:clarity/UIv2/pages/floor_ViewModel.dart';
import 'package:clarity/UIv2/pages/floor_page.dart';
import 'package:clarity/UIv2/pages/home_ViewModel.dart';
import 'package:clarity/UIv2/pages/home_headerViewModel.dart';
import 'package:clarity/UIv2/pages/home_header_view.dart';
import 'package:clarity/UIv2/pages/home_page.dart';
import 'package:clarity/UIv2/pages/profile_ViewModel.dart';
import 'package:clarity/UIv2/pages/profile_edit_page.dart';
import 'package:clarity/UIv2/pages/profile_services.dart';
// import 'package:clarity/UI/room_view_widgetv1.dart';
import 'package:clarity/accounts/login/login_view.dart';
import 'package:clarity/accounts/sign_up/create_account_view.dart';
import 'package:clarity/services/audio_services.dart';
import 'package:clarity/services/doctors/doctor_services.dart';
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
    CupertinoRoute(page: ProfileEditingPage),
    CupertinoRoute(page: ProfilePage),
    CupertinoRoute(page: AppBarView),
    CupertinoRoute(page: HomeHeaderView),
    CupertinoRoute(page: DoctorPage),
    CupertinoRoute(page: StartUpView, initial: true)
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: Audio),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: ProfileServices),
    LazySingleton(classType: DoctorServices),
    LazySingleton(classType: AppBarViewmodel),
    LazySingleton(classType: HomeHeaderViewModel),
    LazySingleton(classType: DoctorViewModel),
    Singleton(classType: HomeViewmodel),

    // LazySingleton(classType: ProfileServices),
    Singleton(classType: FirebaseAuthenticationService),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
