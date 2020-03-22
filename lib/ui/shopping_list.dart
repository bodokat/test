import 'package:flutter/material.dart';
import 'package:recepies/entities/recepie.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList(this.list, {Key key}) : super(key: key);
  final Map<Ingredient, int> list;

  @override
  Widget build(BuildContext context) {
    final entries = list.entries.toList(growable: false);
    return Container(
        child: ListView.builder(
      itemBuilder: (_, i) => ListTile(
        title: Text("${entries[i].value} ${entries[i].key.name}"),
      ),
      itemCount: entries.length,
    ));
  }
}
