import 'dart:convert';
import 'dart:io';

import 'package:f_tutorial/models/place.dart';
import 'package:f_tutorial/store/index.dart';
import 'package:f_tutorial/utils/index.dart';
import 'package:f_tutorial/widgets/image_input.dart';
import 'package:f_tutorial/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:provider/provider.dart';

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
  File? _selectedImage;

  void _addPlace() async {
    final appState = Provider.of<AppProvider>(context, listen: false);
    // TODO: check validate
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      appState.addPlace(_placeName!, _selectedImage!);
      // // TODO: handle back
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop();
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Add Place')),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
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
              const SizedBox(height: 8),
              InputImage(onPickImage: (image){
                _selectedImage = image;
              }),
              const SizedBox(height: 8),
              LocationInput(),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _isSending ? null : _addPlace,
                label: const Text("Add place"),
                icon: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }
}
