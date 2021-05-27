import 'dart:io';

import 'package:clarity/app/app.locator.dart';
import 'package:clarity/model/user_profile_model.dart';
import 'package:clarity/services/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class ProfileServices {
  final _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();
  static final CollectionReference _userCollection =
      kfirestore.collection("profiles");

  final _picker = ImagePicker();
  String imageUrl;

  Future<void> openImagePicker(
      BuildContext context, Function onImageSelected) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 120,
            padding: EdgeInsets.all(17),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Use Camera',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        onPressed: () async {
                          getImage(
                              context, ImageSource.camera, onImageSelected);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Use Gallery',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        onPressed: () async {
                          getImage(
                              context, ImageSource.gallery, onImageSelected);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  Future<void> getImage(
      BuildContext context, var source, Function onImageSelected) async {
    await _picker.getImage(source: source, imageQuality: 80).then((var x) {
      onImageSelected(File(x.path));
      Navigator.pop(context);
    });
  }

  Future<void> _uploadProfileToDb(
      {@required UserProfileModel userProfileModel}) async {
    userProfileModel.uuid = _firebaseAuthenticationService.currentUser.uid;

    await _userCollection
        .doc(userProfileModel.uuid)
        .set(userProfileModel.toMap());
    cprint("uploading User Profile data to DB", event: "firebase connection");
  }

  /// `Update user` profile and create a profile
  Future<void> updateUserProfile({UserProfileModel user, File image}) async {
    await deleteProfilePic(user).whenComplete(
      () async {
        //todo do i realy need a whencomplete
        if (image != null) {
          var storageReference = FirebaseStorage.instance
              .ref()
              .child('users/profile/${Path.basename(image.path)}');
          await storageReference.putFile(image);

          storageReference.getDownloadURL().then(
            (fileURL) async {
              cprint(fileURL);
              // imageUrl = fileURL;
              user.photoUrl = fileURL;
              // createUser(user);
              await _uploadProfileToDb(userProfileModel: user);
            },
          );
        } else
          await _uploadProfileToDb(userProfileModel: user);

        // logEvent('update_user');
      },
    );
  }

  ///provide this to delete a user dp
  Future<void> deleteProfilePic(UserProfileModel user) async {
    if (user.photoUrl != null) {
      var _storageReference = FirebaseStorage.instance;
      var _photoToDelete = _storageReference.refFromURL(user.photoUrl);
      await _photoToDelete.delete();
      cprint("DELETING profile photo", event: "deleting dp");
    } else
      cprint("user profile photo url not available to delete",
          event: "Delete profile");
  }
}
