import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

class ProfileServices {
  final _picker = ImagePicker();

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
}
