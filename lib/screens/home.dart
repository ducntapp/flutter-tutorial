
import 'package:f_tutorial/models/grocery.dart';
import 'package:f_tutorial/screens/new_item.dart';
import 'package:f_tutorial/widgets/grocery_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<GroceryItem> _groceryItems = [];


  void handleAdd(BuildContext ctx) async {
    final newItem = await Navigator.of(ctx).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if(newItem == null){
      return;
    }

    setState((){
      _groceryItems.add(newItem);
    });
  }

  void handleDelete(GroceryItem item){
    setState((){
      _groceryItems.remove(item);
    });
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
      body: GroceryList(groceryList: _groceryItems, onDelete: handleDelete),
    );
  }
}
