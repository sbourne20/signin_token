import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class User2 {
  User2({@required this.uid, this.nohp});
  final String uid;
  final String nohp;
}

typedef PhoneVerificationCompletedvalue = void Function(AuthCredential);
typedef PhoneVerificationFailedValue = void Function(FirebaseAuthException);
typedef CodeSentValue = void Function(String verificationId,
    [int forceResendingToken]);

abstract class Auth3Base {
  Stream<User2> get onAuthChanged;
  Future<void> retrieveOTP(String valueHP);
  Future<User2> signInWithPhoneNumber(
      {String valueOTP, String valueHP, String actualCode});
  Future<void> signOut();
  Future<User2> signInWithToken({String token});
}

class Auth3 implements Auth3Base {
  Auth3({
    this.verificationCompleted,
    this.verficationException,
    this.codeSent,
  });
  final PhoneVerificationCompletedvalue verificationCompleted;
  final PhoneVerificationFailedValue verficationException;
  final CodeSentValue codeSent;

  @override
  Stream<User2> get onAuthChanged {
    return FirebaseAuth.instance.authStateChanges().map(_userFromFirebase);
  }

  User2 _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return User2(uid: user.uid, nohp: user.phoneNumber);
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      //onSignOut();
    } catch (e) {
      print("error logout : " + e.toString());
    }
  }

  @override
  Future<void> retrieveOTP(String valueHP) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: valueHP,
        timeout: Duration(seconds: 60),
        verificationCompleted: (authCredentials) =>
            verificationCompleted(authCredentials),
        verificationFailed: (authException) =>
            verficationException(authException),
        codeSent: (String verificationId, [int forceResendingToken]) =>
            codeSent(verificationId, forceResendingToken),
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  @override
  Future<User2> signInWithToken({String token}) async {
    await FirebaseAuth.instance
        .signInWithCustomToken(token)
        .then((value) => print(value.user.uid));
  }

  @override
  Future<User2> signInWithPhoneNumber(
      {String valueOTP,
      String valueHP,
      String actualCode,
      AuthCredential authCredential}) async {
    AuthCredential _authCredential;
    if (valueOTP != null)
      _authCredential = PhoneAuthProvider.credential(
          verificationId: actualCode, smsCode: valueOTP);
    else
      _authCredential = authCredential;

    try {
      UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(_authCredential);

      return _userFromFirebase(authResult.user);
    } catch (e) {
      print("error sign in : " + e.toString());
      rethrow;
    }
  }
}
