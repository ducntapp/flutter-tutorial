import 'dart:io';

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;
}

enum PlaceLocationEnum {
  latitude,
  longitude,
  address,
}

class Place {
  Place({
    this.id,
    required this.title,
    required this.image,
    required this.location,
  });
  final String? id;
  final String title;
  final File image;
  final PlaceLocation location;
}
