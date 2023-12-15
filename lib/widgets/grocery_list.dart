import 'package:f_tutorial/models/grocery.dart';
import 'package:f_tutorial/widgets/grocery_item.dart';
import 'package:flutter/material.dart';

class GroceryList extends StatelessWidget {
  const GroceryList(
      {super.key, required this.groceryList, required this.onDelete});

  final List<GroceryItem> groceryList;
  final void Function(GroceryItem item) onDelete;

  @override
  Widget build(BuildContext context) {
    return groceryList.isEmpty
        ? const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text('No items yet!'),
              )
            ],
          )
        : ListView.builder(
            itemCount: groceryList.length,
            itemBuilder: (ctx, index) => Dismissible(
                onDismissed: (direction) {
                  onDelete(groceryList[index]);
                },
                key: ValueKey(groceryList[index].id),
                child: GroceryItemWidget(item: groceryList[index])),
          );
  }
}
