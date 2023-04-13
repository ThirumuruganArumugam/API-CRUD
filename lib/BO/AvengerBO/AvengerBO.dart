import 'package:dart_json_mapper/dart_json_mapper.dart';

// Create a jsonSerializable class named AvengerBO
@jsonSerializable
class AvengerBO {

  // Declare the variable named id of type integer and make it null value
  int? id;

  // Declare the variable named name of type String and make it null value
  String? name;

  /* Create a constructor and pass the parameter id and name */
  AvengerBO({required this.id, required this.name});
}
