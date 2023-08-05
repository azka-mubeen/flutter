class UserModel{
  String? uid;
  String? fullname;
  String? email;
  String? proflepic;

  UserModel({this.uid, this.fullname,this.email,this.proflepic});

  UserModel.fromMap(Map<String, dynamic> map){
    uid= map["uid"];
    fullname= map["fullname"];
    email=map["email"];
    proflepic = map["profilepic"];
  }
  Map<String, dynamic> toMap(){
    return{
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "profilepic": proflepic,
    };
  }
}
