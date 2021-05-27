import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clarity/UIv2/pages/profile_ViewModel.dart';
import 'package:clarity/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cached_network_image/src/image_provider/cached_network_image_provider.dart';

class ProfileEditingPage extends HookWidget {
  ProfileEditingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _name = useTextEditingController();
    var _surname = useTextEditingController();

    return ViewModelBuilder<ProfileViewModel>.reactive(
      // onModelReady: (model)=>model.,
      key: key,
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          title: customTitleText('Profile Edit'),
          actions: <Widget>[
            InkWell(
              // onTap: _submitButton,
              child: Center(
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 180,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 180,
                    padding: EdgeInsets.only(bottom: 50),
                    child: customNetworkImage(
                        'https://pbs.twimg.com/profile_banners/457684585/1510495215/1500x500',
                        fit: BoxFit.fill),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: _userImage(context,
                        image: model.imagePicked, model: model),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              thickness: 3,
            ),
            _entry(context, "name", controller: _name),
            _entry(context, "surname", controller: _surname),
          ],
        ),
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }

  Widget _entry(BuildContext context, String title,
      {TextEditingController controller,
      int maxLine = 1,
      bool isenable = true}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          customText(title, style: TextStyle(color: Colors.black54)),
          TextField(
            enabled: isenable,
            controller: controller,
            maxLines: maxLine,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            ),
          )
        ],
      ),
    );
  }

  Widget _userImage(BuildContext context,
      {File image, ProfileViewModel model}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5),
        shape: BoxShape.circle,
        image: DecorationImage(
            image: customAdvanceNetworkImage(dummyProfilePic),
            fit: BoxFit.cover),
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundImage: image != null
            ? FileImage(image)
            : customAdvanceNetworkImage(dummyProfilePic),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black38,
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                model.openImage(context);
              },
              icon: Icon(Icons.camera_alt, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  dynamic customAdvanceNetworkImage(String path) {
    if (path == null) {
      path = dummyProfilePic;
    }
    return CachedNetworkImageProvider(
      path ?? dummyProfilePic,
    );
  }

  Widget customNetworkImage(String path, {BoxFit fit = BoxFit.contain}) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: path ?? dummyProfilePic,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholderFadeInDuration: Duration(milliseconds: 500),
      placeholder: (context, url) => Container(
        color: Color(0xffeeeeee),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  String dummyProfilePic =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6TaCLCqU4K0ieF27ayjl51NmitWaJAh_X0r1rLX4gMvOe0MDaYw&s';
}
