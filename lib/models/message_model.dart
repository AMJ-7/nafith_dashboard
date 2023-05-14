class MessageModel{
  dynamic content ;
  dynamic dateTime ;
  dynamic email ;
  dynamic sender ;


  MessageModel({
    this.content,
    this.email,
    this.dateTime,
    this.sender,
});

  MessageModel.fromJson(Map<String , dynamic>? json){
    content = json!['content'];
    email = json['email'];
    dateTime = json['dateTime'];
    sender = json['sender'];
  }

  Map<String , dynamic> toMap(){
    return {
      'content' : content,
      'email' : email ,
      'dateTime' : dateTime ,
      'sender' : sender ,
    };
  }
}