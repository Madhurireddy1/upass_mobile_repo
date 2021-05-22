class User {
  String? userId;
  String? date;
  String? email, cellphone;

  User(
      {required this.userId,
      required this.email,
      required this.date,
      required this.cellphone});

  User.fromJson(Map data) {
    this.userId = data['userId'];
    this.date = data['date'];
    this.email = data['email'];
    this.cellphone = data['cellphone'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'date': date,
        'email': email,
        'cellphone': cellphone,
      };
}
