import 'dart:convert';

import 'package:f_tutorial/models/place.dart';
import 'package:f_tutorial/screens/add_place.dart';
import 'package:f_tutorial/utils/index.dart';
import 'package:f_tutorial/widgets/place_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Place> _placeList = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPlaces();
  }

  void _loadPlaces() async {
    final getUri = Uri.https(
      "flutter-ject-default-rtdb.asia-southeast1.firebasedatabase.app",
      "native-app.json",
    );
    try {
      final resp = await https.get(getUri);
      var mapData = json.decode(resp.body);

      if (resp.body == null) {
        _isLoading = false;
        return;
      }

      List<Place> loadedItem = [];
      for (var item in mapData.entries) {
        loadedItem.add(Place(id: item.key,title: item.value['title']));
      }
      setState(() {
        _placeList = loadedItem;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Something wrong!";
        _isLoading = false;
      });
    }
  }

  void _addNewPlace() async {
    final backData = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (cxt) => const AddPlace(),
      ),
    );
    if (backData != null) {
      setState(() {
        _placeList.add(backData);
      });
    }
  }

  void _deletePlace(Place item) async {
    final deleteIndex = _placeList.indexOf(item);
    final deleteUri = Uri.https(
      'flutter-ject-default-rtdb.asia-southeast1.firebasedatabase.app',
      'native-app/${item.id}.json',
    );
    setState(() {
      _placeList.remove(item);
    });
    try {
      final res = await https.delete(deleteUri);
      if (res.statusCode >= 400) {
        setState(() {
          _placeList.insert(deleteIndex, item);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _placeList.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(_placeList[index].id),
        onDismissed: (direction) {
          _deletePlace(_placeList[index]);
        },
        child: PlaceItemWidget(
          item: _placeList[index],
        ),
      ),
    );

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_placeList.isEmpty) {
      content = Center(
        child: Text(
          'No Places yet',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(onPressed: _addNewPlace, icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
