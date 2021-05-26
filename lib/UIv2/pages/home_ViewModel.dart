import 'package:clarity/model/dactor_model.dart';
import 'package:clarity/model/data.dart';
import 'package:stacked/stacked.dart';

class HomeViewmodel extends FutureViewModel<List<DoctorModel>> {
  List<DoctorModel> _doctorDataList;
  //     doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
  // List<DoctorModel> get doctorDataList => _doctorDataList;

  Future<List<DoctorModel>> getDoctors() async {
    _doctorDataList =
        doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
    // List<DoctorModel> get doctorDataList => _doctorDataList;

    return _doctorDataList;
  }

  @override
  Future<List<DoctorModel>> futureToRun() => getDoctors();
}
