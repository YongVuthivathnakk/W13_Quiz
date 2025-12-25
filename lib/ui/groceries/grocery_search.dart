import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:w13_quiz/data/mock_grocery_repository.dart';
import 'package:w13_quiz/models/grocery.dart';
import 'package:w13_quiz/ui/groceries/grocery_list.dart';

class GrocerySearch extends StatefulWidget {
  const GrocerySearch({super.key});

  @override
  State<GrocerySearch> createState() => _GrocerySearchState();
}

class _GrocerySearchState extends State<GrocerySearch> {
  final _searchController = TextEditingController();
  List<Grocery> items = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      //  Display groceries with an Item builder and  LIst Tile
      content = Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {},
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: dummyGroceryItems.length,
              itemBuilder: (context, index) =>
                  GroceryTile(grocery: dummyGroceryItems[index]),
            ),
          ),
        ],
      );
    }
    return content;
  }
}
