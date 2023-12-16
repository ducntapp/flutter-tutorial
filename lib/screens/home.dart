import 'dart:convert';

import 'package:f_tutorial/data/dummy.dart';
import 'package:f_tutorial/models/grocery.dart';
import 'package:f_tutorial/screens/new_item.dart';
import 'package:f_tutorial/widgets/grocery_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as https;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  String? _error;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
      'flutter-ject-default-rtdb.asia-southeast1.firebasedatabase.app',
      'shopping-app.json');
    try {
      final res = await https.get(url);
      var listData = json.decode(res.body);
      if(res.body == 'null'){
        setState(() {
          _isLoading = false;
        });
        return;
      }
      List<GroceryItem> _loadedItems = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.title == item.value['category'])
            .value;
        _loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }
      setState(() {
        _groceryItems = _loadedItems;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "something went wrong";
      });
    }
    
  }

  void handleAdd(BuildContext ctx) async {
    var data = await Navigator.of(ctx).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (data == null) {
      return;
    }

    setState(() {
      _groceryItems.add(data);
    });
  }

  void handleDelete(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final deleteUri = Uri.https(
        'flutter-ject-default-rtdb.asia-southeast1.firebasedatabase.app',
        'shopping-app/${item.id}.json');
    final res = await https.delete(deleteUri);
    if (res.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content =
        GroceryList(groceryList: _groceryItems, onDelete: handleDelete);

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

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
      body: content,
    );
  }
}
