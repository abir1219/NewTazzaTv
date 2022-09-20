import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethodes {
  final FirebaseAuth _auth;
  FirebaseAuthMethodes(this._auth);

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            print("New User");
            print(userCredential.user);
          } else {
            print("Old User");
            print(userCredential.user);
          }
        } else {
          print("Login Canceled");
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);

      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          print("New User");
          print(userCredential.user);
        } else {
          print("Old User");
          print(userCredential.user);
        }
      } else {
        print("Login Canceled");
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
