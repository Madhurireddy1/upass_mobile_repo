class User {
  String? userId;
  String? date;
  String? email, cellphone, token;

  User({required this.userId, required this.email, required this.date, required this.cellphone, required this.token});

  User.fromJson(Map data) {
    this.userId = data['userId'];
    this.date = data['date'];
    this.email = data['email'];
    this.token = data['token'];
    this.cellphone = data['cellphone'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'date': date,
        'email': email,
        'token': token,
        'cellphone': cellphone,
      };
}
