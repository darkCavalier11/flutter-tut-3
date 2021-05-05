import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';

import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meal';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  // *triggered when all widgets are initiaized and
  // *context are available here
  // *here the purpose of _loadInitData is to
  // *stop override of setState that used to remove meals
  // *so to stop it running multiple time
  // *we used this variable
  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      displayedMeals = DUMMY_MEALS
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere(
        (meal) => meal.id == mealId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // extracting data arguments provided for this page

    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        // better performance in ListView.builder
        // for building items that present on
        // a list
        // here it is categoryMeals
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            final meal = displayedMeals[index];
            return MealItem(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              duration: meal.duration,
              complexity: meal.complexity,
              affordability: meal.affordability,
              removeItem: _removeMeal,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
