import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;

  UserModel({required this.uid, required this.email});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(uid: user.uid, email: user.email ?? '');
  }
}
// class UserModel {
//   String? email;
//   String? password;
//   String? uid;
//   String? name;
//   String? phone;

//   UserModel({this.email, this.password, this.name, this.uid, this.phone});
// }