import 'package:flutter/material.dart';
import 'package:maxfitness/domain/workout.dart';

class WorkoutsList extends StatefulWidget {
  const WorkoutsList({super.key});

  @override
  State<WorkoutsList> createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutsList> {
// при инициализации очищаем фильтра
  @override
  void initState() {
    clearFilter();
    super.initState();
  }

  // создаем СПИСОК (LIST) воркаутов
  final workouts = <Workout>[
    // создаем тестовый воркаут для наполнения приложения
    Workout(
        title: 'Test1',
        author: 'Max1',
        description: 'Test workaut 1',
        level: 'Beginner'),
    Workout(
        title: 'Test2',
        author: 'Max2',
        description: 'Test workaut 2',
        level: 'Intermediate'),
    Workout(
        title: 'Test3',
        author: 'Max3',
        description: 'Test workaut 3',
        level: 'Advanced'),
    Workout(
        title: 'Test4',
        author: 'Max4',
        description: 'Test workaut 4',
        level: 'Beginner'),
    Workout(
        title: 'Test5',
        author: 'Max5',
        description: 'Test workaut 5',
        level: 'Intermediate'),
  ];

// переменные фильтров
  var filterOnlyMyWorkouts = false;
  var filterTitle = '';
  // контроллер редактирования текста filterTitle
  var filterTitleController = TextEditingController();
  var filterLevel = 'Any Level';
// переменная хранит общую строку фильтрации
  var filterText = '';
// высота выпадающего списка поиска
  var filterHeight = 0.0;

  List<Workout> filter() {
    setState(() {
      filterText = filterOnlyMyWorkouts ? 'My Workouts' : 'All workouts';
      filterText += '/$filterLevel';
      debugPrint(filterTitle);
      if (filterTitle.isNotEmpty) filterText += '/$filterTitle';
      filterHeight = 0.0;
    });

    var list = workouts;
    return list;
  }

  List<Workout> clearFilter() {
    setState(() {
      filterText = 'All workouts / Any Level';
      filterOnlyMyWorkouts = false;
      filterTitle = '';
      filterLevel = 'Any Level';
      filterTitleController.clear();
      filterHeight = 0.0;
    });

    var list = workouts;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var workoutsListView = Expanded(
      child: ListView.builder(
          // задаем количество элементов списка
          itemCount: workouts.length,
          // наполняем список элементами
          itemBuilder: (context, index) {
            // для каждого элемента index создаем элемент списка Card
            return Card(
              // поднятие карточки элемента
              elevation: 2.0,
              // задаем отступы
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              // содержимое карточки элемента
              child: Container(
                // decoration
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(50, 65, 85, 0.9)),
                // элемент списка
                child: ListTile(
                  // отступы
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  // отображается СЛЕВА (перед) основным сожержимым
                  leading: Container(
                    // отступ ТОЛЬКО справа
                    padding: const EdgeInsets.only(right: 12),
                    // добавляем разделитель между элементами
                    decoration: const BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(width: 1, color: Colors.white24))),
                    // содержимое
                    child: Icon(Icons.fitness_center,
                        color: Theme.of(context).textTheme.titleLarge!.color),
                  ),
                  // основное содержимое
                  title: Text(
                    workouts[index].title,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.titleLarge!.color,
                        fontWeight: FontWeight.bold),
                  ),
                  // содержимое строки под основной надписью
                  subtitle: subtitle(context, workouts[index]),
                  // после содержимого добавляем иконку (СЛЕВА)
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Theme.of(context).textTheme.titleLarge!.color),
                ),
              ),
            );
          }),
    );

    var filterInfo = Container(
      margin: const EdgeInsets.only(top: 3, left: 7, right: 7, bottom: 5),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
      height: 40,
      child: ElevatedButton(
        child: Row(
          children: <Widget>[
            const Icon(Icons.filter_list),
            Text(
              filterText,
              style: const TextStyle(),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            filterHeight = (filterHeight == 0.0 ? 280.0 : 0.0);
          });
        },
      ),
    );

    // выпадающий список типов воркаутов по уровню
    var levelMenuItems = <String>[
      'Any Level',
      'Beginner',
      'Intermediate',
      'Advanced'
    ].map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    var filterForm = AnimatedContainer(
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 7.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      height: filterHeight,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Expanded(
                flex: 1,
                child: SwitchListTile(
                    title: const Text('Only My Workouts'),
                    value: filterOnlyMyWorkouts,
                    onChanged: (bool val) =>
                        setState(() => filterOnlyMyWorkouts = val)),
              ),
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Level'),
                  items: levelMenuItems,
                  value: filterLevel,
                  onChanged: (val) => setState(() => filterLevel = val!),
                ),
              ),
              TextFormField(
                controller: filterTitleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (val) => setState(() => filterTitle = val),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () => filter(),
                      child: const Text('Apply',
                          style: TextStyle(color: Colors.white)),
                      // color
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () => clearFilter(),
                      child: const Text('Clear',
                          style: TextStyle(color: Colors.white)),
                      // color
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return Column(
      children: [
        filterInfo,
        filterForm,
        workoutsListView,
      ],
    );
  }
}

// создаем отдельный виджет для отображения подстроки
Widget subtitle(BuildContext context, Workout workout) {
  // создает дефолтную переменную цвета (т.е. цвет по умолчанию)
  var color = Colors.grey;
  // цифровой параметр индикатор сложности (по умолчанию НОЛЬ)
  double indicatorLevel = 0;

  // создаем процедуру перебора параметров
  switch (workout.level) {
    // если уровень Beginner то переменной цвета присваиваем ЗЕЛЕНЫЙ
    case 'Beginner':
      color = Colors.green;
      indicatorLevel = 0.33;
      break;
    // если уровень Intermediate то переменной цвета присваиваем ЖЕЛТЫЙ
    case 'Intermediate':
      color = Colors.yellow;
      indicatorLevel = 0.66;
      break;
    // если уровень Advanced то переменной цвета присваиваем КРАСНЫЙ
    case 'Advanced':
      color = Colors.red;
      indicatorLevel = 1.0;
      break;
  }
  // возвращаем виджет в виде строки с несколькими элементами
  return Row(
    children: <Widget>[
      Expanded(
        // количество ЧАСТЕЙ занимаемого экрана
        flex: 1,
        // индикатор прогресса
        child: LinearProgressIndicator(
          // цвет индикатора берем с темы приложения
          backgroundColor: Theme.of(context).textTheme.titleLarge!.color,
          // величина на индикаторе
          value: indicatorLevel,
          // цвет прогресса берем с переменной цвет, и отображаем без анимации
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      // 2-й элемент для отображения
      Expanded(
        // количество ЧАСТЕЙ занимаемого экрана
        flex: 3,
        child: Text(workout.level,
            style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge!.color)),
      )
    ],
  );
}
