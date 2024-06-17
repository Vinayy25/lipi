import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn().catchError((onError) {
        print(onError);
      });
      // if(googleSignInAccount == null) print("returned null here");
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        final UserCredential? userCredential =
            await _firebaseAuth.signInWithCredential(authCredential);
        final User? user = userCredential?.user;
        print(user?.email ?? "no email");

        if (userCredential?.additionalUserInfo?.isNewUser == true) {
          print('reached to this point ');
        }
      } else {
        await _googleSignIn.signOut();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updatePassword(String password) async {
    await _firebaseAuth.currentUser?.updatePassword(password);
  }

  Future<void> updateUserData(
      String name, String email, String photoURL) async {
    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid)
        .set({
      'name': name,
      'email': email,
      'photoURL': photoURL,
      'lastSeen': DateTime.now(),
    });
  }

  Future<String> getNgrokUrl() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore.collection('ngrok_URLs').doc('test@gmail.com').get();
    return documentSnapshot.data()!['url'];
  }
}
