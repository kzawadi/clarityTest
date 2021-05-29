import 'package:clarity/app/app.locator.dart';
import 'package:clarity/model/dactor_model.dart';
import 'package:clarity/services/doctors/doctor_services.dart';
import 'package:stacked/stacked.dart';

class DoctorViewModel extends StreamViewModel<List<DoctorModel>> {
  final _doctorsServices = locator<DoctorServices>();

  @override
  Stream<List<DoctorModel>> get stream {
    return _doctorsServices.listenDoctorsList();
  }
}
