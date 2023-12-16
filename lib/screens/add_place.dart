import 'package:flutter/material.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddPlaceState();
  }
}

class _AddPlaceState extends State<AddPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Place'),
        centerTitle: true,
      ),
      body: const Placeholder(),
    );
  }
}
