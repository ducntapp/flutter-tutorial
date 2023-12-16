import 'package:uuid/uuid.dart';

const uuid = Uuid();
class Place {
  Place({this.id, required this.title});
  final String? id;
  final String title;
}
