import 'package:flutter/material.dart';
import 'package:maxfitness/domain/user_app.dart';
import 'package:maxfitness/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  // _emailController - переменная где хранится котроллер редактирования текста
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // в переменных храним текст который вводит пользователь в поля
  String _email = '';
  String _password = '';
  // в переменной храним булевое, что отображать в форме,
  // поле логина или поле регистрации, если логин такой уже есть, то выводим
  // поле ЛОГИН, т.е зайти иначе выводи форму регистрации
  bool showLogin = true;

  // обьявляем сервис аутентификации
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // создаем виджет для отображения лого
    Widget logo() {
      return const Padding(
        padding: EdgeInsets.only(top: 100),
        child: Align(
          child: Text(
            'M A X F I T',
            style: TextStyle(
                fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    }

    // создаем виджет формы для входа, т.е. одного поля ввода (логина либо пароля)
    // входные параметры ИКОНКА для отображения в поле формы, текст подсказки,
    // контроллер редактирования и булевое значение нужно ли скрывать текст при вводе
    Widget input(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          // контроллер редактирования текста
          controller: controller,
          // нужно ли отображать вводимые символы
          obscureText: obscure,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              // стиль текстовой подсказки
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white30),
              // отображение подсказки
              hintText: hint,
              // стиль рамки когда форма ввода активна, т.е. имеет фокус ввода
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3)),
              // стиль рамки когда форма ввода НЕактивна, т.е. НЕимеет фокуса ввода
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1)),
              // иконка для формы ввода
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                  data: const IconThemeData(color: Colors.white),
                  child: icon,
                ),
              )),
        ),
      );
    }

    // виджет кннопки: передаем 2 параметра нтекст надписи на кнопке и
    // какую функцию выполнить при нажатии на кнопку
    Widget button(String text, void Function() func) {
      //
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          overlayColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
        ),
        onPressed: () {
          func();
        },
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      );
    }

    // создаем виджет для отображения формы входа или авторизации
    // при вызове передаем 2 параметра: строка с надписью на кнопке и функция
    Widget form(String label, void Function() func) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: input(
                const Icon(Icons.email), 'E M A I L', _emailController, false),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: input(const Icon(Icons.lock), 'P A S S W O R D',
                _passwordController, true),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: button(label, func),
            ),
          ),
        ],
      );
    }

    // функция входа в приложение
    void loginButtonAction() async {
      //  в переменную кидаем содержимое поля ввода, через контроллер тестового поля
      _email = _emailController.text;
      _password = _passwordController.text;

      // простая проверка, если поля пустые то просто выходим
      if (_email.isEmpty || _password.isEmpty) return;

      // вызываем метод из аутентификационного сервиса
      UserModel? user = await _authService.signInWithEmailAndPassword(
          _email.trim(), _password.trim());

      // проверяем ответ от сервиса аутентификации, если поле user null
      // выводим сообщение иначе обнуляем поля ввода
      if (user == null) {
        // выводим сообщение
        Fluttertoast.showToast(
            msg: 'Can`t SignIn you! Please check your email/password',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        // очищаем содержимое контроллеров и форм
        _emailController.clear();
        _passwordController.clear();
      }
    }

    // функция регистрации в приложении
    void registerButtonAction() async {
      //  в переменную кидаем содержимое поля ввода, через контроллер тестового поля
      _email = _emailController.text;
      _password = _passwordController.text;

      // простая проверка, если поля пустые то просто выходим
      if (_email.isEmpty || _password.isEmpty) return;

      // вызываем метод из аутентификационного сервиса
      UserModel? user = await _authService.registerWithEmailAndPassword(
          _email.trim(), _password.trim());

      // проверяем ответ от сервиса аутентификации, если поле user null
      // выводим сообщение иначе обнуляем поля ввода
      if (user == null) {
        // выводим сообщение
        Fluttertoast.showToast(
            msg: 'Can`t register you! Please check your email/password',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        // очищаем содержимое контроллеров и форм
        _emailController.clear();
        _passwordController.clear();
      }
    }

    Widget bottomWave() {
      return Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              color: Colors.white,
              height: 300,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: <Widget>[
          logo(),
          const SizedBox(
            height: 100,
          ),
          // проверяем переменную showLogin time 34.39
          (showLogin
              ? Column(
                  children: [
                    form('L O G I N', loginButtonAction),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        child: const Text(
                          'Not registered yet? Register!',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            // изменяем значение переменной showLogin
                            showLogin = false;
                          });
                        },
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    form('R E G I S T E R', registerButtonAction),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        child: const Text(
                          'Already registered? Login!',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            // изменяем значение переменной showLogin
                            showLogin = true;
                          });
                        },
                      ),
                    ),
                  ],
                )),
          bottomWave(),
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
