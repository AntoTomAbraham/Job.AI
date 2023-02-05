

class UserModel {
  int? uid;
  String? name;

  UserModel();

  UserModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    uid=json['experience'];
  }
}