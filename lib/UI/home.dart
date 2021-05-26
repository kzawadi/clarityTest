import 'package:clarity/UI/roomViewModel.dart';
import 'package:clarity/UI/room_view_widget.dart';
import 'package:clarity/UI/widgets/bottom_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoomViewModel>.reactive(
        onModelReady: (model) => model.stream,
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text("CLARITY"),
                elevation: 0,
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset("assets/clarity.png"),
                    ),
                  ),
                ],
              ),
              body: Center(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: RoomViewMin(),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  model.createRoom();
                  if (!model.isOpen) {
                    model.isOpen = true;
                    model.roomBottomSheetHeight =
                        MediaQuery.of(context).size.height / 1.086;
                  }
                },
              ),
              bottomNavigationBar: BottomMenuBar(),
            ),
        viewModelBuilder: () => RoomViewModel());
  }
}
