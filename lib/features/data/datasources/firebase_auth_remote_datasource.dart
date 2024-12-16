import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<UserEntity> logInWithEmailAndPassword(String email, String password);
  Future<void> logOut();
  Future<UserEntity> logInWithGoogle();
  Future<UserEntity> registerWithEmail(
      String email, String password); // Метод для регистрации
  Future<void> resetPassword(String email); // Метод для сброса пароля
}

class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  FirebaseAuthRemoteDataSourceImpl(this.firebaseAuth, this.googleSignIn);

  @override
  Future<UserEntity> logInWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    if (user != null) {
      return UserEntity(uid: user.uid, email: user.email);
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserEntity> logInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google sign-in aborted');
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user != null) {
      return UserEntity(uid: user.uid, email: user.email);
    } else {
      throw Exception('Google authentication failed');
    }
  }

  @override
  Future<UserEntity> registerWithEmail(String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    if (user != null) {
      return UserEntity(uid: user.uid, email: user.email);
    } else {
      throw Exception('Registration failed');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    final status = await firebaseAuth
        .sendPasswordResetEmail(email: email)
        .catchError((error) => print(error.message + ": " + error.code));
  }
}
