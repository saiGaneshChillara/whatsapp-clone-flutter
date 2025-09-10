class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;
  final String phoneNumber;
  final List<String> groupId;

  UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isOnline,
    required this.groupId,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "profilePic": profilePic,
    "isOnline": isOnline,
    "groupId": groupId,
    "phoneNumber": phoneNumber,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? "",
      uid: map['uid'] ?? "",
      profilePic: map['profilePic'] ?? "",
      isOnline: map['isOnline'] ?? false,
      groupId: List<String>.from(map['groupId']),
      phoneNumber: map['phoneNumber'] ?? "",
    );
  }
}
