import 'dart:convert';

import 'package:f_tutorial/models/place.dart';
import 'package:f_tutorial/screens/add_place.dart';
import 'package:f_tutorial/store/index.dart';
import 'package:f_tutorial/utils/index.dart';
import 'package:f_tutorial/widgets/place_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Place> _placeList = [];
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    _loadPlaces();
    super.initState();
  }

  void _loadPlaces() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<AppProvider>(context, listen: false)
        .fetchAndSetPlace()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _addNewPlace() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (cxt) => const AddPlace(),
      ),
    );
  }

  void _deletePlace(Place item) async {
    Provider.of<AppProvider>(context, listen: false).deletePlace(item);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppProvider>(context);
    Widget content = ListView.builder(
      itemCount: appState.listPlace.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          _deletePlace(appState.listPlace[index]);
        },
        child: PlaceItemWidget(
          item: appState.listPlace[index],
        ),
      ),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (appState.listPlace.isEmpty) {
      content = Center(
        child: Text(
          'No Places yet',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your place'),
        actions: [
          IconButton(onPressed: _addNewPlace, icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
