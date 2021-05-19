import 'package:clarity/UI/user_profile_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomUserProfile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double size;
  final bool isNew;
  final bool isMuted;

  const RoomUserProfile({
    Key key,
    this.imageUrl =
        "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    this.name,
    this.size = 48.0,
    this.isNew,
    this.isMuted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // height: 110.5,
          padding: const EdgeInsets.all(6.0),
          child: UserProfileImage(imageUrl: imageUrl, size: size),
        ),
        if (isMuted)
          Positioned(
            right: 22,
            bottom: 55,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(
                CupertinoIcons.mic_slash_fill,
                size: 18,
              ),
            ),
          ),
        Positioned(
          left: 14,
          bottom: 30,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        isNew == null
            ? SizedBox.shrink()
            : !isNew
                ? SizedBox.shrink()
                : Positioned(
                    bottom: 0,
                    left: 13,
                    child: Container(
                      child: Text("talking"),
                    ))
      ],
    );
  }
}
