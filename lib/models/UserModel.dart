class UserData{
  String AccessToken;
  UserData
      ({this.AccessToken});
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        AccessToken: json['token']);

  }
}