import 'package:cached_network_image/cached_network_image.dart';
import 'package:clarity/UIv2/pages/app_barViewModel.dart';
import 'package:clarity/UIv2/theme/light_color.dart';
import 'package:clarity/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:clarity/UIv2/theme/extention.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  const AppBarView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppBarViewmodel>.reactive(
      onModelReady: (model) => model.futureToRun,
      builder: (context, model, child) => model.dataReady
          ? AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).backgroundColor,
              leading: Icon(
                Icons.short_text,
                size: 30,
                color: Colors.black,
              ),
              actions: <Widget>[
                Icon(
                  Icons.notifications_none,
                  size: 30,
                  color: LightColor.grey,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  child: Container(
                    height: 30,
                    width: 36,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: customNetworkImage(model.data.photoUrl,
                        fit: BoxFit.cover),
                  ),
                ).p(8),
              ],
            )
          : loader(),
      viewModelBuilder: () => AppBarViewmodel(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
