import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:recepies/data/database.dart';
import 'package:recepies/model/ingredient_store.dart';
import 'model/recepie_store.dart';
import 'ui/home.dart';

void main() {
  final db = MyDatabase();
  GetIt.I.registerSingleton(RecepieStore(db));
  GetIt.I.registerSingleton(IngredientStore(db));
  runApp(MaterialApp(
    title: "Rezepte App",
    home: Home(),
    theme: ThemeData.dark(),
  ));
}
