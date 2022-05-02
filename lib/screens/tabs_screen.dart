import 'package:flutter/material.dart';
import 'package:meals_app/screens/favorites_Screen.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';

class Screen {
  final Widget screen;
  final String title;

  const Screen({required this.screen, required this.title});
}

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsScreen({required this.favoriteMeals});
  @override
  State<TabsScreen> createState() => _TabsScreenState();

}

class _TabsScreenState extends State<TabsScreen> {
  //For bottom tabs, you need to manage list of widget/screens to display
  late List<Screen> _screens;

  int _selectedScreenIndex = 0;

  @override
  void initState() {
    _screens = [
      const Screen(
          screen: CategoriesScreen(),
          title: 'Categories'
      ),
      Screen(
          screen: FavouritesScreen(widget.favoriteMeals),
          title: 'My Favorites'
      )
    ];
    super.initState();
  }

  // Flutter with automatically give you the index of the selected tap
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Top Tabs - Need not be a stateful Widget
    // The DefaultTabController and the TabBar are automatically connected by
    // Flutter behind the scenes to work together
    // DefaultTabController will auto detect the tab selected and show its content
    // DefaultTabController will show tab selected in the TabBarView. Add the content in order
    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Deli Meals'),
    //       bottom: TabBar(
    //         indicatorColor: Theme.of(context).colorScheme.secondary,
    //         tabs: const [
    //           Tab(icon: Icon(Icons.category), text: 'Categories'),
    //           Tab(icon: Icon(Icons.star), text: 'Favorites'),
    //         ],
    //       ),
    //     ),
    //     // Number and order of elements here should match the TabBar elements
    //     body: const TabBarView(
    //       children: [
    //         // FavouritesScreen and CategoriesScreen doesn't have Scaffold because DefaultTabController will switch
    //         // between them as you select each
    //         CategoriesScreen(),
    //         FavouritesScreen(),
    //       ],
    //     ),
    //   ),
    // );
    // Bottom Tabs - Must be stateful widget

    final backgroundColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        // Seems like Flutter automatically converts this Text values to String
        title: Text(_screens[_selectedScreenIndex].title),
      ),
      drawer: MainDrawer(),
      // Number and order of elements here should match the TabBar elements
      body: _screens[_selectedScreenIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
        // FavouritesScreen and CategoriesScreen doesn't have Scaffold because DefaultTabController will switch
        // between them as you select each
          onTap: _selectScreen,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.white,
          // Tell BottomNavigation which tab is selected for colors to swap
          currentIndex: _selectedScreenIndex,
          // This adds some animation
          type: BottomNavigationBarType.fixed,
          // When you have BottomNavigationBarType.shifting, you need to add few other args on
          // the BottomNavigationBarItem (e.g. backgroundColor)
          // to get the same look (Tab background color was set to theme primary color - pink)

          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.category),
              label: 'Categories',
              backgroundColor: backgroundColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.star),
              label: 'Favorites',
              backgroundColor: backgroundColor,
            )
          ]),
    );
  }
}
