import 'dart:ffi';

import 'package:clarity/model/dactor_model.dart';
import 'package:clarity/services/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:rxdart/rxdart.dart';

class DoctorServices {
  final PublishSubject<List<DoctorModel>> _doctorsListController =
      PublishSubject<List<DoctorModel>>();

  static final CollectionReference _doctorsCollection =
      kfirestore.collection("doctors");

  List<DoctorModel> _doctorslist = [];

  Stream<List<DoctorModel>> listenDoctorsList() {
    getDoctors();
    return _doctorsListController.stream;
  }

  Future<void> getDoctors() async {
    //todo remember to limit fetch GCP bill will be huge
    await _doctorsCollection.get().then(
      (value) {
        value.docs.forEach(
          (e) {
            var t = DoctorModel.fromJson(e.data());
            _doctorslist.add(t);
            cprint("doctor added to list");
          },
        );
        // return null;
      },
    );
    _doctorsListController.add(_doctorslist);
    cprint("${_doctorslist.length}  Number of doctors fetched from database");
  }
}
