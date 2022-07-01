import 'package:flutter/material.dart';

import '../../face_pile_plus.dart';

class UserAvatar extends StatelessWidget {
  final UserInfo user;
  final double diameter;

  late final Widget placeHolder;
  UserAvatar(
    this.user, {
    required this.diameter,
    super.key,
  }) {
    placeHolder = Text(
      ' ${user.initials} ',
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.network(
          user.avatar,
          fit: BoxFit.cover,
          frameBuilder: (_, image, loadingBuilder, __) {
            if (loadingBuilder != null) return image;
            return FittedBox(child: placeHolder);
          },
        ),
      ),
    );
  }
}
