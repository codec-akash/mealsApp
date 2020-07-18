import 'package:flutter/material.dart';
import 'package:meals/Pages/categiories_meal_pages.dart';
import 'package:meals/Pages/categoriesPage.dart';
import 'package:meals/Pages/filterScreen.dart';
import 'package:meals/Pages/mealDetailPage.dart';
import 'package:meals/Pages/bottomTabsScreen.dart';
import 'package:meals/dummy_data.dart';

import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filter = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favouriteMeals = [];

  void _setFilter(Map<String, bool> _filterData) {
    setState(() {
      _filter = _filterData;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (_filter['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filter['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filter['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filter['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavourite(String mealId) {
    final existingIndex =
        favouriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool isMealFavourite(String mealId) {
    return favouriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meals",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Railway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CaterigoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreenBottom(favouriteMeals),
        CategoryMealsPage.routeName: (ctx) => CategoryMealsPage(availableMeals),
        MealDetailPage.routeName: (ctx) =>
            MealDetailPage(isMealFavourite, toggleFavourite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filter, _setFilter),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if(settings.name == '/meal-details'){
        //   return ...;
        // }
        // return MaterialPageRoute(
        //
        //   builder: (ctx) => CaterigoriesScreen(),
        // );
      },
      //When no routes are defined but are , such as 404 page.
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CaterigoriesScreen(),
        );
      },
    );
  }
}
