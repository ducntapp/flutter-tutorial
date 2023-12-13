import 'package:f_tutorial/models/grocery.dart';
import 'package:flutter/material.dart';

class GroceryItemWidget extends StatelessWidget {
  const GroceryItemWidget({super.key, required this.item});

  final GroceryItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        leading: Container(width: 24, height: 24, color: item.category?.color),
        trailing: Text(item.quantity.toString()),
      ),
    );
  }
}
