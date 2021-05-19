import 'package:clarity/main.dart';
import 'package:clarity/startup/startup_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

// UI CODE ONLY

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      disposeViewModel: false,
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Palette.appBackgroundColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // SizedBox(
              //   width: 300,
              //   height: 100,
              //   child: Image.asset('assets/images/icon_large.png'),
              // ),
              CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(
                  Palette.green,
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
