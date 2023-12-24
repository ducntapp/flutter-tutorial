import 'package:f_tutorial/models/place.dart';
import 'package:f_tutorial/screens/detail_place.dart';
import 'package:flutter/material.dart';

class PlaceItemWidget extends StatelessWidget {
  const PlaceItemWidget({super.key, required this.item});

  final Place item;

  void _onTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PlaceDetail(place: item),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.title),
        subtitle: Text(
          item.location.address,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        onTap: () {
          _onTap(context);
        },
        leading: CircleAvatar(
          backgroundImage: FileImage(item.image),
          radius: 24,
        ),
        // trailing: Text(item.quantity.toString()),
      ),
    );
  }
}
