
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.users,
  });

  List<User> users;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    users: json["users"] == null ? [] : List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.email,
    required this.username,
  });

  int id;
  String firstName;
  String email;
  String username;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? "",
    firstName: json["firstName"] ?? "",
    email: json["email"] ?? "",
    username: json["username"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "email": email,
    "username": username,
  };
}
