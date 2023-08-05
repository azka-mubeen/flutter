class chatRoomModel{
  String? chatroomid;
  List<String>? participants;

  chatRoomModel({this.chatroomid, this.participants});

  chatRoomModel.fromMap(Map<String, dynamic> map){
    chatroomid = map["chatroomid"];
    participants= map["participants"];
  }
  Map<String, dynamic> toMap(){
    return{
      "chatroomid": chatroomid,
      "participants": participants,
    };
  }
}