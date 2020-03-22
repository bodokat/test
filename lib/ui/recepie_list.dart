import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'package:recepies/model/recepie_store.dart';

import 'package:recepies/entities/recepie.dart';

import 'package:recepies/ui/recepie_details.dart';

class RecepieList extends StatelessWidget {
  final List<SmallRecepie> recepies;
  RecepieList(this.recepies, {Key key}) : super(key: key);

  final _store = GetIt.I<RecepieStore>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recepies.length,
      itemBuilder: (context, i) {
        var recepie = recepies[i];

        return RecepieCard(recepie, _store.selected);
      },
    );
  }
}

class RecepieCard extends StatelessWidget {
  RecepieCard(this.recepie, this.selected, {Key key}) : super(key: key);

  final SmallRecepie recepie;
  final ObservableSet<SmallRecepie> selected;
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => ListTile(
              title: Text(recepie.title),
              trailing: Checkbox(
                value: selected.contains(recepie),
                onChanged: (newValue) => newValue ? selected.add(recepie) : selected.remove(recepie),
              ),
              onTap: () => !selected.contains(recepie) ? selected.add(recepie) : selected.remove(recepie),
              onLongPress: () => GetIt.I<RecepieStore>()
                  .getFullRecepie(recepie)
                  .then((r) => Navigator.push<void>(context, MaterialPageRoute(builder: (_) => RecepieDetails(r)))),
            ));
  }
}
