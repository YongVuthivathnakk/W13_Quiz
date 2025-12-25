import 'package:flutter/material.dart';
import 'package:w13_quiz/ui/groceries/grocery_search.dart';
import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';
import 'grocery_form.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

enum GroceryTab { groceriesTab, searchTab }

class _GroceryListState extends State<GroceryList> {
  GroceryTab _currentTab = GroceryTab.groceriesTab;

  void onCreate() async {
    // Navigate to the form screen using the Navigator push
    Grocery? newGrocery = await Navigator.push<Grocery>(
      context,
      MaterialPageRoute(builder: (context) => const GroceryForm()),
    );
    if (newGrocery != null) {
      setState(() {
        dummyGroceryItems.add(newGrocery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      //  Display groceries with an Item builder and  LIst Tile
      content = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (context, index) =>
            GroceryTile(grocery: dummyGroceryItems[index]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: onCreate, icon: const Icon(Icons.add))],
      ),
      body: IndexedStack(
        index: _currentTab.index,
        children: [content, GrocerySearch()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab.index,
        selectedItemColor: Colors.blue.shade300,
        onTap: (index) {
          setState(() {
            _currentTab = GroceryTab.values[index];
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Groceries",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        ],
      ),
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(width: 15, height: 15, color: grocery.category.color),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
