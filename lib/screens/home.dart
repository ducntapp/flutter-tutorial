import 'package:f_tutorial/data/dummy.dart';
import 'package:f_tutorial/screens/new_item.dart';
import 'package:f_tutorial/widgets/grocery_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void handleAdd(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () => handleAdd(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: GroceryList(groceryList: groceryItems),
    );
  }
}
