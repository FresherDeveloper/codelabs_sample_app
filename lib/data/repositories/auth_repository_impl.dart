import 'package:coinone_sample_app/data/data_sources/firebase_auth_data_source.dart';
import 'package:coinone_sample_app/domain/entities/user.dart';
import 'package:coinone_sample_app/domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;

  AuthRepositoryImpl(this.firebaseAuthDataSource);

  @override
  Future<User> signIn(String email, String password) async {
    final user = await firebaseAuthDataSource.signIn(email, password);
    return User(uid: user.uid, email: user.email!);
  }
  @override
  Future<User> signUp(String email, String password) async {
  //  return await firebaseAuthDataSource.signUp(email, password);
  final user = await firebaseAuthDataSource.signUp(email, password);
    return User(uid: user.uid, email: user.email!);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuthDataSource.signOut();
  }
}
