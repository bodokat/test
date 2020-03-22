import 'package:equatable/equatable.dart';
import 'package:moor_flutter/moor_flutter.dart';

class Recepie extends Equatable {
  final int id;
  final String title;
  final String body;
  final Map<Ingredient, int> ingredients;

  const Recepie({@required this.id, @required this.title, @required this.body, @required this.ingredients});

  List<Object> get props => [id, title, body, ingredients];
}

class Ingredient extends Equatable {
  final int id;
  final String name;

  const Ingredient({@required this.id, @required this.name});

  List<Object> get props => [id, name];
}

class SmallRecepie extends Equatable {
  final int id;
  final String title;

  const SmallRecepie({@required this.id, @required this.title});

  List<Object> get props => [id, title];
}
