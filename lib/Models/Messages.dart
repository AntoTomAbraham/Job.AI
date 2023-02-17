class Messages{
  String? message;
  DateTime? createdAT;
  String? uid;
  Messages({this.message,this.createdAT,this.uid});
  static Messages fromJson(Map<String, dynamic> json) => Messages(
    uid: json['uid'],
    message: json['message'],
    createdAT: json['createdAT']
  );
  Map<String,dynamic> toJson() => {
    'uid': uid,
    'message': message,
    'createdAT': createdAT
  };
}