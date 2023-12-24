import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

import 'package:f_tutorial/models/place.dart';
import 'package:f_tutorial/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

const uuid = Uuid();

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'native-app.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );
  return db;
}

class AppProvider extends ChangeNotifier {
  List<Place> _listPlace = [];

  List<Place> get listPlace {
    return _listPlace;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copyImg = await image.copy('${appDir.path}/$filename');

    // final postUrl = Uri.https(realtimeUri, 'native-app.json');
    // final resp = await https.post(postUrl,
    //     headers: {'Content-type': 'application/json'},
    //     body: json.encode({
    //       'title': title,
    //       // 'location': {
    //       //   PlaceLocationEnum.longitude: location.longitude,
    //       //   PlaceLocationEnum.latitude: location.latitude,
    //       //   PlaceLocationEnum.address: location.address,
    //       // }
    //     }));

    final newPlace = Place(
      id: uuid.v4(),
      title: title,
      image: copyImg,
      location: location,
    );
    final db = await _getDatabase();
    db.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });

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
    try {
      // final getUrl = Uri.https(realtimeUri, 'native-app.json');
      // final resp = await https.get(getUrl);
      // Map<String, dynamic> extractedData = json.decode(resp.body);
      // if (extractedData == null) {
      //   return null;
      // }
      List<Place> loadedPlaces = [];
      // final defaultImg =
      //     await getImageFileFromAssets('lib/assets/img/girl.jpg');
      // for (var item in extractedData.entries) {
      //   loadedPlaces.add(Place(
      //     id: item.key,
      //     title: item.value['title'],
      //     image: defaultImg,
      //     location: PlaceLocation(
      //         latitude: 49.232, longitude: 3213.4142, address: 'adfrqweef'),
      //     // PlaceLocation(
      //     //   latitude: '',//item.value['location'][PlaceLocationEnum.latitude],
      //     //   longitude: '',//item.value['location'][PlaceLocationEnum.longitude],
      //     //   address: '',//item.value['location'][PlaceLocationEnum.address],
      //     // ),
      //   ));
      // }
      //  TODO: use local database to load data
      final db = await _getDatabase();
      final data = await db.query('places');
      loadedPlaces = data.map(
        (row) => Place(
          id: row['id'] as String,
          title: row['title'] as String,
          image: File(row['image'] as String),
          location: PlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String),
        ),
      ).toList();

      _listPlace = loadedPlaces;
      notifyListeners();
    } catch (e) {
      Future.error(e);
    }
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await syspaths.getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
