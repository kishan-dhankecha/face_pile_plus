import 'package:flutter/material.dart';

import './models/user_info.dart';
import 'widgets/animated_entry_exit_widget.dart';
import 'widgets/user_avatar.dart';

class FacePile extends StatefulWidget {
  final List<UserInfo> users;
  final double diameter;
  final double overlapPercentage;
  const FacePile({
    Key? key,
    required this.users,
    this.overlapPercentage = 0.2,
    this.diameter = 48.0,
  }) : super(key: key);

  @override
  State<FacePile> createState() => _FacePileState();
}

class _FacePileState extends State<FacePile> {
  final _visibleUsers = <UserInfo>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _syncUsersWithPile();
    });
  }

  @override
  void didUpdateWidget(FacePile oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _syncUsersWithPile();
    });
  }

  void _syncUsersWithPile() {
    setState(() {
      final newUsers = widget.users.where(
        (user) => _visibleUsers.where((visibleUser) {
          return visibleUser == user;
        }).isEmpty,
      );

      _visibleUsers.addAll(newUsers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final usersCount = _visibleUsers.length;
      double visibleAvatar = 1.0 - widget.overlapPercentage;

      late final double intrinsicWidth;
      if (usersCount > 1) {
        // If more then one user exists than the width
        // will be one full user dimension plus
        // the other partially visible user dimension.
        intrinsicWidth =
            (1 + (visibleAvatar * (usersCount - 1))) * widget.diameter;
      } else {
        // or else it will be same as the dimension
        intrinsicWidth = widget.diameter;
      }

      late final num offset;

      if (intrinsicWidth > constraints.maxWidth) {
        offset = 0;
        visibleAvatar =
            ((constraints.maxWidth / widget.diameter) - 1) / (usersCount - 1);
      } else {
        offset = (constraints.maxWidth - intrinsicWidth) / 2;
      }

      return SizedBox(
        height: widget.diameter,
        child: Stack(
          children: [
            for (var i = 0; i < usersCount; i++)
              AnimatedPositioned(
                key: ValueKey<int>(_visibleUsers[i].hashCode),
                left: offset + (i * visibleAvatar * widget.diameter),
                top: 0,
                width: widget.diameter,
                height: widget.diameter,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: AnimatedEntryExitWidget(
                  showFace: widget.users.contains(_visibleUsers[i]),
                  dimension: widget.diameter,
                  onDisappear: () {
                    setState(() => _visibleUsers.removeAt(i));
                  },
                  child: UserAvatar(
                    _visibleUsers[i],
                    diameter: widget.diameter,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
