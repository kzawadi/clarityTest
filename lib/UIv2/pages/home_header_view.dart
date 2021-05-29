import 'package:clarity/UIv2/pages/app_barViewModel.dart';
import 'package:clarity/UIv2/pages/home_headerViewModel.dart';
import 'package:clarity/UIv2/theme/text_styles.dart';
import 'package:clarity/app/app.locator.dart';
import 'package:clarity/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:clarity/UIv2/theme/extention.dart';
import 'package:pretty_json/pretty_json.dart';

import 'package:stacked/stacked.dart';

class HomeHeaderView extends StatelessWidget {
  const HomeHeaderView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeHeaderViewModel>.reactive(
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      onModelReady: (model) => model.futureToRun,
      builder: (context, model, child) {
        cprint(prettyJson(model.data) + "This is the Data");
        return model.dataReady
            ? Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Hello,", style: TextStyles.title.subTitleColor),
                    Text(model.data.firstName ?? "name",
                        style: TextStyles.h1Style),
                  ],
                ).p16,
              )
            : loader();
      },
      viewModelBuilder: () => locator<HomeHeaderViewModel>(),
    );
  }
}
