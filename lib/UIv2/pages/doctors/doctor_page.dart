import 'dart:math';

import 'package:clarity/UIv2/pages/doctors/doctor_ViewModel.dart';
import 'package:clarity/UIv2/theme/light_color.dart';
import 'package:clarity/UIv2/theme/text_styles.dart';
import 'package:clarity/app/app.locator.dart';
import 'package:clarity/model/dactor_model.dart';
import 'package:clarity/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:clarity/UIv2/theme/extention.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoctorViewModel>.reactive(
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      onModelReady: (model) => model.stream,
      builder: (context, model, child) => SliverList(
        delegate: SliverChildListDelegate(
          [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Top Doctors", style: TextStyles.title.bold),
                IconButton(
                        icon: Icon(
                          Icons.sort,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {})
                    .p(12)
                    .ripple(() {},
                        borderRadius: BorderRadius.all(Radius.circular(20))),
              ],
            ).hP16,
            model.dataReady
                ? model.data == null
                    ? Center(child: Text("no data"))
                    : getdoctorWidgetList(context, model)
                : loader()
          ],
        ),
      ),
      viewModelBuilder: () => locator<DoctorViewModel>(),
    );
  }

  Widget getdoctorWidgetList(BuildContext context, DoctorViewModel model) {
    List<DoctorModel> v = model.data;
    return Column(
        children: v.map((x) {
      return _doctorTile(context, x);
    }).toList());
  }

  Widget _doctorTile(BuildContext context, DoctorModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: randomColor(context),
              ),
              child: customNetworkImage(
                model.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(model.name, style: TextStyles.title.bold),
          subtitle: Text(
            model.type,
            style: TextStyles.bodySm.subTitleColor.bold,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ).ripple(() {
        Navigator.pushNamed(context, "/DetailPage", arguments: model);
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  Color randomColor(BuildContext context) {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }
}
