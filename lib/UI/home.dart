import 'package:clarity/UI/roomViewModel.dart';
import 'package:clarity/UI/room_view_widgetv1.dart';
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
              body: Stack(
                children: [
                  Container(
                    child: Text("waiting"),
                  ),
                  RoomView(),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: model.createRoom,
              ),
            ),
        viewModelBuilder: () => RoomViewModel());
  }
}
