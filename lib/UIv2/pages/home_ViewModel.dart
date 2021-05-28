import 'package:clarity/UIv2/pages/profile_services.dart';
import 'package:clarity/app/app.locator.dart';
import 'package:clarity/model/dactor_model.dart';
import 'package:clarity/model/data.dart';
import 'package:clarity/model/user_profile_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class HomeViewmodel extends BaseViewModel {
  // final _profileServices = locator<ProfileServices>();
  // final _authServices = locator<FirebaseAuthenticationService>();

  List<DoctorModel> _doctorDataList;
  //     doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
  // List<DoctorModel> get doctorDataList => _doctorDataList;

  // Future<List<DoctorModel>> getDoctors() async {
  //   _doctorDataList =
  //       doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
  //   // List<DoctorModel> get doctorDataList => _doctorDataList;

  //   return _doctorDataList;
  // }

  // @override
  // Future<List<DoctorModel>> futureToRun() => getDoctors();
}
