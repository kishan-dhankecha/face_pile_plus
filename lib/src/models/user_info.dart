/// [UserInfo] will be used for creating the face pile.
class UserInfo {
  /// This field can be useful for making each user unique.
  late final String id;

  /// [initials] is used for Initials of the user.
  /// This is for showing the Initials while loading the image from network.
  late final String initials;

  /// The User's profile-image or avatar-image network url.
  final String avatar;

  UserInfo({
    required String name,
    required this.avatar,
  }) {
    id = '${name.hashCode ^ avatar.hashCode}';
    assert(name.isNotEmpty, "Field \"name\" must not be an empty String.");
    final splicedName = name.toUpperCase().split(" ");
    if (splicedName.length == 1) {
      initials = splicedName.first[0];
    } else {
      initials = splicedName.getRange(0, 2).fold("", (pv, e) => pv += e[0]);
    }
  }
}
