import 'dart:math';

import 'package:clarity/UI/roomViewModel.dart';
import 'package:clarity/UI/room_user_profile.dart';
import 'package:clarity/services/participant_model.dart';
import 'package:clarity/ui_helpers/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class RoomViewMin extends HookViewModelWidget<RoomViewModel> {
  // final RoomModel room;

  RoomViewMin({
    // this.room,
    Key key,
    // this.room,
  }) : super(key: key, reactive: true);
  @override
  Widget buildViewModelWidget(BuildContext context, RoomViewModel model) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    List<Participant> x = model.data;
    // final Room room = roomsList.first;
    return GestureDetector(
      onDoubleTap: () {
        model.isOpen = false;
        model.roomBottomSheetHeight = 55.0;
      },
      child: AnimatedContainer(
        height: model.inRoom ? model.roomBottomSheetHeight : 0.0,
        width: double.infinity,
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          color: Palette.secondaryBackground,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, -2),
              blurRadius: 3,
              spreadRadius: 3,
            )
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        duration: Duration(milliseconds: 100),
        child: model.isOpen //this widget is inside of a room
            ? model.dataReady
                ? Container(
                    padding: const EdgeInsets.all(20.0),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Palette.secondaryBackground,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 12,
                          child: CustomScrollView(
                            physics: BouncingScrollPhysics(),
                            slivers: [
                              SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        model.isOpen = false;
                                        model.roomBottomSheetHeight = 55.0;
                                      },
                                      child: Center(
                                        child: Container(
                                          // padding: EdgeInsets.fromLTRB(80, 4, 0, 4),
                                          color: Colors.amber,
                                          height: 8,
                                          width: 40,
                                          child:
                                              Icon(CupertinoIcons.down_arrow),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${"room"} 🏠'.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .overline
                                              .copyWith(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 1.0,
                                              ),
                                        ),
                                        PopupMenuButton(
                                          icon: Icon(CupertinoIcons.ellipsis),
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<String>>[
                                            PopupMenuItem<String>(
                                              value: 'Value3',
                                              child: GestureDetector(
                                                onTap: () {
                                                  // model.destroyRoom(
                                                  //     model.roomModel);
                                                },
                                                child: Text('destroy room'),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                      "CLARITY TEST ROOM",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              SliverPadding(
                                padding: const EdgeInsets.all(0.0),
                                sliver: SliverGrid.count(
                                  mainAxisSpacing: 20.0,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: (itemWidth / itemHeight),
                                  //! speakers
                                  children: x
                                      .map(
                                        (e) => GestureDetector(
                                          onTap: () {
                                            // model.getParticipantProfile(
                                            //     model.roomModel, e);
                                          },
                                          child: RoomUserProfile(
                                            // imageUrl: e.imageUrl,
                                            size: 66.0,
                                            name: e.display,
                                            isNew: e.talking,
                                            isMuted: e.muted,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),

                              // const SliverPadding(
                              //   padding: EdgeInsets.only(bottom: 100.0),
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  model.hangUp();
                                  model.stopBackGroundNotificationService();
                                }, //todo hangup clean alot more than this
                                child: Container(
                                  width: 140,
                                  margin: EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.amber[200],
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "✌🏼 Leave",
                                          style: GoogleFonts.montserrat(
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 50.0),
                              model.isMicOn
                                  ? GestureDetector(
                                      onTap: () {
                                        model.muteMic();
                                        model.isMicOn = false;
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[300],
                                        ),
                                        child: const Icon(
                                          CupertinoIcons.mic_off,
                                          size: 25.0,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        model.unMuteMic();
                                        model.isMicOn = true;
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[300],
                                        ),
                                        child: const Icon(
                                          CupertinoIcons.mic,
                                          size: 25.0,
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox.shrink()
            : Container(),
      ),
    );
  }
}
