import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recepies/entities/recepie.dart';
import 'package:recepies/model/recepie_store.dart';

class RecepieDetails extends StatelessWidget {
  final Recepie recepie;
  const RecepieDetails(this.recepie, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _store = GetIt.I<RecepieStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text(recepie.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              var shouldDelete = await showConfirmDialog(context, "Delete This Recepie?");
              if (shouldDelete) {
                _store.deleteRecepie(recepie);
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Text(
            "Ingredients",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ...recepie.ingredients.entries
              .map((entry) => Row(children: <Widget>[
                    Expanded(
                        child: Text(
                      entry.key.name,
                      overflow: TextOverflow.ellipsis,
                    )),
                    Container(
                      child: Text(entry.value.toString()),
                      width: 64,
                    ),
                  ]))
              .toList(),
          Expanded(
            child: Text(recepie.body),
          ),
        ],
      ),
    );
  }
}

Future<bool> showConfirmDialog(BuildContext context, String title) => showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ));
