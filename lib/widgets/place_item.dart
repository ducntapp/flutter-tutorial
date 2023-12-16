import 'package:f_tutorial/models/place.dart';
import 'package:flutter/material.dart';

class PlaceItemWidget extends StatelessWidget {
  const PlaceItemWidget({super.key, required this.item});

  final Place item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.title),
        // leading: Container(width: 24, height: 24, color: item.category?.color),
        // trailing: Text(item.quantity.toString()),
      ),
    );
  }
}
