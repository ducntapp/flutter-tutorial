import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'package:f_tutorial/models/place.dart';
import 'package:f_tutorial/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class AppProvider extends ChangeNotifier {
  List<Place> _listPlace = [];

  List<Place> get listPlace {
    return _listPlace;
  }

  void addPlace(String title, File image) async {
    final postUrl = Uri.https(realtimeUri, 'native-app.json');
    final resp = await https.post(postUrl,
        headers: {'Content-type': 'application/json'},
        body: json.encode({'title': title}));
    final newPlace = Place(id: uuid.v4(), title: title, image: image);
    print(image);
    _listPlace = [...listPlace, newPlace];
    notifyListeners();
  }

  void deletePlace(Place place) async {
    final deleteIndex = listPlace.indexOf(place);
    final deleteUri = Uri.https(
      realtimeUri,
      'native-app/${place.id}.json',
    );
    listPlace.remove(place);
    try {
      final res = await https.delete(deleteUri);
      if (res.statusCode >= 400) {
        listPlace.insert(deleteIndex, place);
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<Place?> fetchAndSetPlace() async {
    final getUrl = Uri.https(realtimeUri, 'native-app.json');
    try {
      final resp = await https.get(getUrl);
      Map<String, dynamic> extractedData = json.decode(resp.body);
      if (extractedData == null) {
        return null;
      }
      final List<Place> loadedPlaces = [];
      final defaultImg = await getImageFileFromAssets('lib/assets/img/girl.jpg');
      for (var item in extractedData.entries) {
        loadedPlaces.add(
          Place(
              id: item.key,
              title: item.value['title'],
              image: defaultImg),
        );
      }
      _listPlace = loadedPlaces;
      notifyListeners();
    } catch (e) {
      Future.error(e);
    }
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

}
