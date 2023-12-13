import 'package:f_tutorial/models/grocery.dart';
import 'package:f_tutorial/widgets/grocery_item.dart';
import 'package:flutter/material.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key, required this.groceryList});

  final List<GroceryItem> groceryList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryList.length,
      itemBuilder: (ctx, index) => GroceryItemWidget(item: groceryList[index]),
    );
  }
}
