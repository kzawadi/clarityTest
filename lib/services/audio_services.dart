import 'dart:async';
import 'dart:math';

import 'package:clarity/app/app.locator.dart';
import 'package:clarity/services/participant_model.dart';
import 'package:clarity/services/server.dart';
import 'package:clarity/services/user_model.dart';
import 'package:clarity/services/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:janus_client/JanusClient.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pretty_json/pretty_json.dart';

// import 'package:manenotest/utils/dev_utils.dart';

class Audio {
  JanusClient j;
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();
  JanusSession session;
  JanusPlugin pluginHandle;
  RestJanusTransport rest;
  WebSocketJanusTransport ws;
  MediaStream remoteStream;
  MediaStream myStream;
  List<Participant> participants = [];
  // static final CollectionReference _roomsCollection =
  //     kfirestore.collection(ROOMS_COLLECTION);
  // static final CollectionReference _userCollection =
  //     kfirestore.collection(USERS_COLLECTION);

  final _auth = locator<FirebaseAuthenticationService>();
  // final _profileData = locator<ProfileServices>();
  final _bottomSheetService = locator<BottomSheetService>();

  // final _profile = locator<ProfileServices>();

  // final int roomNumber = 9999;
  final int audio_active_packets = 100;
  final int audio_level_average = 60; //55
  final int sampling_rate = 16000;
  final bool audiolevel_ext = true;
  final bool audiolevel_event = true;

  final PublishSubject<List<Participant>> _participantController =
      PublishSubject<List<Participant>>();

  UserModel _res;
  UserModel get participantProfile => _res;

  int randomRoomId;
  int randomUid;

  Stream<List<Participant>> listenToparticipants() {
    return _participantController.stream;
  }

  Future initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> createRoom() async {
    // rest = RestJanusTransport(url: servermap['onemandev_master_rest']);
    ws = WebSocketJanusTransport(url: servermap['clarity']);
    j = JanusClient(
      // withCredentials: true,
      // apiSecret: "SecureIt",
      transport: ws,
      iceServers: [
        RTCIceServer(
            url: "stun:stun1.l.google.com:19302", username: "", credential: "")
      ],
    );
    session = await j.createSession();
    cprint("Session ID",
        event: 'voilla! connection established with session id as' +
            session.sessionId.toString());
    pluginHandle = await session.attach(JanusPlugins.AUDIO_BRIDGE);
    await pluginHandle.initializeMediaDevices(
        mediaConstraints: {"audio": true, "video": false});

    // generateRoomId();
    generateUid();

    // roomroom.request = "create";
    // roomroom.sampling_rate = sampling_rate;
    // roomroom.audio_active_packets = audio_active_packets;
    // roomroom.audio_level_average = audio_level_average;
    // roomroom.audiolevel_ext = audiolevel_ext;
    // roomroom.audiolevel_event = audiolevel_event;
    // roomroom.is_private = false;
    // roomroom.permanent = false;
    // roomroom.room = randomRoomId;
    cprint("The Room NUmber Generated is $randomRoomId");
    cprint("The userId NUmber Generated is $randomUid");
    // var naMe = _profileData.userProfile.displayName;

    var createRoom = {
      "request": "create",
      "room": randomRoomId,
      "audiolevel_event": true,
      "audiolevel_ext": true,
      // "audio_active_packets":100
      "audio_level_average": 60
    };

    var join = {
      "request": "join",
      "room": randomRoomId,
      "display":
          _auth.firebaseAuth.currentUser.displayName ?? "clarity App user",
      'fec': true,
      "id": randomUid
      // "audio_level_average": audio_level_average,
      // "audio_active_packets": audio_active_packets,
    };
    // cprint(prettyJson(roomroom, indent: 2));

    // var register = {"request": "join", "room": 1234, "display": 'shivansh'};
    await pluginHandle.send(data: createRoom).whenComplete(
      () async {
        await pluginHandle.send(data: join);
        // .whenComplete(() {
        //     // listParticipants();
        //   });
        //   kfirestore
        //       .collection(ROOMS_COLLECTION)
        //       .doc(roomroom.room.toString())
        //       .set(roomroom.toMap());

        //   kfirestore
        //       .collection(ROOMS_COLLECTION)
        //       .doc(roomroom.room.toString())
        //       .collection("participants")
        //       .doc(randomUid.toString())
        //       .set({"id": _auth.firebaseAuth.currentUser.uid});
        // });

        pluginHandle.remoteStream.listen((event) {
          _remoteRenderer.srcObject = event;
        });
        pluginHandle.messages.listen(
          (msg) async {
            cprint('voilaa event');
            // cprint(msg.event.toString());
            cprint(prettyJson(msg.event, indent: 2));
            if (msg.event['plugindata'] != null) {
              if (msg.event['plugindata']['data'] != null) {
                var data = msg.event['plugindata']['data'];

                if (data['audiobridge'] == 'participants') {
                  var participant = data['participants'];
                  if (participant is List && participant != null) {
                    var temp = participant.map((element) {
                      return Participant(
                          id: element['id'],
                          display: element['display'],
                          setup: element['setup'],
                          muted: element['muted'],
                          talking: element['talking']);
                    }).toList();
                    temp.forEach((element) {
                      var existingIndex = participants
                          .indexWhere((eleme) => eleme.id == element.id);
                      if (existingIndex > -1) {
                        participants[existingIndex] = element;
                      } else {
                        participants.add(element);
                      }
                      // _participantController.add(participants);
                    });
                    _participantController.add(participants);
                  }
                }
                if (data['audiobridge'] == 'joined') {
                  RTCSessionDescription offer = await pluginHandle.createOffer(
                      offerToReceiveVideo: false, offerToReceiveAudio: true);
                  var publish = {"request": "configure"};
                  await pluginHandle.send(data: publish, jsep: offer);
                  var participant = data['participants'];
                  if (participant is List && participant != null) {
                    var temp = participant.map((element) {
                      return Participant(
                          id: element['id'],
                          display: element['display'],
                          setup: element['setup'],
                          muted: element['muted'],
                          talking: element['talking']);
                    }).toList();
                    temp.forEach((element) {
                      var existingIndex = participants
                          .indexWhere((eleme) => eleme.id == element.id);
                      if (existingIndex > -1) {
                        participants[existingIndex] = element;
                      } else {
                        participants.add(element);
                      }
                      // _participantController.add(participants);
                    });
                    _participantController.add(participants);
                  }
                }
                if (data['audiobridge'] == 'event') {
                  var participant = data['participants'];
                  if (participant is List && participant != null) {
                    var temp = participant.map((element) {
                      return Participant(
                        id: element['id'],
                        display: element['display'],
                        setup: element['setup'],
                        muted: element['muted'],
                        talking: element['talking'],
                      );
                    }).toList();
                    temp.forEach((element) {
                      var existingIndex = participants
                          .indexWhere((eleme) => eleme.id == element.id);
                      if (existingIndex > -1) {
                        participants[existingIndex] = element;
                      } else {
                        participants.add(element);
                      }
                      // _participantController.add(participants);
                    });
                    _participantController.add(participants);
                    // print(participants.first.toString());
                  }
                  if (data['leaving'] != null) {
                    participants.removeWhere(
                        (element) => element.id == data['leaving']);
                    _participantController.add(participants);
                  }
                }

                if (data['audiobridge'] == 'talking') {
                  var existing = participants
                      .indexWhere((element) => element.id == data['id'] as num);
                  cprint("talking data");
                  var t = data['id'].toString();
                  cprint(t);
                  if (existing > -1) {
                    participants[existing].talking = true;
                    cprint("now printing the start t changed member");
                    // cprint(prettyJson(participants[existing]).toString());
                  }
                  _participantController.add(participants);
                }
                if (data['audiobridge'] == 'stopped-talking') {
                  var existing = participants
                      .indexWhere((element) => element.id == data['id'] as num);
                  cprint("STOP talking data");
                  var t = data['id'].toString();
                  cprint(t);
                  if (existing > -1) {
                    participants[existing].talking = false;
                    cprint("now printing the Stop t changed member");
                  }
                  _participantController.add(participants);
                }
              }
            }
            if (msg.jsep != null) {
              print('got remote jsep');
              await pluginHandle.handleRemoteJsep(msg.jsep);
            }
          },
        );
      },
    );
  }

  void closeNotification() async {
    // await ForegroundService.stopForegroundService();
  }

  void disposeRenders() async {
    await _localRenderer.dispose();
    await _remoteRenderer.dispose();
  }

  void listParticipants() async {
    var k = {
      // "janus": "message",
      // "transaction": "list room Ids",
      // "body": {
      "request": "listparticipants",
      // "room": rNum, //todo change to dynamically
      // }
    };

    pluginHandle.send(data: k);
  }

  Future<void> adminAudioControl() async {
    var _publish = {
      "request": "<mute|unmute, whether to mute or unmute>",
      "secret": "<room secret, mandatory if configured>",
      "room": "<unique numeric ID of the room>",
      "id": "<unique numeric ID of the participant to mute|unmute>",
    };
    pluginHandle.send(data: _publish);
  }

  ///this changes a user to another room without tearing the rtc and peer connections to the server
  Future<void> changeRoom() async {
    var _publish = {
      "request": "changeroom",
      "room": "<numeric ID of the room to move to>,",
      "id":
          "<unique ID to assign to the participant; optional, assigned by the plugin if missing>",
      "display": "<display name to have in the room; optional>",
      "token": "<invitation token, in case the new room has an ACL; optional>",
      "muted": "<true|false, whether to start unmuted or muted>",
      "quality":
          "<0-10, Opus-related complexity to use, lower is higher quality; optional, default is 4>",
    };

    pluginHandle.send(data: _publish);
  }

  Future<void> leaveRoom() async {
    var _publish = {
      "request": "leave",
    };
    pluginHandle.send(data: _publish);
    cprint("Leave ROOM ", event: "leaved from room::");
    // this.closeNotification();
    disposeRenders();
    // stopForegroundNotification();
  }

  Future<void> hangUp() async {
    pluginHandle.hangup();
    disposeRenders();
    // stopForegroundNotification();
    // this.closeNotification();
  }

  Future<void> muteMic() async {
    var _publish = {"request": "configure", "muted": true};
    pluginHandle.send(data: _publish);
  }

  // Future<void> destroyRoom(RoomModel room) async {
  //   var _publish = {
  //     "request": "destroy",
  //     // "room": rNum,
  //     // "permanent": true,
  //   };
  //   pluginHandle.send(data: _publish).whenComplete(() {
  //     kfirestore
  //         .collection(ROOMS_COLLECTION)
  //         .doc(room.room.toString())
  //         .delete()
  //         .then((value) {
  //       cprint("deleted a room after a destroy command was given",
  //           event: "delete firebase room entry");
  //     });
  //     disposeRenders();
  //     stopForegroundNotification();
  //   });
  // }

  Future<void> unMuteMic() async {
    var _publish = {"request": "configure", "muted": false};
    pluginHandle.send(data: _publish);
  }

  Future<void> kickOut() async {
    var _publish = {
      "request": "kick",
      "room": "", //todo pass dynamicaly room and Id
      "id": ""
    };

    pluginHandle.send(data: _publish);
  }

  ///This generate a random 6 digits ID for a janus room participant
  ///[```warning```] remember to run this before using the variables.
  generateUid() {
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    var random = Random();
    randomRoomId = random.nextInt(max - min);
    randomUid = random.nextInt(max - min);
    if (randomUid >= randomRoomId) randomUid += 1;
  }

  ///This function fetches the Id of room participant through join and or create
  ///and then get a firebase uid..
  // void fetchProfiles(RoomModel room, Participant x) {
  //   var t = kfirestore
  //       .collection(ROOMS_COLLECTION)
  //       .doc(room.room.toString())
  //       .collection("participants")
  //       .doc(x.id.toString());
  //   var r = t.get();
  //   r.then(
  //     (value) async {
  //       var id = value["id"];
  //       cprint("The ID of the participant used to fetch profile");
  //       cprint(prettyJson(value["id"]), event: "id fetching");
  //       DocumentSnapshot documentSnapshot = await _userCollection.doc(id).get();

  //       if (documentSnapshot.data() != null) {
  //         _res = UserModel.fromJson(documentSnapshot.data());
  //         cprint(prettyJson(_res));
  //         // _bottomSheetService.showBottomSheet(
  //         //     title: _res.displayName, description: _res.bio);
  //         _bottomSheetService.showCustomSheet(
  //           variant: BottomSheetType.profile,
  //           title: "Profile",
  //           description: _res.bio,
  //           imageUrl: _res.profilePic,
  //         );
  //       }
  //     },
  //   );
  // }

  // Future<void> followUser() async {}

  // void maybeStartFGS() async {
  //   ///if the app was killed+relaunched, this function will be executed again
  //   ///but if the foreground service stayed alive,
  //   ///this does not need to be re-done
  //   if (!(await ForegroundService.foregroundServiceIsStarted())) {
  //     await ForegroundService.setServiceIntervalSeconds(5);

  //     //necessity of editMode is dubious (see function comments)
  //     await ForegroundService.notification.startEditMode();

  //     await ForegroundService.notification.setTitle("Maneno");
  //     await ForegroundService.notification
  //         .setText("Maneno room going on: ${DateTime.now()}");
  //     await ForegroundService.notification
  //         .setPriority(AndroidNotificationPriority.LOW);

  //     await ForegroundService.notification.finishEditMode();

  //     await ForegroundService.startForegroundService(
  //         foregroundServiceFunction());
  //     await ForegroundService.getWakeLock();
  //     await ForegroundService.setContinueRunningAfterAppKilled(false);
  //   }

  //   ///this exists solely in the main app/isolate,
  //   ///so needs to be redone after every app kill+relaunch
  //   await ForegroundService.setupIsolateCommunication((data) {
  //     debugPrint("main received: $data");
  //   });
  // }

  // foregroundServiceFunction() {
  //   debugPrint("The current time is: ${DateTime.now()}");
  //   ForegroundService.notification
  //       .setText("Maneno room going on: ${DateTime.now()}");

  //   if (!ForegroundService.isIsolateCommunicationSetup) {
  //     ForegroundService.setupIsolateCommunication((data) {
  //       debugPrint("bg isolate received: $data");
  //     });
  //   }

  //   ForegroundService.sendToPort("message from bg isolate");
  // }

  // void stopForegroundNotification() {
  //   cprint("killing notification");
  //   ForegroundService.stopForegroundService();
  // }

}
