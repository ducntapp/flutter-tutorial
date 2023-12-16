import 'package:f_tutorial/models/place.dart';
import 'package:f_tutorial/screens/add_place.dart';
import 'package:f_tutorial/widgets/place_item.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Place> _placeList = [];

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _placeList.length,
      itemBuilder: (ctx, index) => PlaceItemWidget(
        item: _placeList[index],
      ),
    );

    if (_placeList.isEmpty) {
      content = const Center(
        child: Text(
          'No Places yet',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (cxt) => const AddPlace()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
