import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mine/app/routes/app_pages.dart';
import 'package:mine/main.dart';
import 'package:mine/utils/app_key_storage.dart';

class AuthService {
  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {
        box.write(StorageKeys.uid, value.user!.uid);
        log("USER UID : ${value.user!.uid}");
        FirebaseFirestore.instance.collection("users").doc(value.user!.uid).set(
            {"id":value.user!.uid,"name":email,"showId":[]});
      });
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {
        box.write(StorageKeys.uid, value.user!.uid);
      });
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      box.erase();
      Get.offAllNamed(Routes.WELCOME);
      return "Signed out";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }
}