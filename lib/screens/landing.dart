import 'package:flutter/material.dart';
import 'package:maxfitness/domain/user_app.dart';
import 'package:maxfitness/screens/auth_screen.dart';
import 'package:maxfitness/screens/home.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // из провайдера извлекаем данные User
    final UserModel? user = Provider.of<UserModel?>(context);
    // переменная для идентификации пользователь вошел в приложение или нет
    // final bool isLoggedIn = user != null;
    final bool isLoggedIn = user != null;
    return isLoggedIn ? const HomePage() : const AuthorizationPage();
  }
}
