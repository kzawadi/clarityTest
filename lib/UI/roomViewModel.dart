import 'package:clarity/app/app.locator.dart';
import 'package:clarity/model/dactor_model.dart';
import 'package:clarity/model/data.dart';
import 'package:clarity/services/audio_services.dart';
import 'package:clarity/services/utility.dart';
import 'package:stacked/stacked.dart';

class RoomViewModel extends StreamViewModel {
  final _audioServices = locator<Audio>();

  bool _isToggle = false;
  bool _isEnter = false;
  bool _isOpen = false;
  bool _isMicOn =
      false; //mic togle/.//todo remember if the user start a room he/she is not muted
  bool _inRoom = false;
  double _roomBottomSheetHeight = 55.0;

  double get roomBottomSheetHeight => _roomBottomSheetHeight;

  bool get isToggle => _isToggle;
  bool get isEnter => _isEnter;
  bool get isOpen => _isOpen;
  bool get inRoom => _inRoom;
  bool get isMicOn => _isMicOn;

  // List<DoctorModel> _doctorDataList =
  //     doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
  // List<DoctorModel> get doctorDataList => _doctorDataList;

  @override
  Stream get stream => _audioServices.listenToparticipants();

  void createRoom() {
    _audioServices
        .initRenderers()
        .whenComplete(() => _audioServices.createRoom());
    cprint("create room clicked");
  }

  stopBackGroundNotificationService() {
    // _audioServices.stopForegroundNotification();
  }

  changeRoom() {
    _audioServices.changeRoom();
  }

  adminAudioControl() {
    _audioServices.adminAudioControl();
  }

  // destroyWebRTC() {
  //   _audioServices.destroyWebRTC().then(
  //     (value) {
  //       inRoom = false;
  //     },
  //   );
  // }

  muteMic() {
    _audioServices.muteMic();
  }

  unMuteMic() {
    _audioServices.unMuteMic();
    // _audioServices.getId();
  }

  listParticipants() {
    _audioServices.listParticipants();
  }

  leaveRoom() {
    _audioServices.leaveRoom().then((value) {
      inRoom = false;
      isOpen = false;
    });
  }

  hangUp() {
    _audioServices.hangUp().then((value) {
      inRoom = false;
      isOpen = false;
    });
  }

  stopNotification() {
    _audioServices.closeNotification();
  }

  // destroyRoom(RoomModel roomModel) {
  //   _audioServices.destroyRoom(roomModel);
  // }

  toggle() {
    // _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.end);
    // _isToggle = !_isToggle;
    // notifyListeners();
    // cprint("toggle");
  }

  set isOpen(bool x) {
    _isOpen = x;
    notifyListeners();
  }

  set inRoom(bool x) {
    _inRoom = x;
    notifyListeners();
  }

  set isMicOn(bool z) {
    _isMicOn = z;
    notifyListeners();
  }

  // set roomModell(RoomModel c) {
  //   _roomModell = c;
  //   notifyListeners();
  // }

  // void goToRoomView(RoomModel room) {
  //   _nagivationService.navigateTo(Routes.roomScreen,
  //       arguments: RoomScreenArguments(room: room));
  // }

  // void goToProfile() {
  //   _nagivationService.navigateTo(Routes.profilePage);
  // }

  set roomBottomSheetHeight(var x) {
    cprint("$_roomBottomSheetHeight".toString());
    _roomBottomSheetHeight = x;
    notifyListeners();
    cprint("changeheight");
    cprint("$_roomBottomSheetHeight".toString());
  }
}
