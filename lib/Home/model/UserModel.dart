class UserModel {
  String name;
  int id;
  String profileImage;
  UserModel({this.name,this.profileImage,this.id});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['username'],
        profileImage: json['profileImg'],
        id: json['id']
    );
  }
}