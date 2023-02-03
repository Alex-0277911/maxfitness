import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:maxfitness/components/active_workouts.dart';
import 'package:maxfitness/components/workouts_list.dart';
import 'package:maxfitness/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// переменная где храним индекс страницы с нижней панели BottomNavigationBar
  int sectionIndex = 1;

  @override
  Widget build(BuildContext context) {
    // нижняя панель навигации
    var curvedNavigationBar = CurvedNavigationBar(
      items: const <Widget>[
        Icon(Icons.fitness_center),
        Icon(Icons.search),
      ],
      index: sectionIndex,
      height: 50,
      color: Colors.white.withOpacity(0.5),
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.white.withOpacity(0.5),
      animationCurve: Curves.easeInOut,
      //animationDuration: const Duration(microseconds: 1000),
      onTap: (int index) {
        setState(() => sectionIndex = index);
      },
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: const Icon(Icons.fitness_center),
        title: Text(
            'MaxFit //${sectionIndex == 0 ? ' Active Workouts' : ' Find Workouts'}'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.supervised_user_circle,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              AuthService().logOut();
            },
          )
        ],
      ),
      // если sectionIndex == 0 грузим ActiveWorkouts, иначе WorkoutsList
      body: sectionIndex == 0 ? const ActiveWorkouts() : const WorkoutsList(),
      bottomNavigationBar: curvedNavigationBar,
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.fitness_center),
      //       label: 'My Workouts',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Find Workouts',
      //     ),
      //   ],
      //   currentIndex: sectionIndex,
      //   selectedItemColor: Colors.white,
      //   backgroundColor: Colors.white30,
      //   onTap: (int index) {
      //     //
      //     setState(() {
      //       sectionIndex = index;
      //     });
      //   },
      // ),
    );
  }
}
