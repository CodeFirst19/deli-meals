import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {

  // Builder methods are useful for reusable code - Write once use many
  Widget buildListTile ({required IconData icon, required String title, required VoidCallback tapHandler}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            padding: const EdgeInsets.all(20),
            // Alignment controls how the child of the container is aligned inside the container
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile(icon: Icons.restaurant, title: 'Meals', tapHandler: () {
            // pushReplacementNamed and pushReplacement removes previous pages from the stack
            // This means you won't get the 'Back' button because there is/are no pages to go back to
            // We used this because we want to clean the stack after navigating,
            // otherwise the stack will accumulate more pages for every navigation
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile(icon: Icons.settings, title: 'Filters', tapHandler: () {
            // pushReplacementNamed and pushReplacement removes previous pages from the stack
            // This means you won't get the 'Back' button because there is/are no pages to go back to
            // We used this because we want to clean the stack after navigating
            // otherwise the stack will accumulate more pages for every navigation
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          })
        ],
      ),
    );
  }
}
