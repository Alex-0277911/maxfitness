// внутренний клас пользователя приложения
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  // создаем именованый конструктор
  UserModel.fromFirebase(User user) {
    id = user.uid;
  }
}
