import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/Filter.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static String routeName = '/filters';
  final Filter currentFilters;
  final Function(Filter filterData) filterHandler;

  const FiltersScreen({required this.currentFilters, required this.filterHandler});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState () {
    _glutenFree = widget.currentFilters.gluten;
    _vegetarian = widget.currentFilters.vegetarian;
    _vegan = widget.currentFilters.vegan;
    _lactoseFree = widget.currentFilters.lactose;
    super.initState();
  }


  Widget buildSwitchListTile({
    required String title,
    required String subTitle,
    required bool filterCriteria,
    required Function(bool newValue) changeHandler
  }) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      value: filterCriteria,
      onChanged: changeHandler,
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: () {
            // Set filters and pass them to main dart to be applied
            Filter filterData = Filter(
                gluten: _glutenFree,
                lactose: _lactoseFree,
                vegan: _vegan,
                vegetarian: _vegetarian
            );

            widget.filterHandler(filterData);
          })
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Adjust your meal selection',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Expanded(
              child: ListView(
                children: [
                  buildSwitchListTile(
                      title: 'Gluten Free',
                      subTitle: 'Only include gluten-free meals',
                      filterCriteria: _glutenFree,
                      changeHandler: (newValue) {
                        setState(() {
                          _glutenFree = newValue;
                        });
                      }
                  ),
                  buildSwitchListTile(
                      title: 'Vegetarian',
                      subTitle: 'Only include vegetarian meals',
                      filterCriteria: _vegetarian,
                      changeHandler: (newValue) {
                        setState(() {
                          _vegetarian = newValue;
                        });
                      }
                  ),
                  buildSwitchListTile(
                      title: 'Vegen',
                      subTitle: 'Only include vegan meals',
                      filterCriteria: _vegan,
                      changeHandler: (newValue) {
                        setState(() {
                          _vegan = newValue;
                        });
                      }
                  ),
                  buildSwitchListTile(
                      title: 'Lactose Free',
                      subTitle: 'Only include lactose-free meals',
                      filterCriteria: _lactoseFree,
                      changeHandler: (newValue) {
                        setState(() {
                          _lactoseFree = newValue;
                        });
                      }
                  ),
                ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
