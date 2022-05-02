import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/Filter.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import 'models/meal.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Filter _filters = Filter(gluten: false, lactose: false, vegan: false, vegetarian: false);

  // Initialize available meals
  List<Meal> _availableMeals = DUMMY_MEALS;
  // Initialize favorite meals
  List<Meal> _favoriteMeals = [];

  void _setFilters(Filter filterData) {
      setState(() {
        _filters = filterData;

        // Filter available meals
        _availableMeals = DUMMY_MEALS.where((meal) {

          if(_filters.gluten && !meal.isGlutenFree) {
            return false;
          }
          if(_filters.lactose && !meal.isLactoseFree) {
            return false;
          }
          if(_filters.vegan && !meal.isVegan) {
            return false;
          }
          if(_filters.vegetarian && !meal.isVegetarian) {
            return false;
          }
          return true;
        }).toList();
      });
  }

  void _toggleFavorite(String mealId) {
    final exisingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (exisingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(exisingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.pink,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber),
          canvasColor: const Color.fromRGBO(225, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              subtitle1: const TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
              ))),
      home: TabsScreen(favoriteMeals: _favoriteMeals,),
      //initialRoute: '/', //defaults screen - same as home screen.
      // Context param is not the above BuildContext param.
      routes: {
        // Path for initialRoute
        //'/': (context) => const CategoriesScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(availableMeals: _availableMeals,),
        MealDetails.routeName: (context) => MealDetails(
          toggleFavoriteHandler: _toggleFavorite,
          isMealFavoriteHandler: _isMealFavorite,
        ),
        FiltersScreen.routeName: (context) => FiltersScreen(currentFilters: _filters, filterHandler: _setFilters,),
      },
      // Handles unregistered routes
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
      // Is reached when flutter failed to build a screen with all other measures
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      // },
    );
  }
}
