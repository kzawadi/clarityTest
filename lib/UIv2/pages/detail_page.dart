import 'package:clarity/UIv2/pages/profile_ViewModel.dart';
import 'package:clarity/UIv2/theme/light_color.dart';
import 'package:clarity/UIv2/theme/text_styles.dart';
import 'package:clarity/UIv2/theme/theme.dart';
import 'package:clarity/UIv2/widgets/headerWidget.dart';
import 'package:clarity/UIv2/widgets/progress_widget.dart';
import 'package:clarity/UIv2/widgets/rating_start.dart';
import 'package:clarity/UIv2/widgets/settingsRowWidget.dart';
import 'package:clarity/model/dactor_model.dart';
import 'package:clarity/UIv2/theme/extention.dart';
import 'package:clarity/theme/images.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return ViewModelBuilder<ProfileViewModel>.reactive(
      onModelReady: (model) => model.futureToRun,
      builder: (context, model, child) => Scaffold(
        backgroundColor: LightColor.extraLightBlue,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: <Widget>[
              Image.network(
                model.dummyProfilePic,
                fit: BoxFit.cover,
              ),
              DraggableScrollableSheet(
                maxChildSize: .8,
                initialChildSize: .6,
                minChildSize: .6,
                builder: (context, scrollController) {
                  return Container(
                    height: AppTheme.fullHeight(context) * .5,
                    padding: EdgeInsets.only(
                        left: 19,
                        right: 19,
                        top: 16), //symmetric(horizontal: 19, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Martha",
                                  style: titleStyle,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.check_circle,
                                    size: 18,
                                    color: Theme.of(context).primaryColor),
                                Spacer(),
                                // RatingStar(
                                //   rating: model.rating,
                                // )
                              ],
                            ),
                            subtitle: Text(
                              "Kamwela",
                              style: TextStyles.bodySm.subTitleColor.bold,
                            ),
                          ),
                          Divider(
                            thickness: .3,
                            color: LightColor.grey,
                          ),
                          // Divider(
                          //   thickness: .3,
                          //   color: LightColor.grey,
                          // ),
                          // Text("Settings", style: titleStyle).vP16,
                          Divider(
                            thickness: .4,
                            color: LightColor.grey,
                          ),
                          HeaderWidget(
                            "My Settings",
                            // secondHeader: true,
                          ),
                          SettingRowWidget(
                            "Account",
                            subtitle: "edit my profile",
                            // navigateTo: 'AccountSettingsPage',
                            onPressed: model.navigateToEdit,
                          ),

                          Divider(height: 0),
                          SettingRowWidget("Privacy and Policy",
                              navigateTo: 'PrivacyAndSaftyPage'),

                          SettingRowWidget(
                            "About Clarity",
                            subtitle: "version 0.0.1_alpha_unreleased",
                            navigateTo: "AboutPage",
                          ),
                          SettingRowWidget(
                            "Log out",
                            subtitle: "You can't use the app when loged out",
                            onPressed: () {},
                            textColor: Colors.red,
                            navigateTo: "login page",
                          ),
                          SettingRowWidget(
                            null,
                            showDivider: false,
                            vPadding: 10,
                            subtitle:
                                'These settings affect all of your Clarity accounts on this devce.',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // _appbar(context),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
