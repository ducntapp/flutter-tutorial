import 'dart:convert';

import 'package:f_tutorial/models/place.dart';
import 'package:f_tutorial/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class AddPlace extends StatefulWidget {
  const AddPlace({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddPlaceState();
  }
}

class _AddPlaceState extends State<AddPlace> {
  String? _placeName;
  bool _isSending = false;
  final _formKey = GlobalKey<FormState>();

  void _addPlace() async {
    final addUri = Uri.https(realtimeUri, "native-app.json");
    // TODO: check validate
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      try {
        final resp = await https.post(
          addUri,
          headers: {
            'Content-type': "application/json",
          },
          body: json.encode(
            {'title': _placeName},
          ),
        );

        // TODO: handle back
        if (!context.mounted) {
          return;
        }
        Navigator.of(context).pop(Place(title: _placeName!));
      } catch (e) {
        print(e);
      }
    }
    setState(() {
      _isSending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Add Place')),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
              validator: (value) {
                if (value == null || value.trim().length <= 1) {
                  return 'Must be more than 1 character';
                }
                return null;
              },
              onSaved: (newValue) {
                _placeName = newValue;
              },
            ),
            ElevatedButton.icon(
              onPressed: _isSending ? null : _addPlace,
              label: const Text("Add place"),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
