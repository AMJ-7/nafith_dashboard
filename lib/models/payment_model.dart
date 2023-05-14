class PaymentModel{
  dynamic amount ;
  dynamic dateTime ;
  dynamic uId ;



  PaymentModel({
    this.dateTime,
    this.amount,
    this.uId,
  });

  PaymentModel.fromJson(Map<String , dynamic>? json){
    uId = json!['uId'];
    amount = json['amount'];
    dateTime = json['dateTime'];
  }

  Map<String , dynamic> toMap(){
    return {
      'uId' : uId,
      'amount' : amount ,
      'dateTime' : dateTime
    };
  }
}