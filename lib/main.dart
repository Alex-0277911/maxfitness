import 'package:flutter/material.dart';
import 'package:maxfitness/domain/user_app.dart';
import 'package:maxfitness/screens/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maxfitness/services/auth_service.dart';
import 'package:provider/provider.dart';

// void main() => runApp(const MaxFitApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaxFitApp());
}

class MaxFitApp extends StatelessWidget {
  const MaxFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        title: 'Max Fitness',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(50, 65, 85, 1),
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.white),
          ),
        ),
        //home: const HomePage(),
        home: const LandingPage(),
      ),
    );
  }
}

//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire
//       future: Firebase.initializeApp(),
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return SomethingWentWrong();
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return MyAwesomeApp();
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return Loading();
//       },
//     );
//   }
// }
