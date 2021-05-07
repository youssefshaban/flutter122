class GroupModel {
  int id,created_by;
  String created_at,name,overview;
  GroupModel({this.id,this.name,this.created_at,this.created_by,this.overview});
  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
        name: json['name'],
        id: json['id'],
        created_at: json['created_at'],
        overview: json['overview'],
        created_by: json['created_by'],
    );
  }
}