import 'package:flutter/material.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddPlaceState();
  }
}

class _AddPlaceState extends State<AddPlace> {
  String? _placeName;

  void _addPlace() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Place'),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Add Place')),
              validator: (value) {},
              onSaved: (newValue) {
                _placeName = newValue;
              },
            ),
            ElevatedButton.icon(
              onPressed: _addPlace,
              label: const Text("Add place"),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
