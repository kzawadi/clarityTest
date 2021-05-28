import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserProfileModel {
  String firstName;
  String surname;

  ///This is the firebase id
  String uuid;
  String photoUrl;
  // List<String> interests;
  UserProfileModel({
    this.firstName,
    this.surname,
    this.uuid,
    this.photoUrl,
  });

  UserProfileModel copyWith({
    String firstName,
    String surname,
    String uuid,
    String photoUrl,
  }) {
    return UserProfileModel(
      firstName: firstName ?? this.firstName,
      surname: surname ?? this.surname,
      uuid: uuid ?? this.uuid,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'surname': surname,
      'uuid': uuid,
      'photoUrl': photoUrl,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserProfileModel(
      firstName: map['firstName'],
      surname: map['surname'],
      uuid: map['uuid'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileModel(firstName: $firstName, surname: $surname, uuid: $uuid, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserProfileModel &&
        o.firstName == firstName &&
        o.surname == surname &&
        o.uuid == uuid &&
        o.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        surname.hashCode ^
        uuid.hashCode ^
        photoUrl.hashCode;
  }
}
