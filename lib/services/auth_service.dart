// класс содержит все методы аутентификации
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maxfitness/domain/user_app.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
// вход в приложение
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
////////////////////////
    ///try {
    // final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: emailAddress,
//     password: password
//   );
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'user-not-found') {
//     print('No user found for that email.');
//   } else if (e.code == 'wrong-password') {
//     print('Wrong password provided for that user.');
//   }
// }

    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // возвращаем результат используя именованый конструктор
      return UserModel.fromFirebase(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      } else {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

// регистрация в приложении
  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      //
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // возвращаем результат используя именованый конструктор
      return UserModel.fromFirebase(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
// выход из приложения

  Future logOut() async {
    await _fAuth.signOut();
  }

  // поток данных о пользователях
  Stream<UserModel?> get currentUser {
    return _fAuth.authStateChanges().map(
        (User? user) => user != null ? UserModel.fromFirebase(user) : null);
  }
  //   {
  //     if (user != null) {
  //       print(user.uid);
  //     }
  //     return null;
  //   });
  // }

  // Stream<User?> get currentUser {
  //   return _fAuth.authStateChanges().listen((User? user) {
  //     if (user != null) {
  //       print(user.uid);
  //     }
  //   });
  // }
} /// video 12/24
