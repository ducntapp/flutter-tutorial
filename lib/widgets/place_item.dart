import 'package:f_tutorial/models/place.dart';
import 'package:f_tutorial/screens/detail_place.dart';
import 'package:flutter/material.dart';

class PlaceItemWidget extends StatelessWidget {
  const PlaceItemWidget({super.key, required this.item});

  final Place item;

  void _onTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const PlaceDetail(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.title),
        onTap: () {
          _onTap(context);
        },
        // leading: Container(width: 24, height: 24, color: item.category?.color),
        // trailing: Text(item.quantity.toString()),
      ),
    );
  }
}
